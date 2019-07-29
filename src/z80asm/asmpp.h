/*
Z88DK Z80 Macro Assembler

Preprocessor

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#pragma once

#include <stdbool.h>

// line information
typedef struct location_t {
	const char*	filename;		// kept in string pool
	int			line_num;
} location_t;

// last ASM and C line read
extern location_t g_asm_location, g_c_location;

// get/set the current ASM line information; after reading line is incremented 
// and info copied to global g_asm_location
location_t pp_get_current_location();
void pp_set_current_location(location_t location);

// clear locations
void pp_clear_locations();

// create a new input scope on top of the stack
void pp_push();

// drop the input scope from the top of the stack
void pp_pop();

// open a file to be read in the current input scope, return false on error
// searches include path and checks for recursive includes
bool pp_open(const char* filename);

// read the next input line from the file at the top of the stack, return NULL on end of file
// returns a pointer to an internal buffer
char* pp_getline();

// read next file from list file, strips blanks and ignores comments
char* pp_getline_lst();

// read next line from source file
// call preprocessor before returning result
char* pp_getline_asm();
