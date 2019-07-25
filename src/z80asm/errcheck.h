/*
Z88DK Z80 Macro Assembler

Error checking in stdlib calls

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>

// memory allocation
void* chk_calloc(size_t num, size_t size);
void* chk_malloc(size_t size);
char* chk_strdup(const char* str);

// file io
FILE* chk_fopen(const char* filename, const char* mode);
