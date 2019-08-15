/*
Z88DK Z80 Macro Assembler

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk

Assembly macros.
*/

#include "input.h"
#include "macros.h"
#include "alloc.h"
#include "options.h"
#include "str.h"
#include "uthash.h"
#include "utlist.h"
#include "utils.h"
#include <ctype.h>

//-----------------------------------------------------------------------------
//	global config
//-----------------------------------------------------------------------------
#define Is_ident_prefix(x)	((x)=='.' || (x)=='#' || (x)=='$' || (x)=='%' || (x)=='@')
#define Is_ident_start(x)	(isalpha(x) || (x)=='_')
#define Is_ident_cont(x)	(isalnum(x) || (x)=='_')

#define SkipSpaces(p)		while (*(p) != '\n' && isspace(*(p))) (p)++;

//-----------------------------------------------------------------------------
//	#define macros
//-----------------------------------------------------------------------------
typedef struct Macro {
    const char*	name;					// string kept in strpool.h
    UT_array*	params;				// list of formal parameters
    UT_string*	text;					// replacement text
    bool		 expanding;				// true if inside macro expansion for this macro
    UT_hash_handle hh;      			// hash table
} Macro;

typedef struct Macros {
    Macro*	table;						// hash of macro name => Macro
    struct Macros* next;				// linked list
} Macros;

//-----------------------------------------------------------------------------
//	global data
//-----------------------------------------------------------------------------

static Macros* macros = NULL;			// top of macro stack
static Macro* last_def_macro = NULL;	// last #define macro defined, used by #defcont
static UT_array* in_lines = NULL;			// line stream from input
static UT_array* out_lines = NULL;		// line stream to ouput
static UT_string* current_line = NULL;	// current returned line
static bool in_defgroup;				// no EQU transformation in defgroup
static getline_t cur_getline_func = NULL; // callback to read a line from input
static FILE* preproc_fp = NULL;			// preprocessing output file

//-----------------------------------------------------------------------------
//	Macro ADT
//-----------------------------------------------------------------------------
static Macro* Macro_add(char* name) {
    Macro* elem;
    HASH_FIND(hh, macros->table, name, strlen(name), elem);
    if (elem)
        return NULL;		// duplicate

    elem = m_new(Macro);
    elem->name = str_pool_add(name);
    elem->params = utarray_str_alloc();
    elem->text = utstring_alloc();
    elem->expanding = false;
    HASH_ADD_KEYPTR(hh, macros->table, elem->name, strlen(name), elem);

    last_def_macro = elem;
    return elem;
}

static void Macro_delete_elem(Macro* elem) {
    if (elem) {
        utarray_free(elem->params);
        utstring_free(elem->text);
        HASH_DEL(macros->table, elem);
        m_free(elem);
    }

    last_def_macro = NULL;
}

static void Macro_delete(char* name) {
    Macro* elem;
    HASH_FIND(hh, macros->table, name, strlen(name), elem);
    Macro_delete_elem(elem);		// it is OK to undef a non-existing macro
}

// lookup macro in all tables
static Macro* Macro_lookup(char* name) {
    Macro* macro_elem;
    Macros* macros_elem = macros;
    while (macros_elem != NULL) {
        HASH_FIND(hh, macros_elem->table, name, strlen(name), macro_elem);
        if (macro_elem != NULL)
            return macro_elem;
        macros_elem = macros_elem->next;
    }
    return NULL;
}

static void Macros_push() {
    Macros* elem = m_new(Macros);
    elem->table = NULL;
    LL_PREPEND(macros, elem);
}

static void Macros_pop() {
    Macro* elem, * tmp;
    HASH_ITER(hh, macros->table, elem, tmp) {
        Macro_delete_elem(elem);
    }

    last_def_macro = NULL;

    Macros* head = macros;
    LL_DELETE(macros, head);
    m_free(head);
}

//-----------------------------------------------------------------------------
//	module API
//-----------------------------------------------------------------------------
static void free_macros(void);

