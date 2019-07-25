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

static int count_run = 0;
static int count_failed = 0;

char* tst_prog_name = NULL;
char* tst_last_exec_out = NULL;
char* tst_last_exec_err = NULL;

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

void tst_spew(const char* filename, const char* text)
{
	FILE* fp = fopen(filename, "wb");
	if (!fp) {
		perror(filename);
		exit(EXIT_FAILURE);
	}
	else {
		size_t size = strlen(text);
		size_t written = fwrite(text, sizeof(char), size, fp);
		OK(size == written);

		fclose(fp);
	}
}

char* tst_slurp_alloc(const char* filename)
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
		OK(size >= 0);

		char* text = malloc(size + 1);
		assert(text);

		size_t read = fread(text, sizeof(char), size, fp);
		OK(size == read);
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

void tst_is_ok(bool value, const char* filename, int line_num) 
{
	count_run++;

	if (value) {
		printf("ok %d\n", count_run);
	}
	else {
		printf("not ok %d\n", count_run);
		DIAG("Failed test at %s line %d", filename, line_num);
		count_failed++;
	}
}

void tst_is_equal(int a, int b, const char* filename, int line_num)
{
	tst_is_ok(a == b, filename, line_num);
	if (a != b) {
		DIAG("%d", a);
		DIAG("%d", b);
	}
}

void tst_is_different(int a, int b, const char* filename, int line_num)
{
	tst_is_ok(a != b, filename, line_num);
	if (a == b) {
		DIAG("%d", a);
		DIAG("%d", b);
	}
}

void tst_string_is(const char* a, const char* b, const char* filename, int line_num) 
{
	tst_is_ok(a != NULL, filename, line_num);
	tst_is_ok(b != NULL, filename, line_num);
	if (a != NULL && b != NULL) {
		char* a_ = normalize_eol(strdup(a));
		char* b_ = normalize_eol(strdup(b));

		bool ok = (strcmp(a_, b_) == 0);
		tst_is_ok(ok, filename, line_num);

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
	char* text = normalize_eol(tst_slurp_alloc(filename));
	OK(0 == remove(filename));
	return text;
}

bool tst_exec(const char* test_name) 
{
	char cmd[1024];
	assert(tst_prog_name);

	snprintf(cmd, sizeof(cmd), "%s %s >test.out 2>test.err", tst_prog_name, test_name);
	int rv = system(cmd);

	free(tst_last_exec_out); tst_last_exec_out = slurp_remove("test.out");
	free(tst_last_exec_err); tst_last_exec_err = slurp_remove("test.err");

	if (rv == 0)
		return true;
	else
		return false;
}

int main(int argc, char* argv[])
{
	// init
	tst_prog_name = strdup(argv[0]);

	// run tests
	if (argc == 2) {				// sub-test
		const char* test = argv[1];
#define EXEC_TEST 1
#include "test.def"
#undef EXEC_TEST

		return EXIT_FAILURE;		// should not be reached
	}
	else if (argc == 1) {			// main test
#define EXEC_TEST 0
#include "test.def"
#undef EXEC_TEST
	}
	else {
		DIAG("too many arguments");
		FAIL();
	}

	print_summary();

	// free
	free(tst_prog_name);
	free(tst_last_exec_out);
	free(tst_last_exec_err);

	if (!count_failed)
		return EXIT_SUCCESS;
	else
		return EXIT_FAILURE;
}
