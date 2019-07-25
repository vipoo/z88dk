/*
Z88DK Z80 Macro Assembler

Preprocessor

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "asmpp.h"
#include "errcheck.h"

#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <utlist.h>
#include <utstring.h>

//-----------------------------------------------------------------------------
// initialize
//-----------------------------------------------------------------------------
static void pp_pop_all();

static void pp_exit(void)
{
	pp_pop_all();
}

static void pp_init()
{
	static bool inited = false;
	if (!inited) {
		atexit(pp_exit);
		inited = true;
	}
}

//-----------------------------------------------------------------------------
// input from file
//-----------------------------------------------------------------------------
typedef struct input_t {
	char*		filename;
	FILE*		file;
	int			line_num;
	UT_string*	line;

	struct input_t* next;		// next in stack
} input_t;

static input_t* pp_input = NULL;

void pp_push(const char* filename)
{
	pp_init();

	input_t* elem	= chk_calloc(1, sizeof(input_t));
	elem->filename	= chk_strdup(filename);
	elem->file		= chk_fopen(filename, "rb");
	elem->line_num	= 0;
	utstring_new(elem->line);
	LL_PREPEND(pp_input, elem);
}

void pp_pop()
{
	if (pp_input) {
		input_t* elem = pp_input;
		LL_DELETE(pp_input, elem);
		
		free(elem->filename);
		if (elem->file) fclose(elem->file);
		utstring_free(elem->line);
		free(elem);
	}
}

static void pp_pop_all()
{
	while (pp_input)
		pp_pop();
}

bool pp_file_in_stack(const char* filename)
{
	input_t* p = pp_input;
	while (p != NULL) {
		if (strcmp(filename, p->filename) == 0)
			return true;
		p = p->next;
	}
	return false;
}

char* pp_getline()
{
	if (!pp_input) return NULL;		// no file in stack
	if (!pp_input->file) return NULL;	// file not open
	
	utstring_clear(pp_input->line);	// clear result string

	// read until end-of-line
	int c1, c2;
	char c;
	bool found_newline = false;
	while (!found_newline && (c1 = getc(pp_input->file)) != EOF) {
		switch (c1) {
		case '\r': 
			c2 = getc(pp_input->file);
			if (c2 != '\n' && c2 != EOF)
				ungetc(c2, pp_input->file);
			c1 = '\n';
			// fall through		
		case '\n':
			found_newline = true;
			// fall through		
		default:
			c = (char)c1;
			utstring_bincpy(pp_input->line, &c, 1);
		}
	}

	// terminate string
	if (utstring_len(pp_input->line) > 0 && !found_newline)
		utstring_bincpy(pp_input->line, "\n", 1);

	if (utstring_len(pp_input->line) > 0) {
		pp_input->line_num++;
		return utstring_body(pp_input->line);
	}
	else {
		fclose(pp_input->file);
		pp_input->file = NULL;
		return NULL;
	}
}

const char* pp_filename()
{
	if (pp_input)
		return pp_input->filename;
	else
		return NULL;
}

int pp_line_num()
{
	if (pp_input)
		return pp_input->line_num;
	else
		return 0;
}

