//-----------------------------------------------------------------------------
// z80asm unit tests
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "test.h"
#include "../ccdefs.h"

void test_errors()
{
    spew("test.txt", "hello");
    OK(file_exists("test.txt"));

    Input in;

    err.count = 0;
    START_CAPTURE();
    err.e_file_not_found(in, "test.inc");
    END_CAPTURE("", "Error: cannot read file 'test.inc'\n");
    IS(err.count, 1);
    err.count = 0;

    in.push_file("test.txt");
    OK(in.getline());

    err.count = 0;
    START_CAPTURE();
    err.e_file_not_found(in, "test.inc");
    END_CAPTURE("", "Error at file 'test.txt' line 1: cannot read file 'test.inc'\n");
    IS(err.count, 1);
    err.count = 0;

    NOK(in.getline());      // closes file

    remove("test.txt");
    NOK(file_exists("test.txt"));
}
