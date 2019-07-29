/*
Z88DK Z80 Macro Assembler

Unit tests

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#pragma once

#include <stdbool.h>
#include <stdio.h>

extern char* tst_prog_name;
extern char* tst_exec_out;
extern char* tst_exec_err;

void tst_spew(const char* filename, const char* text);
char* tst_slurp_alloc(const char* filename);		// user must free pointer
void tst_is_ok(bool value, const char* filename, int line_num);
void tst_is_equal(int a, int b, const char* filename, int line_num);
void tst_is_different(int a, int b, const char* filename, int line_num);
void tst_string_is(const char* a, const char* b, const char* filename, int line_num);
bool tst_exec(const char* test_name);

#define DIAG(...)		(printf("# " __VA_ARGS__), putc('\n', stdout))
#define OK(x)			tst_is_ok((x), __FILE__, __LINE__)
#define NOK(x)			OK(!(x))
#define IS(a, b)		tst_is_equal((a), (b), __FILE__, __LINE__)
#define ISNT(a, b)		tst_is_different((a), (b), __FILE__, __LINE__)
#define STR_IS(a, b) 	tst_string_is((a), (b), __FILE__, __LINE__)
#define PASS()			OK(true)
#define FAIL()			OK(false)
#define ASSERT(x)   	do { OK(x); if (!x) return; } while (0)