void init_macros() {
    Macros_push();

    last_def_macro = NULL;
    in_defgroup = false;
    in_lines = utarray_str_alloc();
    out_lines = utarray_str_alloc();
    current_line = utstring_alloc();

    xatexit(free_macros);
}

static void clear_macros() {
    if (preproc_fp != NULL) {
        xfclose(preproc_fp);
        preproc_fp = NULL;
    }

    Macro* elem, *tmp;
    HASH_ITER(hh, macros->table, elem, tmp) {
        Macro_delete_elem(elem);
    }

    last_def_macro = NULL;
    in_defgroup = false;

    utarray_clear(in_lines);
    utarray_clear(out_lines);
    utstring_clear(current_line);
}

static void free_macros(void) {
    clear_macros();
    Macros_pop();

    utarray_free(in_lines);
    utarray_free(out_lines);
    utstring_free(current_line);
}

void init_preproc(const char* i_filename) {
    clear_macros();
    if (opts.opt_preprocess)
        preproc_fp = xfopen(i_filename, "w");
}

//-----------------------------------------------------------------------------
//	parser
//-----------------------------------------------------------------------------

static void macro_expand(Macro* macro, char** in_p, UT_string* out);
static bool collect_macro_call(char** in, UT_string* out);
static bool collect_number(char** in, UT_string* out);
static bool collect_stringize(char** in, UT_string* out);
static bool collect_concatenate(char** in, UT_string* out);

// fill input stream
static void fill_input() {
    if (utarray_len(in_lines) == 0) {
        if (cur_getline_func != NULL) {
            const char* line = cur_getline_func();
            if (line != NULL) {
                utarray_str_push_back(in_lines, line);
                if (preproc_fp) {
                    fprintf(preproc_fp, ";\tLINE %d, \"%s\"\n;\t%s",
                            in_location(LocationAsm).line_num, in_location(LocationAsm).filename,
                            line);
                }
            }
        }
    }
}

// extract first line from input_stream to current_line
static bool shift_lines(UT_array* lines) {
    utstring_clear(current_line);
    if (utarray_len(lines) > 0) {
        // copy first from stream
        char* line = *(char**)utarray_front(lines);
        utstring_set(current_line, line);
        utarray_erase(lines, 0, 1);
        return true;
    }
    else
        return false;
}

// collect a quoted string from input pointer to output string
static bool collect_quoted_string(char** p, UT_string* out) {
#define P (*p)
    if (*P == '\'' || *P == '"') {
        char q = *P; utstring_bincpy(out, P, 1); P++;
        while (*P != q && *P != '\0') {
            if (*P == '\\') {
                utstring_bincpy(out, P, 1); P++;
                if (*P != '\0') {
                    utstring_bincpy(out, P, 1); P++;
                }
            }
            else {
                utstring_bincpy(out, P, 1); P++;
            }
        }
        if (*P != '\0') {
            utstring_bincpy(out, P, 1); P++;
        }
        return true;
    }
    else
        return false;
#undef P
}

// collect a macro or argument name [\.\#]?[a-z_][a-z_0-9]*
static bool collect_name(char** in, UT_string* out) {
    char* p = *in;

    utstring_clear(out);
    SkipSpaces(p);

    if (Is_ident_prefix(p[0]) && Is_ident_start(p[1])) {
        utstring_bincpy(out, p, 2); p += 2;
        while (Is_ident_cont(*p)) { utstring_bincpy(out, p, 1); p++; }
        *in = p;
        return true;
    }
    else if (Is_ident_start(p[0])) {
        while (Is_ident_cont(*p)) { utstring_bincpy(out, p, 1); p++; }
        *in = p;
        return true;
    }
    else
        return false;
}

