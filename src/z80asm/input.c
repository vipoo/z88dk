//-----------------------------------------------------------------------------
// z80asm assembler
// Read input
// Copyright (C) Paulo Custodio, 2011-2019
// License: http://www.perlfoundation.org/artistic_license_2_0
// Repository: https://github.com/z88dk/z88dk
//-----------------------------------------------------------------------------

#include "input.h"
#include "codearea.h"
#include "listfile.h"
#include "macros.h"
#include "options.h"
#include "utils.h"

#include "utstring.h"
#include "utlist.h"

#include <assert.h>
#include <stdio.h>

//---------- LOCAL TYPES ----------//

// input level
typedef struct input_s {
    FILE*		file;
    Location	asm_location;
    UT_string*	line;
    bool		eof;

    struct input_s* next;		// next in stack
} Input;

//---------- STATIC DATA ----------//

// input status
static Location g_locations[LocationMAX];
static Input* g_input = NULL;

// error status
static int g_error_count = 0;
static FILE* g_error_file = NULL;
static const char* g_error_filename = NULL;

//---------- INIT ----------//

static void in_close(void);

static void fini(void) {
    in_close();
    error_close_file();
}

static void init(void) {
    static bool inited = false;
    if (!inited) {
        inited = true;

        xatexit(fini);
    }
}

//---------- READ FILES ----------//

static Input* Input_new(void) {
    Input* self = xnew(Input);		// init to 0
    utstring_new(self->line);
    return self;
}

static void Input_free(Input* self) {
    if (self->file)
        xfclose(self->file);

    utstring_free(self->line);
    xfree(self);
}

void in_push(void) {
    init();

    Input* input = Input_new();
    LL_PREPEND(g_input, input);
}

void in_pop(void) {
    init();

    if (g_input) {
        Input* head = g_input;
        LL_DELETE(g_input, head);
        Input_free(head);
    }

    if (g_input)
        g_locations[LocationAsm] = g_input->asm_location;
    else
        in_clear_locations();

}

static bool in_file_in_stack(const char* filename) {
    Input* elem = g_input;
    while (elem != NULL) {
        if (elem->asm_location.filename)
            if (strcmp(filename, elem->asm_location.filename) == 0)
                return true;
        elem = elem->next;
    }
    return false;
}

bool in_open(const char* filename) {
    init();

    if (!g_input)
        return false;

    // close file if open
    if (g_input->file) {
        xfclose(g_input->file);
        g_input->file = NULL;
    }

    // search file in include path
    const char* found_filename = str_pool_add(path_search(filename, opts.inc_path));

    // check for recursive includes, return false if found
    if (in_file_in_stack(found_filename)) {
        error("cannot include '%s' recursively", filename);
        return false;
    }

    // try to open the file, error if cannot (binary mode for cross-platform eols)
    FILE* file = fopen(found_filename, "rb");
    if (!file) {
        error("cannot open '%s'", filename);
        return false;
    }

    // start a new input scope
    g_input->file = file;
    g_input->asm_location = (Location) { found_filename, 0 };
    g_locations[LocationAsm] = g_input->asm_location;

    return true;
}

const char* in_getline(void) {
    init();
    if (!g_input) return NULL;			// no file in stack
    if (!g_input->file) return NULL;	// file not open

    utstring_clear(g_input->line);		// clear result string

    // read until end-of-line
    int c1, c2;
    char c;
    bool found_newline = false;
    while (!found_newline && (c1 = getc(g_input->file)) != EOF) {
        switch (c1) {
        case '\r':
            c2 = getc(g_input->file);
            if (c2 != '\n' && c2 != EOF)
                ungetc(c2, g_input->file);
            c1 = '\n';
        // fall through
        case '\n':
            found_newline = true;
        // fall through
        default:
            c = (char)c1;
            utstring_bincpy(g_input->line, &c, 1);
        }
    }

    // terminate string
    if (utstring_len(g_input->line) > 0 && !found_newline)
        utstring_bincpy(g_input->line, "\n", 1);

    // next line number, even if end of file
    g_input->asm_location.line_num++;
    g_locations[LocationAsm] = g_input->asm_location;

    if (utstring_len(g_input->line) > 0)
        return utstring_body(g_input->line);
    else {
        xfclose(g_input->file);
        g_input->file = NULL;
        return NULL;
    }
}

