/*
Z88DK Z80 Macro Assembler

Utilities

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#pragma once

#include "utstring.h"
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>

// error message and exit program
void die(char* msg, ...);

// check memory allocation
void* xmalloc(size_t size);
void* xcalloc(size_t num, size_t size);
void* xrealloc(void* ptr, size_t size);
char* xstrdup(const char* str);

#define xnew(type)			((type*)xcalloc(1, sizeof(type)))
#define xfree(p)			(free(p), (p) = NULL)

// string pool
const char* str_pool_add(const char* str);

// string utils
void utstring_toupper(UT_string* str);
void utstring_tolower(UT_string* str);
void utstring_chomp(UT_string* str);
void utstring_strip(UT_string* str);

// check file io
FILE* xfopen(const char* filename, const char* mode);
void xfclose_(FILE** fp);
#define xfclose(fp)			xfclose_(&(fp))
void xfwrite(const void* ptr, size_t size, size_t count, FILE* stream);
void xfread(void* ptr, size_t size, size_t count, FILE* stream);
void xremove(const char* filename);

// hold the file nane and FILE* together
typedef struct open_file_t {
	FILE*		file;		// open file handle
	const char* filename;	// file name, stored in string pool
} open_file_t;

// check if file/directory exist
extern bool file_exists(const char* filename);
extern bool dir_exists(const char* dirname);
extern long file_size(const char* filename);		// -1 if not regular file