// collect formal parameters
static bool collect_formal_params1(char** p, Macro* macro, UT_string* param) {
#define P (*p)
    if (*P == '(') P++;
    else return true;			// (
    SkipSpaces(P);									// blanks
    if (*P == ')') { P++; return true; }			// )

    while (true) {
        if (!collect_name(&P, param)) return false;	// NAME
        utarray_str_push_back(macro->params, utstring_body(param));
        SkipSpaces(P);								// blanks

        if (*P == ')') { P++; return true; }		// )
        else if (*P == ',')  P++;  				// ,
        else  return false;
    }
#undef P
}

static bool collect_formal_params(char** p, Macro* macro) {
    UT_string* param = utstring_alloc();
    bool found = collect_formal_params1(p, macro, param);
    utstring_free(param);
    return found;
}

// collect macro arguments, define macros for each (a new scope has been created)
static bool collect_macro_argument_i(char** p, UT_string* text) {
#define P (*p)
    utstring_clear(text);

    SkipSpaces(P);
    if (*P == '<') {
        P++;
        char* end = P;
        while (*end != '>' && *end != '\n' && *end != '\0')
            end++;
        if (*end == '>') {
            utstring_bincpy(text, P, end - P);
            P = end + 1;
            return true;
        }
        else {
            P = end;
            error_missing_close_angle_bracket();
            return false;
        }
    }
    else {
        int open_parens = 0;

        while (*P != '\0' && *P != ';' && *P != '\n') {
            if (collect_number(&P, text)) {
            }
            else if (collect_macro_call(&P, text)) {
            }
            else if (collect_quoted_string(&P, text)) {
            }
            else if (collect_concatenate(&P, text)) {
            }
            else if (collect_stringize(&P, text)) {
            }
            else if (*P == '(') {
                utstring_bincpy(text, P, 1); P++;
                open_parens++;
            }
            else if (*P == ')') {
                if (open_parens == 0)
                    return true;
                else {
                    utstring_bincpy(text, P, 1); P++;
                    open_parens--;
                }
            }
            else if (*P == ',') {
                if (open_parens == 0)
                    return true;
                else {
                    utstring_bincpy(text, P, 1); P++;
                }
            }
            else {
                utstring_bincpy(text, P, 1); P++;
            }
        }

        if (open_parens != 0) {
            error_missing_close_paren();
            return false;
        }
        else
            return true;
    }
#undef P
}

static bool collect_macro_arguments1(char** p, Macro* macro, UT_string* text) {
#define P (*p)
    SkipSpaces(P);
    bool args_in_parens = false;
    if (*P == '(') {
        P++;
        SkipSpaces(P);
        args_in_parens = true;
    }

    for (size_t i = 0; i < utarray_len(macro->params); i++) {
        // check for empty parameter or end of list
        SkipSpaces(P);
        bool empty_param = false;
        if (*P == ',')
            empty_param = true;
        else {
            if (args_in_parens) {
                if (*P == ')')
                    empty_param = true;
            }
            else {
                if (*P == '\0' || *P == ';' || *P == '\n')
                    empty_param = true;
            }
        }

        // collect parameter value
        if (!empty_param) {
            if (!collect_macro_argument_i(p, text))
                return false;
            utstring_chomp(text);
        }
        else
            utstring_clear(text);

        // define macro in current scope
        Macro* param_macro = Macro_add(*(char**)utarray_safe_eltptr(macro->params, i));
        utstring_set(param_macro->text, utstring_body(text));

        // collect separator
        SkipSpaces(P);
        if (i != utarray_len(macro->params) - 1) {
            if (*P == ',')
                P++;
            else {
                error_missing_macro_arguments();
                return false;
            }
        }
    }

    SkipSpaces(P);
    if (args_in_parens) {
        if (*P == ')')
            P++;
        else
            error_missing_close_paren();
    }
    else {
        if (*P != '\0' && *P != ';' && *P != '\n')
            error_extra_macro_arguments();
    }
    return true;
#undef P
}

static bool collect_macro_arguments(char** p, Macro* macro) {
    UT_string* text = utstring_alloc();
    bool found = collect_macro_arguments1(p, macro, text);
    utstring_free(text);
    return found;
}

