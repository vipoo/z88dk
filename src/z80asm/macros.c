/*
Z88DK Z80 Macro Assembler

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk

Assembly macros.
*/

#include "macros.h"
#include "alloc.h"
#include "errors.h"
#include "options.h"
#include "str.h"
#include "strutil.h"
#include "uthash.h"
#include "utlist.h"
#include "types.h"
#include "die.h"
#include <ctype.h>

//-----------------------------------------------------------------------------
//	global config
//-----------------------------------------------------------------------------
bool macros_active = true;

#define Is_ident_prefix(x)	((x)=='.' || (x)=='#' || (x)=='$' || (x)=='%' || (x)=='@')
#define Is_ident_start(x)	(isalpha(x) || (x)=='_')
#define Is_ident_cont(x)	(isalnum(x) || (x)=='_')

#define SkipSpaces(p)		while (*(p) != '\n' && isspace(*(p))) (p)++;

//-----------------------------------------------------------------------------
//	#define macros
//-----------------------------------------------------------------------------
typedef struct Macro
{
	const char	*name;					// string kept in strpool.h
	argv_t		*params;				// list of formal parameters
	str_t		*text;					// replacement text
	bool		 expanding;				// true if inside macro expansion for this macro
	UT_hash_handle hh;      			// hash table
} Macro;

typedef struct Macros
{
	Macro	*table;						// hash of macro name => Macro
	struct Macros* next;				// linked list
} Macros;

//-----------------------------------------------------------------------------
//	global data
//-----------------------------------------------------------------------------

static Macros* macros = NULL;			// top of macro stack
static Macro* last_def_macro = NULL;	// last #define macro defined, used by #defcont
static argv_t* in_lines = NULL;			// line stream from input
static argv_t* out_lines = NULL;		// line stream to ouput
static str_t* current_line = NULL;		// current returned line
static bool in_defgroup;				// no EQU transformation in defgroup
static getline_t cur_getline_func = NULL; // callback to read a line from input
static FILE* preproc_fp = NULL;			// preprocessing output file

//-----------------------------------------------------------------------------
//	Macro ADT
//-----------------------------------------------------------------------------
static Macro* Macro_add(char* name)
{
	Macro* elem;
	HASH_FIND(hh, macros->table, name, strlen(name), elem);
	if (elem)
		return NULL;		// duplicate

	elem = m_new(Macro);
	elem->name = spool_add(name);
	elem->params = argv_new();
	elem->text = str_new();
	elem->expanding = false;
	HASH_ADD_KEYPTR(hh, macros->table, elem->name, strlen(name), elem);

	last_def_macro = elem;
	return elem;
}

static void Macro_delete_elem(Macro *elem)
{
	if (elem) {
		argv_free(elem->params);
		str_free(elem->text);
		HASH_DEL(macros->table, elem);
		m_free(elem);
	}

	last_def_macro = NULL;
}

static void Macro_delete(char *name)
{
	Macro *elem;
	HASH_FIND(hh, macros->table, name, strlen(name), elem);
	Macro_delete_elem(elem);		// it is OK to undef a non-existing macro
}

