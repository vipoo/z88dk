/*
Z88DK Z80 Macro Assembler

Unit tests

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "test.h"
#include "../asmpp.h"
#include "../utils.h"

#define FILE1 "test1.asm"
#define FILE2 "test2.asm"
#define FILE3 "test3.asm"
#define C_FILE "file.c"

// declare private functions
bool pp_file_in_stack(const char* filename);

#define T_LOC(_asm_filename, _asm_line_num, _c_filename, _c_line_num)	\
		OK(str_pool_add(g_asm_location.filename) == str_pool_add(_asm_filename)); \
		IS(g_asm_location.line_num, _asm_line_num); \
		OK(str_pool_add(g_c_location.filename) == str_pool_add(_c_filename)); \
		IS(g_c_location.line_num, _c_line_num); \
		if (_asm_filename) STR_IS(g_asm_location.filename, _asm_filename); \
		if (_c_filename) STR_IS(g_c_location.filename, _c_filename)

void test_asmpp()
{
	tst_spew(FILE1,
		"line 1\n"
		"line 2\r\n"
		"line 3\r"
		"line 4");

	tst_spew(FILE2,
		"LINE 1\r"
		"LINE 2\r");

	NOK(pp_file_in_stack(FILE1));
	NOK(pp_file_in_stack(FILE2));
	NOK(pp_getline());
	T_LOC(NULL, 0, NULL, 0);

	char* line;
	pp_push();
	{
		T_LOC(NULL, 0, NULL, 0);
		OK(pp_open(FILE1));
		T_LOC(NULL, 0, NULL, 0);

		OK(pp_file_in_stack(FILE1));
		NOK(pp_file_in_stack(FILE2));

		line = pp_getline();
		STR_IS(line, "line 1\n");
		T_LOC(FILE1, 1, NULL, 0);

		g_c_location = (location_t){ C_FILE,10 };
		T_LOC(FILE1, 1, C_FILE, 10);

		pp_clear_locations();
		T_LOC(NULL, 0, NULL, 0);

		g_c_location = (location_t){ C_FILE,10 };
		T_LOC(NULL, 0, C_FILE, 10);

		line = pp_getline();
		STR_IS(line, "line 2\n");
		T_LOC(FILE1, 2, C_FILE, 10);

		pp_push();
		{
			T_LOC(FILE1, 2, C_FILE, 10);
			OK(pp_open(FILE2));
			T_LOC(FILE1, 2, C_FILE, 10);

			OK(pp_file_in_stack(FILE1));
			OK(pp_file_in_stack(FILE2));

			STR_IS(pp_get_current_location().filename, FILE2);
			IS(pp_get_current_location().line_num, 0);

			pp_set_current_location((location_t) { FILE3, 9 });

			line = pp_getline();
			STR_IS(line, "LINE 1\n");
			T_LOC(FILE3, 10, C_FILE, 10);

			line = pp_getline();
			STR_IS(line, "LINE 2\n");
			T_LOC(FILE3, 11, C_FILE, 10);

			NOK(pp_getline());
			T_LOC(FILE3, 11, C_FILE, 10);

			NOK(pp_getline());
			T_LOC(FILE3, 11, C_FILE, 10);
		}
		pp_pop();
		T_LOC(FILE3, 11, C_FILE, 10);

		OK(pp_file_in_stack(FILE1));
		NOK(pp_file_in_stack(FILE2));

		line = pp_getline();
		STR_IS(line, "line 3\n");
		T_LOC(FILE1, 3, C_FILE, 10);

		g_c_location.line_num = 12;

		line = pp_getline();
		STR_IS(line, "line 4\n");
		T_LOC(FILE1, 4, C_FILE, 12);

		NOK(pp_getline());
		T_LOC(FILE1, 4, C_FILE, 12);

		NOK(pp_getline());
		T_LOC(FILE1, 4, C_FILE, 12);
	}
	pp_pop();
	T_LOC(NULL, 0, NULL, 0);

	NOK(pp_file_in_stack(FILE1));
	NOK(pp_file_in_stack(FILE2));

	NOK(pp_getline());
	T_LOC(NULL, 0, NULL, 0);

	OK(0 == remove(FILE1));
	OK(0 == remove(FILE2));
}

void test_asmpp_empty_file()
{
	tst_spew(FILE1, "");

	char* line;
	pp_push();
	{
		OK(pp_open(FILE1));
		line = pp_getline();
		NOK(line);
	}
	pp_pop();

	OK(0 == remove(FILE1));
}

void test_asmpp_recursive_includes()
{
	OK(tst_exec("exec_asmpp_recursive_includes_1"));
	STR_IS(tst_exec_out, "");
	STR_IS(tst_exec_err, "Error: cannot include file 'test1.asm' recursively\n");

	OK(tst_exec("exec_asmpp_recursive_includes_2"));
	STR_IS(tst_exec_out, "");
	STR_IS(tst_exec_err, "Error at file '" FILE2 "' line 25: cannot include file 'test1.asm' recursively\n");
}

static int exec_asmpp_recursive_includes(bool has_location)
{
	bool ok = true;

	if (has_location)
		g_asm_location = (location_t){ FILE2,25 };

	tst_spew(FILE1, "");
	pp_push();
	{
		if (!pp_open(FILE1)) ok = false;
		pp_push();
		{
			if (pp_open(FILE1)) ok = false;
		}
		pp_pop();
	}
	pp_pop();

	if (remove(FILE1)) ok = false;

	return ok ? EXIT_SUCCESS : EXIT_FAILURE;
}

int exec_asmpp_recursive_includes_1()
{
	return exec_asmpp_recursive_includes(false);
}

int exec_asmpp_recursive_includes_2()
{
	return exec_asmpp_recursive_includes(true);
}

void test_asmpp_file_open_error()
{
	OK(tst_exec("exec_asmpp_file_open_error_1"));
	STR_IS(tst_exec_out, "");
	STR_IS(tst_exec_err, "Error: cannot read file 'test1.asm'\n");

	g_asm_location = (location_t){ FILE2,25 };
	OK(tst_exec("exec_asmpp_file_open_error_2"));
	STR_IS(tst_exec_out, "");
	STR_IS(tst_exec_err, "Error at file '" FILE2 "' line 25: cannot read file 'test1.asm'\n");
}

static int exec_asmpp_file_open_error(bool has_location)
{
	bool ok = true;

	if (has_location)
		g_asm_location = (location_t){ FILE2,25 };

	remove(FILE1);
	pp_push();
	{
		if (pp_open(FILE1)) ok = false;
	}
	pp_pop();

	return ok ? EXIT_SUCCESS : EXIT_FAILURE;
}

int exec_asmpp_file_open_error_1()
{
	return exec_asmpp_file_open_error(false);
}

int exec_asmpp_file_open_error_2()
{
	return exec_asmpp_file_open_error(true);
}

void test_asmpp_getline_lst()
{
	tst_spew(FILE1,
		"  \n"
		"  \r\n"
		"  \r"
		"  file 1  \n"
		"  # comment 1  \r\n"
		"  file 2  \r"
		"  ; comment 2  \n"
		"  file 3");
	OK(file_exists(FILE1));

	pp_push(); {
		OK(pp_open(FILE1));

		char* line = pp_getline_lst();
		ASSERT(line);
		STR_IS(line, "file 1");

		line = pp_getline_lst();
		ASSERT(line);
		STR_IS(line, "file 2");

		line = pp_getline_lst();
		ASSERT(line);
		STR_IS(line, "file 3");

		line = pp_getline_lst();
		NOK(line);
	}
	pp_pop();

	xremove(FILE1);
	NOK(file_exists(FILE1));
}