static void in_close(void) {
    while (g_input)
        in_pop();
}

Location in_location(LocationType type) {
    return g_locations[type];
}

void in_set_location(LocationType type, Location location) {
    g_locations[type] = location;
    if (g_input)
        if (type == LocationAsm)
            g_input->asm_location = location;
}

void in_clear_locations(void) {
    memset(g_locations, 0, sizeof(g_locations));
}

//---------- ERRORS ----------//

void _error(const char* prefix, const char* fmt, va_list ap) {
    init();

    UT_string* msg;
    utstring_new(msg);
    utstring_printf(msg, "%s", prefix);

    // output filenames
    bool file_emitted = false;
    for (LocationType type = (LocationType)0; type < LocationMAX; type++) {
        Location* location = &g_locations[type];

        if (location->filename != NULL && *location->filename != '\0') {
            if (file_emitted)
                utstring_printf(msg, ",");
            else
                utstring_printf(msg, " at");
            file_emitted = true;

            utstring_printf(msg, " '%s'", location->filename);
            if (location->line_num > 0)
                utstring_printf(msg, " line %d", location->line_num);
        }
    }

    utstring_printf(msg, ": ");

    // output error message
    utstring_printf_va(msg, fmt, ap);
    utstring_printf(msg, "\n");

    // send to stderr and error file
    fputs(utstring_body(msg), stderr);
    if (g_error_file)
        fputs(utstring_body(msg), g_error_file);

    utstring_free(msg);
}

void error(const char* fmt, ...) {
    init();

    va_list ap;
    va_start(ap, fmt);
    _error("Error", fmt, ap);
    g_error_count++;
    va_end(ap);
}

void warn(const char* fmt, ...) {
    init();

    va_list ap;
    va_start(ap, fmt);
    _error("Warning", fmt, ap);
    va_end(ap);
}

void error_open_file(const char* filename) {
    init();

    error_close_file();
    g_error_filename = str_pool_add(filename);
    g_error_file = xfopen(g_error_filename, "a");
}

void error_close_file(void) {
    init();

    // close current file if any
    if (g_error_file) {
        xfclose(g_error_file);

        // delete file if empty
        if (g_error_filename != NULL && file_size(g_error_filename) == 0)
            remove(g_error_filename);
    }

    // reset
    g_error_file = NULL;
    g_error_filename = NULL;        // filename kept in strpool, no leak
}

void error_clear(void) {
    g_error_count = 0;
}

int error_count(void) {
    return g_error_count;
}

//---------- OLD INTERFACE ----------//

// emit errors
#define X(type,func,params,fmt_args)			\
	void func(params) {							\
		UT_string* msg;							\
		utstring_new(msg);						\
		utstring_printf(msg, fmt_args);			\
		if (type == ErrWarn)					\
			warn("%s", utstring_body(msg));		\
		else									\
			error("%s", utstring_body(msg));	\
		utstring_free(msg);						\
	}
#include "errors_def.h"

//---------- OLD INTERFACE ----------//
static const char* src_getline1(void) {
    next_PC();							// update assembler program counter
    list_end_line();					// end pending list from previous input line

    const char* line = in_getline();	// read next input from file

    if (opts.cur_list) {				// interface with list
        if (line) {
            list_start_line(get_phased_PC() >= 0 ? get_phased_PC() : get_PC(),
                            in_location(LocationAsm).filename, in_location(LocationAsm).line_num, line);
        }
        else {
            if (!g_input->eof) {		// first time a NULL is retrieved - show last list line
                list_start_line(get_phased_PC() >= 0 ? get_phased_PC() : get_PC(),
                                in_location(LocationAsm).filename, in_location(LocationAsm).line_num, "");
                list_end_line();

                g_input->eof = true;
            }
        }
    }

    return line;
}

const char* in_getline_asm() {
    return macros_getline(src_getline1);
}
