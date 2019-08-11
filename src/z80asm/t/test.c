/*
Z88DK Z80 Macro Assembler

Unit tests

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "test.h"

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef _MSC_VER
#define vsnprintf _vsnprintf
#define  snprintf  _snprintf
#endif

static int count_run = 0;
static int count_failed = 0;

char* test_prog_name = NULL;
char* test_exec_out = NULL;
char* test_exec_err = NULL;

// replace in place, replace eol chars by newline
static char* normalize_eol(char* str)
{
	char* in = str;
	char* out = str;
	while (*in != '\0') {
		if (in[0] == '\r' && in[1] == '\n') {
			*out++ = '\n';
			in += 2;
		}
		else if (in[0] == '\r') {
			*out++ = '\n';
			in++;
		}
		else {
			*out++ = *in++;
		}
	}
	*out++ = '\0';
	return str;
}

void test_spew(const char* filename, const char* text)
{
	FILE* fp = fopen(filename, "wb");
	if (!fp) {
		perror(filename);
		exit(EXIT_FAILURE);
	}
	else {
		size_t size = strlen(text);
		size_t written = fwrite(text, sizeof(char), size, fp);
		assert(size == written);

		fclose(fp);
	}
}

char* test_slurp_alloc(const char* filename)
{
	FILE* fp = fopen(filename, "rb");
	if (!fp) {
		perror(filename);
		exit(EXIT_FAILURE);
		return NULL;	// not reached
	}
	else {
		fseek(fp, 0, SEEK_END);
		long size = ftell(fp);
		fseek(fp, 0, SEEK_SET);
		assert(size >= 0);

		char* text = malloc(size + 1);
		assert(text);

		size_t read = fread(text, sizeof(char), size, fp);
		assert(size == read);
		text[read] = '\0';

		fclose(fp);
		return text;		// user must free
	}
}

static void print_summary()
{
	printf("1..%d\n", count_run);

	if (count_failed)
		printf("Failed %d test%s of %d\n", count_failed,
			count_failed > 1 ? "s" : "", count_run);
	else
		printf("All tests successful.\n");
}

void test_is_ok(bool value, const char* filename, int line_num) 
{
	count_run++;

	if (value) {
		//printf("ok %d\n", count_run);
	}
	else {
		printf("not ok %d\n", count_run);
		DIAG("Failed test at %s line %d", filename, line_num);
		count_failed++;
	}
}

void test_is_equal(int a, int b, const char* filename, int line_num)
{
	test_is_ok(a == b, filename, line_num);
	if (a != b) {
		DIAG("%d", a);
		DIAG("%d", b);
	}
}

void test_is_different(int a, int b, const char* filename, int line_num)
{
	test_is_ok(a != b, filename, line_num);
	if (a == b) {
		DIAG("%d", a);
		DIAG("%d", b);
	}
}

void test_string_is(const char* a, const char* b, const char* filename, int line_num) 
{
	test_is_ok(a != NULL, filename, line_num);
	test_is_ok(b != NULL, filename, line_num);
	if (a != NULL && b != NULL) {
		char* a_ = normalize_eol(strdup(a));
		char* b_ = normalize_eol(strdup(b));

		bool ok = (strcmp(a_, b_) == 0);
		test_is_ok(ok, filename, line_num);

		if (!ok) {
			DIAG("<<<");
			DIAG("%s", a_);
			DIAG(">>>");
			DIAG("%s", b_);
			DIAG("---");
		}

		free(a_);
		free(b_);
	}
	else {
		DIAG("NULL string");
	}
}

static char* slurp_remove(const char* filename)
{
	char* text = normalize_eol(test_slurp_alloc(filename));
	OK(0 == remove(filename));
	return text;
}

bool test_exec(const char* name, int arg) 
{
	char cmd[1024];
	assert(test_prog_name);

	snprintf(cmd, sizeof(cmd), 
			"%s %s %d >test.out 2>test.err", 
			test_prog_name, name, arg);
	int rv = system(cmd);

	free(test_exec_out); test_exec_out = slurp_remove("test.out");
	free(test_exec_err); test_exec_err = slurp_remove("test.err");

	if (rv == 0)
		return true;
	else
		return false;
}

int main(int argc, char* argv[])
{
	// init
	test_prog_name = strdup(argv[0]);

	// run tests
	if (argc == 2 || argc == 3) {	// sub-test
		const char* name = argv[1];
		int arg = 0;
		if (argc == 3)
			arg = atoi(argv[2]);
#define EXEC_TEST 1
#include "test.def"
		DIAG("test '%s' not found", name);
		return EXIT_FAILURE;		// should not be reached
	}
	else if (argc == 1) {			// main test
#define EXEC_TEST 0
#include "test.def"
	}
	else {
		DIAG("too many arguments");
		FAIL();
	}

	print_summary();

	// free
	free(test_prog_name);
	free(test_exec_out);
	free(test_exec_err);

	if (!count_failed)
		return EXIT_SUCCESS;
	else
		return EXIT_FAILURE;
}
