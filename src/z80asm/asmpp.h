/*
Z88DK Z80 Macro Assembler

Preprocessor

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#pragma once

#include <stdbool.h>

// push the file to the input stack
// exits if file cannot be opened
void pp_push(const char* filename);

// pop the file from the input stack
void pp_pop();

// check if the file is already in the input stack
bool pp_file_in_stack(const char* filename);

// read the next input line from the file at the top of the stack, return NULL on end of file
// returns a pointer to an internal buffer
char* pp_getline();
const char* pp_filename();	// NULL if no file open
int pp_line_num();			// 0 if no file open

