//-----------------------------------------------------------------------------
// z80asm assembler
// Read input
// Copyright (C) Paulo Custodio, 2011-2019
// License: http://www.perlfoundation.org/artistic_license_2_0
// Repository: https://github.com/z88dk/z88dk
//-----------------------------------------------------------------------------
#pragma once

#include <stdarg.h>
#include <stdbool.h>

//---------- READ FILES ----------//

// line information
typedef struct {
	const char* filename;					// kept in string pool
	int			line_num;
} Location;

// collect location information for these types
typedef enum { LocationC, LocationAsm, LocationModule, LocationMAX } LocationType;

// open a new layer for reading files and close it
void in_push(void);
void in_pop(void);

// read source or list file
bool in_open(const char* filename);			// false if error
const char* in_getline(void);				// NULL if eof of current file

// allow the current location to be changed
Location in_location(LocationType type);
void in_set_location(LocationType type, Location location);
void in_clear_locations(void);

//---------- EMIT ERRORS ----------//

// output error and warning messages
void error(const char* fmt, ...);
void warn(const char* fmt, ...);

// send errors to an error file
// file is appended, to send assembly and link errors to the same file
void error_open_file(const char* filename);
void error_close_file(void);   // deletes the file if empty

// count number of errors
void error_clear(void);
int error_count(void);

//---------- INTERNAL INTERFACE ----------//

void _error(const char* prefix, const char* fmt, va_list ap);

//---------- OLD INTERFACE ----------//

// emit errors
enum ErrType { ErrInfo, ErrWarn, ErrError };
#define X(type,func,params,fmt_args) \
	void func(params);
#include "errors_def.h"

// read next line from source file
// call preprocessor before returning result
const char* in_getline_asm();
