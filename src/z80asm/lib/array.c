/*
Z88DK Z80 Macro Assembler

Template array that grows on request. Items may move in memory on reallocation.

Copyright (C) Gunther Strube, InterLogic 1993-99
Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "array.h"

#include <assert.h>

DEF_ARRAY(Byte);
DEF_ARRAY(int);
DEF_ARRAY(long);
