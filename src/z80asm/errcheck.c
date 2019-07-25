/*
Z88DK Z80 Macro Assembler

Error checking in stdlib calls

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "errcheck.h"

#include <stdio.h>
#include <string.h>

static void check_mem(void* p)
{
	if (!p) {
		fputs("Out of memory", stderr);
		exit(EXIT_FAILURE);
	}
}

static void check_file(FILE* fp, const char* filename)
{
	if (!fp) {
		perror(filename);
		exit(EXIT_FAILURE);
	}
}

void* chk_calloc(size_t num, size_t size)
{
	void* p = calloc(num, size);
	check_mem(p);
	return p;
}

void* chk_malloc(size_t size)
{
	void* p = malloc(size);
	check_mem(p);
	return p;
}

char* chk_strdup(const char* str)
{
	char* p = strdup(str);
	check_mem(p);
	return p;
}

FILE* chk_fopen(const char* filename, const char* mode)
{
	FILE* fp = fopen(filename, mode);
	check_file(fp, filename);
	return fp;
}