// collect macro text
static bool collect_macro_text1(char** p, Macro* macro, UT_string* text) {
#define P (*p)
    utstring_clear(text);
    SkipSpaces(P);
    while (*P != '\0' && *P != ';' && *P != '\n') {
        if (collect_quoted_string(&P, text)) {
        }
        else if (P[0] == '\\' && P[1] == '\n') {		// continuation line
            utstring_bincpy(text, " ", 1);
            fill_input();
            if (shift_lines(in_lines)) P = utstring_body(current_line);
            else P = "";
        }
        else {
            utstring_bincpy(text, P, 1); P++;
        }
    }
    utstring_chomp(text);
    if (utstring_len(macro->text) > 0)
        utstring_bincpy(macro->text, "\n", 1);
    utstring_concat(macro->text, text);

    return true;
#undef P
}

static bool collect_macro_text(char** p, Macro* macro) {
    UT_string* text = utstring_alloc();
    bool found = collect_macro_text1(p, macro, text);
    utstring_free(text);
    return found;
}

// collect white space up to end of line or comment
static bool collect_eol(char** p) {
#define P (*p)

    SkipSpaces(P);
    if (*P == ';' || *P == '\n' || *P == '\0')
        return true;
    else
        return false;

#undef P
}

// is this an identifier?
static bool collect_ident(char** in, char* ident) {
    char* p = *in;

    size_t idlen = strlen(ident);
    if (str_case_n_cmp(p, ident, idlen) == 0 && !Is_ident_cont(p[idlen])) {
        *in = p + idlen;
        return true;
    }
    return false;
}

// collect a possible macro name, expand if a macro exists
static bool collect_macro_call1(char** in, UT_string* out, UT_string* name) {
    char* p = *in;

    if (Is_ident_prefix(p[0]) && Is_ident_start(p[1])) {		// prefix, name
        collect_name(&p, name);
        Macro* macro = Macro_lookup(utstring_body(name));
        if (macro) {
            macro_expand(macro, &p, out);
            *in = p;
            return true;
        }
        else {													// try after prefix
            macro = Macro_lookup(utstring_body(name) + 1);
            if (macro) {
                utstring_bincpy(out, utstring_body(name), 1);
                macro_expand(macro, &p, out);
                *in = p;
                return true;
            }
        }
        return false;											// prefix-name is not a macro call
    }
    else if (Is_ident_start(p[0])) {							// name
        collect_name(&p, name);
        Macro* macro = Macro_lookup(utstring_body(name));
        if (macro) {
            macro_expand(macro, &p, out);
            *in = p;
            return true;
        }
        else {
            utstring_bincpy(out, utstring_body(name), utstring_len(name));
            *in = p;
            return true;
        }
    }
    else
        return false;
}

static bool collect_macro_call(char** in, UT_string* out) {
#define P (*in)
    UT_string* name = utstring_alloc();
    bool found = collect_macro_call1(in, out, name);
    utstring_free(name);
    return found;
#undef P
}

// collect string-ize '#' operator
static bool collect_stringize1(char** in, UT_string* out, UT_string* text) {
    char* p = *in + 1;	// '#' already matched
    SkipSpaces(p);

    // collect next token
    if (collect_macro_call(&p, text)) {
        *in = p;
        utstring_bincpy(out, "\"", 1);
        for (char* t = utstring_body(text); *t; t++) {
            if (*t == '"')
                utstring_bincpy(out, "\\\"", 2);
            else
                utstring_bincpy(out, t, 1);
        }
        utstring_bincpy(out, "\"", 1);
        return true;
    }
    else if (collect_number(&p, text)) {
        *in = p;
        utstring_printf(out, "\"%s\"", utstring_body(text));
        return true;
    }
    else
        return false;
}

static bool collect_stringize(char** in, UT_string* out) {
#define P (*in)
    if (*P == '#') {
        UT_string* text = utstring_alloc();
        bool found = collect_stringize1(in, out, text);
        utstring_free(text);
        return found;
    }
    else
        return false;
#undef P
}

