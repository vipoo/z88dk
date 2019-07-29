/*
Z88DK Z80 Macro Assembler

Preprocessor

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "asmpp.h"
#include "codearea.h"
#include "errors.h"
#include "fileutil.h"
#include "listfile.h"
#include "macros.h"
#include "options.h"
#include "utils.h"

#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <utlist.h>
#include <utstring.h>

//-----------------------------------------------------------------------------
// local types
//-----------------------------------------------------------------------------
typedef struct input_t {
	FILE*		file;
	location_t	location;
	UT_string*	line;
	bool		eof;

	struct input_t* next;		// next in stack
} input_t;

//-----------------------------------------------------------------------------
// global data
//-----------------------------------------------------------------------------
location_t g_asm_location, g_c_location;

// static data
static input_t* g_input = NULL;

//-----------------------------------------------------------------------------
// initialize
//-----------------------------------------------------------------------------
static void pp_pop_all();

static void pp_deinit(void)
{
	pp_pop_all();
}

static void pp_init()
{
	static bool inited = false;
	if (!inited) {
		atexit(pp_deinit);
		inited = true;
	}
}

//-----------------------------------------------------------------------------
// input from file
//-----------------------------------------------------------------------------
bool pp_file_in_stack(const char* filename);

location_t pp_get_current_location()
{
	if (g_input)
		return g_input->location;
	else
		return (location_t) { NULL, 0 };
}

void pp_set_current_location(location_t location)
{
	if (g_input)
		g_input->location = location;
}

void pp_clear_locations()
{
	g_asm_location = (location_t){ NULL,0 };
	g_c_location = (location_t){ NULL,0 };
}

void pp_push()
{
	pp_init();

	input_t* elem = xcalloc(1, sizeof(input_t));
	elem->file = NULL;
	elem->location.filename	= NULL;
	elem->location.line_num	= 0;
	elem->eof = false;
	utstring_new(elem->line);
	LL_PREPEND(g_input, elem);
}

void pp_pop()
{
	if (g_input) {
		input_t* elem = g_input;
		LL_DELETE(g_input, elem);
		
		if (elem->file) fclose(elem->file);
		utstring_free(elem->line);
		xfree(elem);
	}

	if (!g_input) {			// if stack is now empty
		g_asm_location = (location_t){ NULL,0 };
		g_c_location = (location_t){ NULL,0 };
	}
}

bool pp_open(const char* filename)
{
	if (!g_input) 					// not initialized
		return false;

	if (g_input->file) 				// file is open
		fclose(g_input->file);

	// search file in include path
	const char* filename_found = str_pool_add(path_search(filename, opts.inc_path));

	// check for recursive includes, return false if found
	if (pp_file_in_stack(filename_found)) {
		error_include_recursion(filename);
		return false;
	}

	// try to open the file, error if cannot (binary mode for cross-platform eols)
	FILE* file = fopen(filename_found, "rb");
	if (!file) {
		error_read_file(filename);
		return false;
	}

	// init current level
	g_input->file = file;
	g_input->location = (location_t){ filename_found, 0 };

	return true;
}

static void pp_pop_all()
{
	while (g_input)
		pp_pop();
}

bool pp_file_in_stack(const char* filename)
{
	input_t* p = g_input;
	while (p != NULL) {
		if (p->location.filename)
			if (strcmp(filename, p->location.filename) == 0)
				return true;
		p = p->next;
	}
	return false;
}

char* pp_getline()
{
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

	if (utstring_len(g_input->line) > 0) {
		g_input->location.line_num++;
		g_asm_location = g_input->location;
		return utstring_body(g_input->line);
	}
	else {
		fclose(g_input->file);
		g_input->file = NULL;
		return NULL;
	}
}

char* pp_getline_lst()
{
	while (true) {
		char* line = pp_getline();
		if (!line)
			return NULL;

		utstring_strip(g_input->line);
		line = utstring_body(g_input->line);

		if (line[0] != '\0' && line[0] != '#' && line[0] != ';')
			return line;
	}
}

static char* src_getline1(void)
{
	next_PC();							// update assembler program counter
	list_end_line();					// end pending list from previous input line

	char* line = pp_getline();			// read next input from file
	
	if (opts.cur_list) {				// interface with list
		if (line) {
			list_start_line(get_phased_PC() >= 0 ? get_phased_PC() : get_PC(),
				g_asm_location.filename, g_asm_location.line_num, line);
		}
		else {
			if (!g_input->eof) {		// first time a NULL is retrieved - show last list line
				list_start_line(get_phased_PC() >= 0 ? get_phased_PC() : get_PC(),
					g_asm_location.filename, g_asm_location.line_num + 1, "");
				list_end_line();

				g_input->eof = true;
			}
		}
	}

	return line;
}

char* pp_getline_asm()
{
	return macros_getline(src_getline1);
}
