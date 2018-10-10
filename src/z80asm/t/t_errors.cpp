//-----------------------------------------------------------------------------
// z80asm unit tests
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "test.h"

void test_errors()
{
	IS(g_err_count, 0);

	IS(string(g_err_loc.file), "");
	IS(g_err_loc.line_nr, 0);

	err_push("f1.asm", 1);
	IS(string(g_err_loc.file), "f1.asm");
	IS(g_err_loc.line_nr, 1);

	err_push("f2.asm", 2);
	IS(string(g_err_loc.file), "f2.asm");
	IS(g_err_loc.line_nr, 2);

	err_pop();
	IS(string(g_err_loc.file), "f1.asm");
	IS(g_err_loc.line_nr, 1);

	err_pop();
	IS(string(g_err_loc.file), "");
	IS(g_err_loc.line_nr, 0);

	err_pop();
	IS(string(g_err_loc.file), "");
	IS(g_err_loc.line_nr, 0);
}