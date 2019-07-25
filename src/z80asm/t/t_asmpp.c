/*
Z88DK Z80 Macro Assembler

Unit tests

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "test.h"
#include "../asmpp.h"

#define FILE1 "test1.asm"
#define FILE2 "test2.asm"

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
	NOK(pp_filename());
	NOK(pp_line_num());
	
	char* line;
	pp_push(FILE1);
	{
		OK(pp_file_in_stack(FILE1));
		NOK(pp_file_in_stack(FILE2));

		line = pp_getline();
		STR_IS(line, "line 1\n");
		STR_IS(pp_filename(), FILE1);
		IS(pp_line_num(), 1);

		line = pp_getline();
		STR_IS(line, "line 2\n");
		STR_IS(pp_filename(), FILE1);
		IS(pp_line_num(), 2);

		pp_push(FILE2);
		{
			OK(pp_file_in_stack(FILE1));
			OK(pp_file_in_stack(FILE2));

			line = pp_getline();
			STR_IS(line, "LINE 1\n");
			STR_IS(pp_filename(), FILE2);
			IS(pp_line_num(), 1);

			line = pp_getline();
			STR_IS(line, "LINE 2\n");
			STR_IS(pp_filename(), FILE2);
			IS(pp_line_num(), 2);

			NOK(pp_getline());
			STR_IS(pp_filename(), FILE2);
			IS(pp_line_num(), 2);

			NOK(pp_getline());
			STR_IS(pp_filename(), FILE2);
			IS(pp_line_num(), 2);
		}
		pp_pop();

		OK(pp_file_in_stack(FILE1));
		NOK(pp_file_in_stack(FILE2));

		line = pp_getline();
		STR_IS(line, "line 3\n");
		STR_IS(pp_filename(), FILE1);
		IS(pp_line_num(), 3);

		line = pp_getline();
		STR_IS(line, "line 4\n");
		STR_IS(pp_filename(), FILE1);
		IS(pp_line_num(), 4);

		NOK(pp_getline());
		STR_IS(pp_filename(), FILE1);
		IS(pp_line_num(), 4);

		NOK(pp_getline());
		STR_IS(pp_filename(), FILE1);
		IS(pp_line_num(), 4);
	}
	pp_pop();

	NOK(pp_file_in_stack(FILE1));
	NOK(pp_file_in_stack(FILE2));

	NOK(pp_getline());
	NOK(pp_filename());
	NOK(pp_line_num());

	OK(0 == remove(FILE1));
	OK(0 == remove(FILE2));
}