// lookup macro in all tables
static Macro *Macro_lookup(char *name)
{
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

static void Macros_push()
{
	Macros* elem = m_new(Macros);
	elem->table = NULL;
	LL_PREPEND(macros, elem);
}

static void Macros_pop()
{
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

void init_macros()
{
	Macros_push();

	last_def_macro = NULL;
	in_defgroup = false;
	in_lines = argv_new();
	out_lines = argv_new();
	current_line = str_new();

	xatexit(free_macros);
}

static void clear_macros()
{
	if (preproc_fp != NULL) {
		xfclose(preproc_fp);
		preproc_fp = NULL;
	}

	Macro *elem, *tmp;
	HASH_ITER(hh, macros->table, elem, tmp) {
		Macro_delete_elem(elem);
	}

	last_def_macro = NULL;
	in_defgroup = false;

	argv_clear(in_lines);
	argv_clear(out_lines);
	str_clear(current_line);
}

static void free_macros(void)
{
	clear_macros();
	Macros_pop();

	argv_free(in_lines);
	argv_free(out_lines);
	str_free(current_line);
}

void init_preproc(const char* i_filename)
{
	clear_macros();
	if (opts.opt_preprocess) {
		preproc_fp = xfopen(i_filename, "w");
	}
}

//-----------------------------------------------------------------------------
//	parser
//-----------------------------------------------------------------------------

static void macro_expand(Macro* macro, char** in_p, str_t* out);
static bool collect_macro_call(char** in, str_t* out);
static bool collect_number(char** in, str_t* out);
static bool collect_stringize(char** in, str_t* out);
static bool collect_concatenate(char** in, str_t* out);

// fill input stream
static void fill_input()
{
	if (argv_len(in_lines) == 0) {
		if (cur_getline_func != NULL) {
			char* line = cur_getline_func();
			if (line != NULL) {
				argv_push(in_lines, line);
				if (preproc_fp) {
					fprintf(preproc_fp, ";\tLINE %d, \"%s\"\n;\t%s",
						get_error_line(), get_error_file(),
						line);
				}
			}
		}
	}
}

// extract first line from input_stream to current_line
static bool shift_lines(argv_t *lines)
{
	str_clear(current_line);
	if (argv_len(lines) > 0) {
		// copy first from stream
		char *line = *argv_front(lines);
		str_set(current_line, line);
		argv_shift(lines);
		return true;
	}
	else
		return false;
}

// collect a quoted string from input pointer to output string
static bool collect_quoted_string(char** p, str_t* out)
{
#define P (*p)
	if (*P == '\'' || *P == '"') {
		char q = *P; str_append_n(out, P, 1); P++;
		while (*P != q && *P != '\0') {
			if (*P == '\\') {
				str_append_n(out, P, 1); P++;
				if (*P != '\0') {
					str_append_n(out, P, 1); P++;
				}
			}
			else {
				str_append_n(out, P, 1); P++;
			}
		}
		if (*P != '\0') {
			str_append_n(out, P, 1); P++;
		}
		return true;
	}
	else
		return false;
#undef P
}

// collect a macro or argument name [\.\#]?[a-z_][a-z_0-9]*
static bool collect_name(char **in, str_t *out)
{
	char *p = *in;

	str_clear(out);
	SkipSpaces(p);

	if (Is_ident_prefix(p[0]) && Is_ident_start(p[1])) {
		str_append_n(out, p, 2); p += 2;
		while (Is_ident_cont(*p)) { str_append_n(out, p, 1); p++; }
		*in = p;
		return true;
	}
	else if (Is_ident_start(p[0])) {
		while (Is_ident_cont(*p)) { str_append_n(out, p, 1); p++; }
		*in = p;
		return true;
	}
	else {
		return false;
	}
}

// collect formal parameters
static bool collect_formal_params1(char** p, Macro* macro, str_t* param)
{
#define P (*p)
	if (*P == '(') P++; else return true;			// (
	SkipSpaces(P);									// blanks
	if (*P == ')') { P++; return true; }			// )
	
	while (true) {
		if (!collect_name(&P, param)) return false;	// NAME
		argv_push(macro->params, str_data(param));
		SkipSpaces(P);								// blanks
	
		if (*P == ')') { P++; return true; }		// )
		else if (*P == ',') { P++; }				// ,
		else { return false; }
	}
#undef P
}

static bool collect_formal_params(char **p, Macro *macro)
{
	str_t* param = str_new();
	bool found = collect_formal_params1(p, macro, param);
	str_free(param);
	return found;
}

// collect macro arguments, define macros for each (a new scope has been created)
static bool collect_macro_argument_i(char** p, str_t* text)
{
#define P (*p)
	str_clear(text);

	SkipSpaces(P);
	if (*P == '<') {
		P++;
		char* end = P;
		while (*end != '>' && *end != '\n' && *end != '\0')
			end++;
		if (*end == '>') {
			str_append_n(text, P, end - P);
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
				str_append_n(text, P, 1); P++;
				open_parens++;
			}
			else if (*P == ')') {
				if (open_parens == 0)
					return true;
				else {
					str_append_n(text, P, 1); P++;
					open_parens--;
				}
			}
			else if (*P == ',') {
				if (open_parens == 0)
					return true;
				else {
					str_append_n(text, P, 1); P++;
				}
			}
			else {
				str_append_n(text, P, 1); P++;
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

static bool collect_macro_arguments1(char** p, Macro* macro, str_t* text)
{
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
		if (*P == ',') {
			empty_param = true;
		}
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
			str_chomp(text);
		}
		else
			str_clear(text);

		// define macro in current scope
		Macro* param_macro = Macro_add(argv_get(macro->params, i));
		str_set_str(param_macro->text, text);

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

static bool collect_macro_arguments(char** p, Macro* macro)
{
	str_t* text = str_new();
	bool found = collect_macro_arguments1(p, macro, text);
	str_free(text);
	return found;
}

// collect macro text
static bool collect_macro_text1(char** p, Macro* macro, str_t* text)
{
#define P (*p)
	str_clear(text);
	SkipSpaces(P);
	while (*P != '\0' && *P != ';' && *P != '\n') {
		if (collect_quoted_string(&P, text)) {
		}
		else if (P[0] == '\\' && P[1] == '\n') {		// continuation line
			str_append_n(text, " ", 1);
			fill_input();
			if (shift_lines(in_lines)) P = str_data(current_line); else P = "";
		}
		else {
			str_append_n(text, P, 1); P++;
		}
	}
	str_chomp(text);
	if (str_len(macro->text) > 0)
		str_append_n(macro->text, "\n", 1);
	str_append_str(macro->text, text);

	return true;
#undef P
}

static bool collect_macro_text(char **p, Macro *macro)
{
	str_t* text = str_new();
	bool found = collect_macro_text1(p, macro, text);
	str_free(text);
	return found;
}

// collect white space up to end of line or comment
static bool collect_eol(char **p)
{
#define P (*p)

	SkipSpaces(P);
	if (*P == ';' || *P == '\n' || *P == '\0')
		return true;
	else
		return false;

#undef P
}

// is this an identifier?
static bool collect_ident(char **in, char *ident)
{
	char *p = *in;

	size_t idlen = strlen(ident);
	if (cstr_case_ncmp(p, ident, idlen) == 0 && !Is_ident_cont(p[idlen])) {
		*in = p + idlen;
		return true;
	}
	return false;
}

// collect a possible macro name, expand if a macro exists
static bool collect_macro_call1(char** in, str_t* out, str_t* name)
{
	char* p = *in;

	if (Is_ident_prefix(p[0]) && Is_ident_start(p[1])) {		// prefix, name
		collect_name(&p, name);
		Macro* macro = Macro_lookup(str_data(name));
		if (macro) {
			macro_expand(macro, &p, out);
			*in = p;
			return true;
		}
		else {													// try after prefix
			macro = Macro_lookup(str_data(name) + 1);
			if (macro) {
				str_append_n(out, str_data(name), 1);
				macro_expand(macro, &p, out);
				*in = p;
				return true;
			}
		}
		return false;											// prefix-name is not a macro call
	}
	else if (Is_ident_start(p[0])) {							// name
		collect_name(&p, name);
		Macro* macro = Macro_lookup(str_data(name));
		if (macro) {
			macro_expand(macro, &p, out);
			*in = p;
			return true;
		}
		else {
			str_append_n(out, str_data(name), str_len(name));
			*in = p;
			return true;
		}
	}
	else
		return false;
}

static bool collect_macro_call(char** in, str_t* out)
{
#define P (*in)
	str_t* name = str_new();
	bool found = collect_macro_call1(in, out, name);
	str_free(name);
	return found;
#undef P
}

// collect string-ize '#' operator
static bool collect_stringize1(char** in, str_t* out, str_t* text)
{
	char* p = *in + 1;	// '#' already matched
	SkipSpaces(p);

	// collect next token
	if (collect_macro_call(&p, text)) {
		*in = p;
		str_append_n(out, "\"", 1);
		for (char* t = str_data(text); *t; t++) {
			if (*t == '"')
				str_append_n(out, "\\\"", 2);
			else
				str_append_n(out, t, 1);
		}
		str_append_n(out, "\"", 1);
		return true;
	}
	else if (collect_number(&p, text)) {
		*in = p;
		str_append_n(out, "\"", 1);
		str_append(out, str_data(text));
		str_append_n(out, "\"", 1);
		return true;
	}
	else
		return false;
}

static bool collect_stringize(char** in, str_t* out)
{
#define P (*in)
	if (*P == '#') {
		str_t* text = str_new();
		bool found = collect_stringize1(in, out, text);
		str_free(text);
		return found;
	}
	else
		return false;
#undef P
}

// collect concatenate '##' operator
static bool collect_concatenate(char** in, str_t* out)
{
#define P (*in)
	if (P[0] == '#' && P[1]=='#') {
		P += 2;
		SkipSpaces(P);		// skip to next token
		str_chomp(out);		// remove blanks after previous token
		return true;
	}
	else
		return false;
#undef P
}


static bool collect_number(char** in, str_t* out)
{
#define P (*in)
	if (P[0] == '0' && tolower(P[1]) == 'x') {
		char* end = P + 2;
		while (isxdigit(*end)) end++;
		str_append_n(out, P, end - P);
		P = end;
		return true;
	}
	else if (P[0] == '0' && tolower(P[1]) == 'b') {
		char* end = P + 2;
		while (isdigit(*end) && *end < '2') end++;
		str_append_n(out, P, end - P);
		P = end;
		return true;
	}
	else if (P[0] == '0' && (tolower(P[1]) == 'q' || tolower(P[1]) == 'o')) {
		char* end = P + 2;
		while (isdigit(*end) && *end < '8') end++;
		str_append_n(out, P, end - P);
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
			str_append_n(out, P, end - P);
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
			str_append_n(out, P, end - P);
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
			str_append_n(out, P, end - P);
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
				str_append_n(out, P, end - P);
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
static bool collect_equ(char **in, str_t *name)
{
	char *p = *in;

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
		if (cstr_case_cmp(str_data(name), "defgroup") == 0) {
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
			str_t *temp;
			utstring_new(temp);
			utstring_printf(temp, "%s", &utstring_body(name)[1]);
			utstring_clear(name);
			utstring_concat(name, temp);
			utstring_free(temp);
		}
		else if (*p == ':') {							// colon after name
			p++;
		}

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
static void macro_expand1(Macro* macro, char** in_p, str_t* out, str_t* name)
{
	// collect macro arguments from in_p
#define P (*in_p)
	if (utarray_len(macro->params) > 0) {
		if (!collect_macro_arguments(&P, macro))
			return;
	}
#undef P

	// get macro text, expand sub-macros
	char* p = str_data(macro->text);
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
			str_append_n(out, p, 1); p++;
		}
	}
}

static void macro_expand(Macro *macro, char **in_p, str_t *out)
{
	// avoid infinite recursion
	if (macro->expanding) {
		error_macro_recursion(macro->name);
		return;
	}
	macro->expanding = true;
	Macros_push();				// new scope to defino parameters as local macros

	str_t* name = str_new();

	macro_expand1(macro, in_p, out, name);

	str_free(name);
	macro->expanding = false;
	Macros_pop();				// drop scope
}

// translate commands  
static void translate_commands(char* in)
{
	str_t* out = str_new();
	str_t* name = str_new();
	
	str_set(out, in);

	char* p = in;
	if (collect_equ(&p, name)) {
		str_set_f(out, "defc %s = %s", str_data(name), p);
	}

	if (str_len(out) > 0) {
		argv_push(out_lines, str_data(out));
	}
	
	str_free(out);
	str_free(name);
}

// send commands to output after macro expansion
// split by newlines, parse each line for special commands to translate (e.g. EQU, '=')
static void send_to_output(char* text)
{
	str_t* line = str_new();
	char* p0 = text;
	char* p1;
	while ((p1 = strchr(p0, '\n')) != NULL) {
		str_set_n(line, p0, p1 + 1 - p0);
		translate_commands(str_data(line));
		p0 = p1 + 1;
	}
	if (*p0 != '\0')
		translate_commands(p0);
	str_free(line);
}

// parse #define
static bool collect_hash_define1(char* in, str_t* name)
{
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
	Macro* macro = Macro_add(str_data(name));
	if (!macro) {
		error_redefined_macro(str_data(name));
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

static bool collect_hash_define(char* in)
{
	str_t* name = str_new();
	bool found = collect_hash_define1(in, name);
	str_free(name);
	return found;
}

// parse #defcont
static bool collect_hash_defcont1(char* in, str_t* name)
{
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

static bool collect_hash_defcont(char* in)
{
	str_t* name = str_new();
	bool found = collect_hash_defcont1(in, name);
	str_free(name);
	return found;
}

// parse #undef
static bool collect_hash_undef1(char* in, str_t* name)
{
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

	Macro_delete(str_data(name));		// delete if found, ignore if not found
	return true;
}

static bool collect_hash_undef(char* in)
{
	str_t* name = str_new();
	bool found = collect_hash_undef1(in, name);
	str_free(name);
	return found;
}

// parse #-any - ignore line
static bool collect_hash_any(char* in)
{
	if (*in == '#')
		return true;
	else
		return false;
}

// expand macros in each input statement
static void statement_expand_macros(char* in)
{
	str_t* out = str_new();
	str_t* name = str_new();

	int count_question = 0;
	int count_ident = 0;
	bool last_was_ident = false;

	char* p = in;
	while (*p != '\0') {
		if (collect_number(&p, out)) {
			last_was_ident = false;
		}
		else if (collect_macro_call(&p, out)) {					// identifier
			// flags to identify ':' after first label
			count_ident++;
			last_was_ident = true;
		}
		else if (collect_quoted_string(&p, out)) {				// string
			last_was_ident = false;
		}
		else if (collect_concatenate(&p, out)) {
			last_was_ident = false;
		}
		else if (collect_stringize(&p, out)) {
			last_was_ident = false;
		}
		else if (*p == ';') {
			str_append_n(out, "\n", 1); p += strlen(p);			// skip comments
			last_was_ident = false;
		}
		else if (*p == '\\') {									// statement separator
			p++;
			str_append_n(out, "\n", 1);
			send_to_output(str_data(out));
			statement_expand_macros(p); p += strlen(p);			// recurse for next satetement in line
			str_clear(out);
			last_was_ident = false;
		}
		else if (*p == '?') {
			str_append_n(out, p, 1); p++;
			count_question++;
			last_was_ident = false;
		}
		else if (*p == ':') {
			if (count_question > 0) {						// part of a ?: expression
				str_append_n(out, p, 1); p++;
				count_question--;
			}
			else if (last_was_ident && count_ident == 1) {	// label marker
				str_append_n(out, p, 1); p++;
			}
			else {											// statement separator
				p++;
				str_append_n(out, "\n", 1);
				send_to_output(str_data(out));
				statement_expand_macros(p); p += strlen(p);	// recurse for next satetement in line
				str_clear(out);
			}
			last_was_ident = false;
		}
		else {
			str_append_n(out, p, 1); p++;
			last_was_ident = false;
		}
	}
	send_to_output(str_data(out));

	str_free(out);
	str_free(name);
}

// parse #define, #undef and expand macros
static void parse()
{
	char* in = str_data(current_line);
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
char* macros_getline1()
{
	while (true) {
		if (shift_lines(out_lines)) 
			return str_data(current_line);

		fill_input();
		if (!shift_lines(in_lines)) 
			return NULL;			// end of input

		parse();					// parse current_line, leave output in out_lines
	}
}

char *macros_getline(getline_t getline_func)
{
	if (macros_active) {
		cur_getline_func = getline_func;
		char* line = macros_getline1();
		cur_getline_func = NULL;

		if (line != NULL && preproc_fp != NULL) {
			fprintf(preproc_fp, "\tLINE %d, \"%s\"\n\t%s",
				get_error_line(), get_error_file(),
				line);
		}

		return line;
	}
	else {
		return getline_func();
	}
}

