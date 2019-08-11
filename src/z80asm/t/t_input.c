//-----------------------------------------------------------------------------
// z80asm assembler
// Unit tests
// Copyright (C) Paulo Custodio, 2011-2019
// License: http://www.perlfoundation.org/artistic_license_2_0
// Repository: https://github.com/z88dk/z88dk
//-----------------------------------------------------------------------------

#include "test.h"
#include "../input.h"
#include "../utils.h"

#define FILE1 "test1.asm"
#define FILE2 "test2.asm"
#define FILE3 "test3.asm"
#define C_FILE "file.c"
#define ERR_FILE "test1.err"

//---------- READ FILES ----------//

#define T_LOC(_asm_filename, _asm_line_num, _c_filename, _c_line_num)	\
		OK(str_pool_add(in_location(LocationAsm).filename) == str_pool_add(_asm_filename)); \
		IS(in_location(LocationAsm).line_num, _asm_line_num); \
		OK(str_pool_add(in_location(LocationC).filename) == str_pool_add(_c_filename)); \
		IS(in_location(LocationC).line_num, _c_line_num); \
		if (_asm_filename) STR_IS(in_location(LocationAsm).filename, _asm_filename); \
		if (_c_filename) STR_IS(in_location(LocationC).filename, _c_filename)

void test_input(void)
{
	const char* line;

	test_spew(FILE1,
		"line 1\n"
		"line 2\r\n"
		"line 3\r"
		"line 4");

	test_spew(FILE2,
		"LINE 1\r"
		"LINE 2\r");

	NOK(in_getline());
	T_LOC(NULL, 0, NULL, 0);

	in_push();
	{
		OK(in_open(FILE1));
		T_LOC(FILE1, 0, NULL, 0);

		line = in_getline();
		STR_IS(line, "line 1\n");
		T_LOC(FILE1, 1, NULL, 0);

		in_set_location(LocationC, (Location) { C_FILE, 10 });
		T_LOC(FILE1, 1, C_FILE, 10);

		in_clear_locations();
		T_LOC(NULL, 0, NULL, 0);

		in_set_location(LocationC, (Location) { C_FILE, 10 });
		T_LOC(NULL, 0, C_FILE, 10);

		line = in_getline();
		STR_IS(line, "line 2\n");
		T_LOC(FILE1, 2, C_FILE, 10);

		STR_IS(in_location(LocationAsm).filename, FILE1);
		IS(in_location(LocationAsm).line_num, 2);

		in_push();
		{
			OK(in_open(FILE2));
			T_LOC(FILE2, 0, C_FILE, 10);

			in_set_location(LocationAsm, (Location) { FILE3, 9 });

			line = in_getline();
			STR_IS(line, "LINE 1\n");
			T_LOC(FILE3, 10, C_FILE, 10);

			line = in_getline();
			STR_IS(line, "LINE 2\n");
			T_LOC(FILE3, 11, C_FILE, 10);

			NOK(in_getline());
			T_LOC(FILE3, 12, C_FILE, 10);

			NOK(in_getline());
			T_LOC(FILE3, 12, C_FILE, 10);
		}
		in_pop();

		T_LOC(FILE1, 2, C_FILE, 10);

		line = in_getline();
		STR_IS(line, "line 3\n");
		T_LOC(FILE1, 3, C_FILE, 10);

		in_set_location(LocationC, (Location) { C_FILE, 12 });

		line = in_getline();
		STR_IS(line, "line 4\n");
		T_LOC(FILE1, 4, C_FILE, 12);

		NOK(in_getline());
		T_LOC(FILE1, 5, C_FILE, 12);

		NOK(in_getline());
		T_LOC(FILE1, 5, C_FILE, 12);
	}
	in_pop();

	OK(0 == remove(FILE1));
	OK(0 == remove(FILE2));
}

void test_input_empty_file(void)
{
	const char* line;

	test_spew(FILE1, "");
	in_push();
	{
		OK(in_open(FILE1));
		T_LOC(FILE1, 0, NULL, 0);

		line = in_getline();
		NOK(line);
		T_LOC(FILE1, 1, NULL, 0);

		line = in_getline();
		NOK(line);
		T_LOC(FILE1, 1, NULL, 0);
	}
	in_pop();

	OK(0 == remove(FILE1));
}

void test_input_recursive_includes(void)
{
	EXEC_OK("exec_input_recursive_includes", 0,
		"", "Error at 'test1.asm': cannot include 'test1.asm' recursively\n");
}

