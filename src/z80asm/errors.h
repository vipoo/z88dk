/*
Z88DK Z80 Macro Assembler

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk

Error handling.
*/

#pragma once

#include <stdio.h>

// global data
extern int g_error_count;
extern const char* g_error_module_name;

// send errors to an error file
// file is appended, to allow assemble	and link errors to be joined in the same file
void open_error_file(const char* filename);
void close_error_file(void);   // deletes the file if empty

// emit errors - error location is retrieved from asmpp.h
enum ErrType { ErrInfo, ErrWarn, ErrError };

#define X(type,func,params,fmt_args) \
	void func(params);
#include "errors_def.h"