// collect concatenate '##' operator
static bool collect_concatenate(char** in, UT_string* out) {
#define P (*in)
    if (P[0] == '#' && P[1] == '#') {
        P += 2;
        SkipSpaces(P);			// skip to next token
        utstring_chomp(out);	// remove blanks after previous token
        return true;
    }
    else
        return false;
#undef P
}


static bool collect_number(char** in, UT_string* out) {
#define P (*in)
    if (P[0] == '0' && tolower(P[1]) == 'x') {
        char* end = P + 2;
        while (isxdigit(*end)) end++;
        utstring_bincpy(out, P, end - P);
        P = end;
        return true;
    }
    else if (P[0] == '0' && tolower(P[1]) == 'b') {
        char* end = P + 2;
        while (isdigit(*end) && *end < '2') end++;
        utstring_bincpy(out, P, end - P);
        P = end;
        return true;
    }
    else if (P[0] == '0' && (tolower(P[1]) == 'q' || tolower(P[1]) == 'o')) {
        char* end = P + 2;
        while (isdigit(*end) && *end < '8') end++;
        utstring_bincpy(out, P, end - P);
        P = end;
        return true;
    }
    else if ((P[0] == '$' || P[0] == '#') && isxdigit(P[1])) {
        char* end = P + 1;
        char max_digit = '0';
        while (isalnum(*end)) {
            if (tolower(*end) > max_digit)
                max_digit = tolower(*end);
            end++;
        }
        if (max_digit <= 'f') {
            utstring_bincpy(out, P, end - P);
            P = end;
            return true;
        }
        else
            return false;
    }
    else if ((P[0] == '%' || P[0] == '@') && isdigit(P[1]) && P[1] < '2') {
        char* end = P + 1;
        char max_digit = '0';
        while (isalnum(*end)) {
            if (tolower(*end) > max_digit)
                max_digit = tolower(*end);
            end++;
        }
        if (max_digit <= '1') {
            utstring_bincpy(out, P, end - P);
            P = end;
            return true;
        }
        else
            return false;
    }
    else if (isdigit(P[0])) {
        char* end = P;
        char max_digit = '0';
        while (isalnum(*end)) {
            if (tolower(*end) > max_digit)
                max_digit = tolower(*end);
            end++;
        }
        if (max_digit <= '9') {
            utstring_bincpy(out, P, end - P);
            P = end;
            return true;
        }
        else if (max_digit == 'h') {
            bool all_hex = true;
            for (char* p = P; p < end; p++) {
                if (!isxdigit(*p))
                    all_hex = false;
            }
            if (all_hex) {
                utstring_bincpy(out, P, end - P);
                P = end;
                return true;
            }
            else
                return false;
        }
        else
            return false;
    }
    else
        return false;
#undef P
}

// is this a "NAME EQU xxx" or "NAME = xxx"?
static bool collect_equ(char** in, UT_string* name) {
    char* p = *in;

    SkipSpaces(p);

    if (in_defgroup) {
        while (*p != '\0' && *p != ';') {
            if (*p == '}') {
                in_defgroup = false;
                return false;
            }
            p++;
        }
    }
    else if (collect_name(&p, name)) {
        if (str_case_cmp(utstring_body(name), "defgroup") == 0) {
            in_defgroup = true;
            while (*p != '\0' && *p != ';') {
                if (*p == '}') {
                    in_defgroup = false;
                    return false;
                }
                p++;
            }
            return false;
        }

        if (utstring_body(name)[0] == '.') {			// old-style label
            // remove starting dot from name
            UT_string* temp;
            utstring_new(temp);
            utstring_printf(temp, "%s", &utstring_body(name)[1]);
            utstring_clear(name);
            utstring_concat(name, temp);
            utstring_free(temp);
        }
        else if (*p == ':') 							// colon after name
            p++;

        SkipSpaces(p);

        if (*p == '=') {
            *in = p + 1;
            return true;
        }
        else if (Is_ident_start(*p) && collect_ident(&p, "equ")) {
            *in = p;
            return true;
        }
    }
    return false;
}