int exec_input_recursive_includes(void)
{
	test_spew(FILE1, "");

	in_push();
	{
		OK(in_open(FILE1));
		in_push();
		{
			NOK(in_open(FILE1));
		}
		in_pop();
	}
	in_pop();

	OK(0 == remove(FILE1));
	return EXIT_SUCCESS;
}

void test_in_file_open_error(void)
{
	EXEC_OK("exec_in_file_open_error", 1,
		"", "Error: cannot open 'test1.asm'\n");
	EXEC_OK("exec_in_file_open_error", 2,
		"", "Error at '" FILE2 "' line 25: cannot open 'test1.asm'\n");
}

int exec_in_file_open_error(int test)
{
	if (test == 2)
		in_set_location(LocationAsm, (Location) { FILE2, 25 });

	remove(FILE1);
	in_push();
	{
		NOK(in_open(FILE1));
	}
	in_pop();
	return EXIT_SUCCESS;
}

//---------- EMIT ERRORS ----------//

void test_error_output(void)
{
	EXEC_OK("exec_error_output", 0, "",
		"Warning: warn 0\n");
	EXEC_OK("exec_error_output", 1, "",
		"Warning at 'test.asm': warn 1\n");
	EXEC_OK("exec_error_output", 2, "",
		"Warning at 'test.c', 'test.asm': warn 2\n");
	EXEC_OK("exec_error_output", 3, "",
		"Warning at 'test.c', 'test.asm' line 25: warn 3\n");
	EXEC_OK("exec_error_output", 4, "",
		"Warning at 'test.c' line 15, 'test.asm' line 25: warn 4\n");
	EXEC_OK("exec_error_output", 5, "",
		"Error: error 5\n");
	EXEC_OK("exec_error_output", 6, "",
		"Error at 'test.asm': error 6\n");
	EXEC_OK("exec_error_output", 7, "",
		"Error at 'test.c', 'test.asm': error 7\n");
	EXEC_OK("exec_error_output", 8, "",
		"Error at 'test.c', 'test.asm' line 25: error 8\n");
	EXEC_OK("exec_error_output", 9, "",
		"Error at 'test.c' line 15, 'test.asm' line 25: error 9\n");
}

int exec_error_output(int test)
{
	switch (test % 5) {
	case 0:
		in_clear_locations(); 
		break;
	case 1:
		in_clear_locations();
		in_set_location(LocationAsm, (Location) { "test.asm", 0 });
		break;
	case 2:
		in_clear_locations();
		in_set_location(LocationAsm, (Location) { "test.asm", 0 });
		in_set_location(LocationC, (Location) { "test.c", 0 });
		break;
	case 3:
		in_clear_locations();
		in_set_location(LocationAsm, (Location) { "test.asm", 25 });
		in_set_location(LocationC, (Location) { "test.c", 0 });
		break;
	case 4:
		in_clear_locations();
		in_set_location(LocationAsm, (Location) { "test.asm", 25 });
		in_set_location(LocationC, (Location) { "test.c", 15 });
		break;
	default:
		return EXIT_FAILURE;
	}

	switch (test / 5) {
	case 0:
		IS(error_count(), 0);
		warn("warn %d", test);
		IS(error_count(), 0);
		return EXIT_SUCCESS;
	case 1:
		IS(error_count(), 0);
		error("error %d", test);
		IS(error_count(), 1);
		return EXIT_SUCCESS;

	default:
		return EXIT_FAILURE;
	}
}

void test_error_file(void)
{
	EXEC_OK("exec_error_file", 0,
		"",
		"Error: error 1\n"
		"Error: error 2\n"
		"Error: error 3\n"
		"Error: error 4\n"
	);

	ASSERT(file_exists(ERR_FILE));
	char* err_text = test_slurp_alloc(ERR_FILE);
	STR_IS(err_text,
		"Error: error 2\n"
		"Error: error 4\n"
	);
	xfree(err_text);

	xremove(ERR_FILE);
}

int exec_error_file(void)
{
	xremove(ERR_FILE);

	error("error 1");
	error_open_file(ERR_FILE);
	error("error 2");
	error_close_file();
	error("error 3");
	error_open_file(ERR_FILE);
	error("error 4");

	return EXIT_SUCCESS;
}

void test_error_file_empty(void)
{
	test_spew(ERR_FILE, "");
	OK(file_exists(ERR_FILE));

	error_open_file(ERR_FILE);
	error_close_file();
	NOK(file_exists(ERR_FILE));
}
