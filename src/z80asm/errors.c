/*
Z88DK Z80 Macro Assembler

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk

Error handling.
*/

#include "errors.h"
#include "asmpp.h"
#include "fileutil.h"
#include "utils.h"
#include "utstring.h"

#include <stdbool.h>
#include <stdio.h>

//-----------------------------------------------------------------------------
// global data
//-----------------------------------------------------------------------------
int g_error_count = 0;
const char* g_error_module_name = NULL;

// static data
static FILE* g_error_file = NULL;
static const char* g_error_filename = NULL;

//-----------------------------------------------------------------------------
// initialize
//-----------------------------------------------------------------------------
static void error_deinit(void)
{
	close_error_file();
}

static void error_init()
{
	static bool inited = false;
	if (!inited) {
		atexit(error_deinit);
		inited = true;
	}
}

//-----------------------------------------------------------------------------
// error file
//-----------------------------------------------------------------------------
void open_error_file(const char* filename)
{
	error_init();

	// close current file if any
	close_error_file();

	g_error_filename = str_pool_add(filename);
	g_error_file = xfopen(g_error_filename, "a");
}

void close_error_file(void)
{
	error_init();

	// close current file if any
	if (g_error_file != NULL)
	{
		fclose(g_error_file);

		// delete file if empty
		if (g_error_filename != NULL && file_size(g_error_filename) == 0)
			remove(g_error_filename);
	}

	// reset
	g_error_file = NULL;
	g_error_filename = NULL;        // filename kept in strpool, no leak
}

static void puts_error_file(char* string)
{
	error_init();

	if (g_error_file != NULL)
		fputs(string, g_error_file);
}

//-----------------------------------------------------------------------------
// emit errors
//-----------------------------------------------------------------------------
void do_error(enum ErrType err_type, char* message)
{
	UT_string* msg;
	bool file_emitted = false;
	
	error_init();
	utstring_new(msg);
	
	// Information messages have no prefix 
	if (err_type != ErrInfo) {
		utstring_printf(msg, err_type == ErrWarn ? "Warning" : "Error");

		// output C filename
		if (g_c_location.filename != NULL && *g_c_location.filename != '\0') {
			file_emitted = true;
			utstring_printf(msg, " at file '%s'", g_c_location.filename);
			if (g_c_location.line_num > 0)
				utstring_printf(msg, " line %d", g_c_location.line_num);
		}

		// output ASM filename
		if (g_asm_location.filename != NULL && *g_asm_location.filename != '\0') {
			if (file_emitted)
				utstring_printf(msg, ",");
			else 
				utstring_printf(msg, " at");
			file_emitted = true;
			utstring_printf(msg, " file '%s'", g_asm_location.filename);
			if (g_asm_location.line_num > 0)
				utstring_printf(msg, " line %d", g_asm_location.line_num);
		}

		// output module
		if (g_error_module_name != NULL && *g_error_module_name != '\0') {
			if (file_emitted)
				utstring_printf(msg, ",");
			else
				utstring_printf(msg, " at");
			file_emitted = true;
			utstring_printf(msg, " module '%s'", g_error_module_name);
		}

		utstring_printf(msg, ": ");
	}

	// output error message
	utstring_printf(msg, "%s\n", message);

	// send to stderr and error file
	fputs(utstring_body(msg), stderr);
	puts_error_file(utstring_body(msg));

	// count number of errors
	if (err_type == ErrError)
		g_error_count++;

	utstring_free(msg);
}

#define X(type,func,params,fmt_args) \
	void func(params) {		\
		UT_string* msg;		\
		utstring_new(msg);	\
		utstring_printf(msg, fmt_args);		\
		do_error(type, utstring_body(msg));	\
		utstring_free(msg);	\
	}
#include "errors_def.h"