// collect arguments and expand macro
static void macro_expand1(Macro* macro, char** in_p, UT_string* out, UT_string* name) {
    // collect macro arguments from in_p
#define P (*in_p)
    if (utarray_len(macro->params) > 0) {
        if (!collect_macro_arguments(&P, macro))
            return;
    }
#undef P

    // get macro text, expand sub-macros
    char* p = utstring_body(macro->text);
    while (*p != '\0') {
        if (collect_macro_call(&p, out)) {			// identifier
        }
        else if (collect_number(&p, out)) {			// number
        }
        else if (collect_quoted_string(&p, out)) {	// string
        }
        else if (collect_concatenate(&p, out)) {
        }
        else if (collect_stringize(&p, out)) {
        }
        else {
            utstring_bincpy(out, p, 1); p++;
        }
    }
}

static void macro_expand(Macro* macro, char** in_p, UT_string* out) {
    // avoid infinite recursion
    if (macro->expanding) {
        error_macro_recursion(macro->name);
        return;
    }
    macro->expanding = true;
    Macros_push();				// new scope to defino parameters as local macros

    UT_string* name = utstring_alloc();

    macro_expand1(macro, in_p, out, name);

    utstring_free(name);
    macro->expanding = false;
    Macros_pop();				// drop scope
}

// translate commands
static void translate_commands(char* in) {
    UT_string* out = utstring_alloc();
    UT_string* name = utstring_alloc();

    utstring_set(out, in);

    char* p = in;
    if (collect_equ(&p, name))
        utstring_set_printf(out, "defc %s = %s", utstring_body(name), p);

    if (utstring_len(out) > 0)
        utarray_str_push_back(out_lines, utstring_body(out));

    utstring_free(out);
    utstring_free(name);
}

// send commands to output after macro expansion
// split by newlines, parse each line for special commands to translate (e.g. EQU, '=')
static void send_to_output(char* text) {
    UT_string* line = utstring_alloc();
    char* p0 = text;
    char* p1;
    while ((p1 = strchr(p0, '\n')) != NULL) {
        utstring_clear(line);
        utstring_bincpy(line, p0, p1 + 1 - p0);
        translate_commands(utstring_body(line));
        p0 = p1 + 1;
    }
    if (*p0 != '\0')
        translate_commands(p0);
    utstring_free(line);
}

// parse #define
static bool collect_hash_define1(char* in, UT_string* name) {
    char* p = in;
    if (*p++ != '#')
        return false;
    if (!collect_ident(&p, "define"))
        return false;
    if (!collect_name(&p, name)) {
        error_syntax();
        return true;
    }

    // create macro, error if duplicate
    Macro* macro = Macro_add(utstring_body(name));
    if (!macro) {
        error_redefined_macro(utstring_body(name));
        return true;
    }

    // get macro params
    if (!collect_formal_params(&p, macro)) {
        error_syntax();
        return true;
    }

    // get macro text
    if (!collect_macro_text(&p, macro)) {
        error_syntax();
        return true;
    }

    return true;
}

static bool collect_hash_define(char* in) {
    UT_string* name = utstring_alloc();
    bool found = collect_hash_define1(in, name);
    utstring_free(name);
    return found;
}

// parse #defcont
static bool collect_hash_defcont1(char* in, UT_string* name) {
    char* p = in;
    if (*p++ != '#')
        return false;
    if (!collect_ident(&p, "defcont"))
        return false;
    if (!last_def_macro) {
        error_macro_defcont_without_define();
        return true;
    }
    if (!collect_macro_text(&p, last_def_macro)) {
        error_syntax();
        return true;
    }
    return true;
}

static bool collect_hash_defcont(char* in) {
    UT_string* name = utstring_alloc();
    bool found = collect_hash_defcont1(in, name);
    utstring_free(name);
    return found;
}

