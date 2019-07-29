/*
Z88DK Z80 Macro Assembler

Unit tests

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "test.h"
#include "../errors.h"
#include "../asmpp.h"
#include "../utils.h"

#include <stdlib.h>

#define ERR_FILE "file.err"

void do_error(enum ErrType err_type, char* message);

void test_errors_output()
{
	OK(tst_exec("exec_errors_output"));
	STR_IS(tst_exec_out, 
		""
	);
	STR_IS(tst_exec_err,
		"info 1\n"
		"info 2\n"
		"Warning: warn 1\n"
		"Warning at file 'test.asm': warn 2\n"
		"Warning at file 'test.c', file 'test.asm': warn 3\n"
		"Warning at file 'test.c': warn 4\n"
		"Warning at file 'test.c', module 'TEST': warn 5\n"
		"Warning at file 'test.c' line 25, module 'TEST': warn 6\n"
		"Error at file 'test.c' line 25, file 'test.asm' line 125, module 'TEST': error 1\n"
		"Error at file 'test.c' line 25, file 'test.asm' line 125: error 2\n"
		"Error at file 'test.asm' line 125: error 3\n"
		"Error: error 4\n"
		"Error at file 'test.asm': error 5\n"
		"Error at file 'test.c', file 'test.asm': error 6\n"
	);
}

int exec_errors_output()
{
	IS(g_error_count, 0);
	do_error(ErrInfo, "info 1");
	IS(g_error_count, 0);

	g_asm_location = (location_t){ "test.asm",10 };
	g_c_location = (location_t){ "test.c",1 };
	g_error_module_name = "TEST";

	IS(g_error_count, 0);
	do_error(ErrInfo, "info 2");
	IS(g_error_count, 0);

	pp_clear_locations();
	g_error_module_name = NULL;

	IS(g_error_count, 0);
	do_error(ErrWarn, "warn 1");
	IS(g_error_count, 0);

	g_asm_location = (location_t){ "test.asm",0 };

	IS(g_error_count, 0);
	do_error(ErrWarn, "warn 2");
	IS(g_error_count, 0);

	g_c_location = (location_t){ "test.c",0 };

	IS(g_error_count, 0);
	do_error(ErrWarn, "warn 3");
	IS(g_error_count, 0);

	g_asm_location = (location_t){ NULL,0 };

	IS(g_error_count, 0);
	do_error(ErrWarn, "warn 4");
	IS(g_error_count, 0);

	g_error_module_name = "TEST";

	IS(g_error_count, 0);
	do_error(ErrWarn, "warn 5");
	IS(g_error_count, 0);

	g_c_location = (location_t){ "test.c",25 };

	IS(g_error_count, 0);
	do_error(ErrWarn, "warn 6");
	IS(g_error_count, 0);

	g_asm_location = (location_t){ "test.asm",125 };

	IS(g_error_count, 0);
	do_error(ErrError, "error 1");
	IS(g_error_count, 1);

	g_error_module_name = "";

	IS(g_error_count, 1);
	do_error(ErrError, "error 2");
	IS(g_error_count, 2);

	g_c_location = (location_t){ "",25 };

	IS(g_error_count, 2);
	do_error(ErrError, "error 3");
	IS(g_error_count, 3);

	g_asm_location = (location_t){ "",125 };

	IS(g_error_count, 3);
	do_error(ErrError, "error 4");
	IS(g_error_count, 4);

	g_asm_location = (location_t){ "test.asm",-1 };

	IS(g_error_count, 4);
	do_error(ErrError, "error 5");
	IS(g_error_count, 5);

	g_c_location = (location_t){ "test.c",-1 };

	IS(g_error_count, 5);
	do_error(ErrError, "error 6");
	IS(g_error_count, 6);

	return EXIT_SUCCESS;
}

void test_errors_file()
{
	xremove(ERR_FILE);

	OK(tst_exec("exec_errors_file"));
	STR_IS(tst_exec_out,
		""
	);
	STR_IS(tst_exec_err,
		"Error: error 1\n"
		"Error: error 2\n"
		"Error: error 3\n"
		"Error: error 4\n"
	);

	ASSERT(file_exists(ERR_FILE));
	char* err_file = tst_slurp_alloc(ERR_FILE);
	STR_IS(err_file,
		"Error: error 2\n"
		"Error: error 4\n"
	);
	xfree(err_file);

	xremove(ERR_FILE);
}

int exec_errors_file()
{
	xremove(ERR_FILE);

	do_error(ErrError, "error 1");
	open_error_file(ERR_FILE);
	do_error(ErrError, "error 2");
	close_error_file();
	do_error(ErrError, "error 3");
	open_error_file(ERR_FILE);
	do_error(ErrError, "error 4");

	return EXIT_SUCCESS;
}
