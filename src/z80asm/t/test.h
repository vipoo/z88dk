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

extern char* test_prog_name;
extern char* test_exec_out;
extern char* test_exec_err;

void test_spew(const char* filename, const char* text);
char* test_slurp_alloc(const char* filename);		// user must free pointer
void test_is_ok(bool value, const char* filename, int line_num);
void test_is_equal(int a, int b, const char* filename, int line_num);
void test_is_different(int a, int b, const char* filename, int line_num);
void test_string_is(const char* a, const char* b, const char* filename, int line_num);
bool test_exec(const char* name, int arg);

#define DIAG(...)		(printf("# " __VA_ARGS__), putc('\n', stdout))
#define OK(x)			test_is_ok((x), __FILE__, __LINE__)
#define NOK(x)			OK(!(x))
#define IS(a, b)		test_is_equal((a), (b), __FILE__, __LINE__)
#define ISNT(a, b)		test_is_different((a), (b), __FILE__, __LINE__)
#define STR_IS(a, b) 	test_string_is((a), (b), __FILE__, __LINE__)
#define PASS()			OK(true)
#define FAIL()			OK(false)
#define ASSERT(x)   	do { OK(x); if (!(x)) return; } while (0)
#define EXEC_OK(name,arg,out,err) \
						do { test_is_ok(test_exec((name), (arg)), __FILE__, __LINE__); \
							 test_string_is(test_exec_out, (out), __FILE__, __LINE__); \
							 test_string_is(test_exec_err, (err), __FILE__, __LINE__); \
						} while (0)
#define EXEC_NOK(name,arg,out,err) \
						do { test_is_ok(!test_exec((name), (arg)), __FILE__, __LINE__); \
							 test_string_is(test_exec_out, (out), __FILE__, __LINE__); \
							 test_string_is(test_exec_err, (err), __FILE__, __LINE__); \
												} while (0)