// parse #undef
static bool collect_hash_undef1(char* in, UT_string* name) {
    char* p = in;
    if (*p++ != '#')
        return false;
    if (!collect_ident(&p, "undef"))
        return false;
    if (!collect_name(&p, name)) {
        error_syntax();
        return true;
    }

    // assert end of line
    if (!collect_eol(&p)) {
        error_syntax();
        return true;
    }

    Macro_delete(utstring_body(name));		// delete if found, ignore if not found
    return true;
}

static bool collect_hash_undef(char* in) {
    UT_string* name = utstring_alloc();
    bool found = collect_hash_undef1(in, name);
    utstring_free(name);
    return found;
}

// parse #-any - ignore line
static bool collect_hash_any(char* in) {
    if (*in == '#')
        return true;
    else
        return false;
}

// expand macros in each input statement
static void statement_expand_macros(char* in) {
    UT_string* out = utstring_alloc();
    UT_string* name = utstring_alloc();

    int count_question = 0;
    int count_ident = 0;
    bool last_was_ident = false;

    char* p = in;
    while (*p != '\0') {
        if (collect_number(&p, out))
            last_was_ident = false;
        else if (collect_macro_call(&p, out)) {					// identifier
            // flags to identify ':' after first label
            count_ident++;
            last_was_ident = true;
        }
        else if (collect_quoted_string(&p, out)) 				// string
            last_was_ident = false;
        else if (collect_concatenate(&p, out))
            last_was_ident = false;
        else if (collect_stringize(&p, out))
            last_was_ident = false;
        else if (*p == ';') {
            utstring_bincpy(out, "\n", 1); p += strlen(p);			// skip comments
            last_was_ident = false;
        }
        else if (*p == '\\') {									// statement separator
            p++;
            utstring_bincpy(out, "\n", 1);
            send_to_output(utstring_body(out));
            statement_expand_macros(p); p += strlen(p);			// recurse for next satetement in line
            utstring_clear(out);
            last_was_ident = false;
        }
        else if (*p == '?') {
            utstring_bincpy(out, p, 1); p++;
            count_question++;
            last_was_ident = false;
        }
        else if (*p == ':') {
            if (count_question > 0) {						// part of a ?: expression
                utstring_bincpy(out, p, 1); p++;
                count_question--;
            }
            else if (last_was_ident && count_ident == 1) {	// label marker
                utstring_bincpy(out, p, 1); p++;
            }
            else {											// statement separator
                p++;
                utstring_bincpy(out, "\n", 1);
                send_to_output(utstring_body(out));
                statement_expand_macros(p); p += strlen(p);	// recurse for next satetement in line
                utstring_clear(out);
            }
            last_was_ident = false;
        }
        else {
            utstring_bincpy(out, p, 1); p++;
            last_was_ident = false;
        }
    }
    send_to_output(utstring_body(out));

    utstring_free(out);
    utstring_free(name);
}

// parse #define, #undef and expand macros
static void parse() {
    char* in = utstring_body(current_line);
    if (collect_hash_define(in))
        return;
    else if (collect_hash_undef(in))
        return;
    else if (collect_hash_defcont(in))
        return;
    else if (collect_hash_any(in))
        return;
    else {
        // expand macros in each input statement
        statement_expand_macros(in);
    }
}

// get line and call parser
const char* macros_getline1() {
    while (true) {
        if (shift_lines(out_lines))
            return utstring_body(current_line);

        fill_input();
        if (!shift_lines(in_lines))
            return NULL;			// end of input

        parse();					// parse current_line, leave output in out_lines
    }
}

const char* macros_getline(getline_t getline_func) {
    cur_getline_func = getline_func;
    const char* line = macros_getline1();
    cur_getline_func = NULL;

    if (line != NULL && preproc_fp != NULL) {
        fprintf(preproc_fp, "\tLINE %d, \"%s\"\n\t%s",
                in_location(LocationAsm).line_num, in_location(LocationAsm).filename,
                line);
    }

    return line;
}

