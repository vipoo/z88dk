/*
Z88DK Z80 Macro Assembler

Unit tests

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "test.h"
#include "../utils.h"

#include <assert.h>
#include <string.h>

#define FILE1 "test.1"

void test_die(void)
{
	EXEC_NOK("exec_die", 0, "", "hello world 42!\n");
}

int exec_die(void)
{
	die("hello %s %d!\n", "world", 42);
	return EXIT_SUCCESS;	// not reached
}

void test_xmalloc(void)
{
	void* ptr = xmalloc(10);
	OK(ptr);
	memset(ptr, 0, 10);
	OK(memcmp(ptr, "\0\0\0\0\0\0\0\0\0\0", 10) == 0);
	xfree(ptr);
	NOK(ptr);
}

void test_xcalloc(void)
{
	void* ptr = xcalloc(1, 10);
	OK(ptr);
	OK(memcmp(ptr, "\0\0\0\0\0\0\0\0\0\0", 10) == 0);
	xfree(ptr);
	NOK(ptr);
}

void test_xrealloc(void)
{
	void* ptr = xrealloc(NULL, 10);
	OK(ptr);
	memset(ptr, 0, 10);
	OK(memcmp(ptr, "\0\0\0\0\0\0\0\0\0\0", 10) == 0);
	ptr = xrealloc(NULL, 20);
	OK(ptr);
	memset(ptr, 0, 20);
	OK(memcmp(ptr, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 20) == 0);
	xfree(ptr);
	NOK(ptr);
}

void test_xstrdup(void)
{
	char* ptr = xstrdup("hello");
	STR_IS(ptr, "hello");
	xfree(ptr);
	NOK(ptr);
}

void test_xnew(void)
{
	long* ptr = xnew(long);
	OK(ptr);
	IS(*ptr, 0L);
	xfree(ptr);
	NOK(ptr);
}

void test_str_pool(void)
{
#define NUM_STRINGS 10
#define STRING_SIZE	5

	struct {
		char source[STRING_SIZE];
		const char* pool;
	} strings[NUM_STRINGS];

	const char* pool;
	int i;

	// first run - create pool for all strings
	for (i = 0; i < NUM_STRINGS; i++) {
		sprintf(strings[i].source, "%d", i);		// number i

		pool = str_pool_add(strings[i].source);
		OK(pool);
		OK(pool != strings[i].source);
		STR_IS(strings[i].source, pool);

		strings[i].pool = pool;
	}

	// second run - check that pool did not move
	for (i = 0; i < NUM_STRINGS; i++) {
		pool = str_pool_add(strings[i].source);
		OK(pool);
		OK(pool != strings[i].source);
		STR_IS(strings[i].source, pool);
		OK(strings[i].pool == pool);
	}

	// check NULL case
	pool = str_pool_add(NULL);
	NOK(pool);
}

void test_utstring_toupper(void)
{
	UT_string* buff;
	utstring_new(buff);

	utstring_clear(buff);
	utstring_printf(buff, "abc1");
	utstring_toupper(buff);
	STR_IS(utstring_body(buff), "ABC1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "Abc1");
	utstring_toupper(buff);
	STR_IS(utstring_body(buff), "ABC1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "ABC1");
	utstring_toupper(buff);
	STR_IS(utstring_body(buff), "ABC1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_free(buff);
}

void test_utstring_tolower(void)
{
	UT_string* buff;
	utstring_new(buff);

	utstring_clear(buff);
	utstring_printf(buff, "abc1");
	utstring_tolower(buff);
	STR_IS(utstring_body(buff), "abc1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "Abc1");
	utstring_tolower(buff);
	STR_IS(utstring_body(buff), "abc1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "ABC1");
	utstring_tolower(buff);
	STR_IS(utstring_body(buff), "abc1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_free(buff);
}

void test_utstring_chomp(void)
{
	UT_string* buff;
	utstring_new(buff);

	utstring_clear(buff);
	utstring_chomp(buff);
	STR_IS(utstring_body(buff), "");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "hello world");
	utstring_chomp(buff);
	STR_IS(utstring_body(buff), "hello world");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "\r\n \t\f \r\n \t\f\v");
	utstring_chomp(buff);
	STR_IS(utstring_body(buff), "");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "\r\n \t\fx\r\n \t\f\v");
	utstring_chomp(buff);
	STR_IS(utstring_body(buff), "\r\n \t\fx");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_free(buff);
}

void test_utstring_strip(void)
{
	UT_string* buff;
	utstring_new(buff);

	utstring_clear(buff);
	utstring_strip(buff);
	STR_IS(utstring_body(buff), "");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "hello world");
	utstring_strip(buff);
	STR_IS(utstring_body(buff), "hello world");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "\r\n \t\f \r\n \t\f\v");
	utstring_strip(buff);
	STR_IS(utstring_body(buff), "");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "\r\n \t\fx\r\n \t\f\v");
	utstring_strip(buff);
	STR_IS(utstring_body(buff), "x");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_free(buff);
}

void test_xfopen(void)
{
	char buffer[6];

	FILE* fp = xfopen("test.out", "wb");
	OK(fp);

	xfwrite("hello", sizeof(char), 5, fp);
	xfclose(fp);
	NOK(fp);

	fp = xfopen("test.out", "rb");
	OK(fp);

	xfread(buffer, sizeof(char), 5, fp);
	buffer[5] = '\0';
	STR_IS("hello", buffer);

	xfclose(fp);
	OK(0 == remove("test.out"));
}

void test_xfopen_error(void)
{
	EXEC_NOK("exec_xfopen_error", 0, 
		"", "/x/x/x/x/x/x/x/x/x: No such file or directory\n");
}

int exec_xfopen_error(void)
{
	FILE* fp = xfopen("/x/x/x/x/x/x/x/x/x", "rb");
	if (fp) return EXIT_SUCCESS;	// silece warning
	return EXIT_SUCCESS;			// not reached
}

void test_xremove(void)
{
	remove(FILE1);
	NOK(file_exists(FILE1));
	xremove(FILE1);			// remove when file does not exist

	test_spew(FILE1, "");
	OK(file_exists(FILE1));
	xremove(FILE1);			// remove when file exists
	NOK(file_exists(FILE1));

#ifdef _WIN32
	// test fails in Linux
	EXEC_NOK("exec_xremove", 0, "", FILE1 ": Permission denied\n");
#endif
}

int exec_xremove(void)
{
	FILE* fp = fopen(FILE1, "w");
	assert(fp);
	xremove(FILE1);
	return EXIT_SUCCESS;	// not reached - cannot remove open file
}

void test_file_checks(void)
{
	xremove(FILE1);
	NOK(file_exists(FILE1));
	IS(file_size(FILE1), -1);

	const char* text = "In the beginning God created the heaven and the earth.\n";
	size_t len = strlen(text);

	test_spew(FILE1, text);
	OK(file_exists(FILE1));
	IS(file_size(FILE1), len);		// no LF -> CR-LF translation took place

	char* read_text = test_slurp_alloc(FILE1);
	STR_IS(read_text, text);
	xfree(read_text);

	xremove(FILE1);
	NOK(file_exists(FILE1));
	IS(file_size(FILE1), -1);
}
