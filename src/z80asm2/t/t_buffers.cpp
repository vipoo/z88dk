//-----------------------------------------------------------------------------
// z80asm unit tests
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "test.h"
#include "../ccdefs.h"

#define IS_LINE(l, fn, ln, txt) \
        IS_STR(l.filename, fn); \
        IS(l.line_nr, ln);      \
        IS_STR(l.text, txt)

void test_line()
{
    Line l;
    IS_LINE(l, "", 0, "");
}

void test_buffer()
{
    spew("test.txt", "abc\ndef\r\nghi\rjkl");

    Buffer b;
    IS_LINE(b.cur_line, "", 0, "");

    NOK(b.getline());
    IS_LINE(b.cur_line, "", 0, "");

    b.push_text("123\n456");
    OK(b.getline());
    IS_LINE(b.cur_line, "", 0, "123");

    OK(b.open_file("test.txt"));
    IS_LINE(b.cur_line, "test.txt", 0, "");

    b.push_text("789\n");
    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 0, "789");

    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 0, "");

    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 0, "456");

    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 1, "abc");

    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 2, "def");

    OK(b.open_file("test.txt"));
    IS_LINE(b.cur_line, "test.txt", 0, "");

    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 1, "abc");

    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 2, "def");

    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 3, "ghi");

    OK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 4, "jkl");

    NOK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 4, "");

    NOK(b.getline());
    IS_LINE(b.cur_line, "test.txt", 4, "");

    remove("test.txt");
}

void test_buffer_error()
{
    remove("test.txt");
    Buffer b;
    NOK(b.open_file("test.txt"));
}

void test_input()
{
    spew("test1.txt", "1\n2");
    spew("test2.txt", "a\nb");
    remove("test3.txt");

    Input in;
    bool ok;

    IS_LINE(in.cur_line(), "", 0, "");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "", 0, "");

    in.push_text("A\nB");
    IS_LINE(in.cur_line(), "", 0, "");

    OK(in.getline());
    IS_LINE(in.cur_line(), "", 0, "A");

    OK(in.push_file("test1.txt"));
    IS_LINE(in.cur_line(), "test1.txt", 0, "");

    OK(in.getline());
    IS_LINE(in.cur_line(), "test1.txt", 1, "1");

    OK(in.push_file("test2.txt"));
    IS_LINE(in.cur_line(), "test2.txt", 0, "");

    OK(in.getline());
    IS_LINE(in.cur_line(), "test2.txt", 1, "a");

    START_CAPTURE();
    ok = in.push_file("test1.txt");
    END_CAPTURE("",
                "Error at file 'test2.txt' line 1: cannot include file 'test1.txt' recursively\n");
    NOK(ok);

    IS_LINE(in.cur_line(), "test2.txt", 1, "a");

    START_CAPTURE();
    ok = in.push_file("test3.txt");
    END_CAPTURE("",
                "Error at file 'test2.txt' line 1: file 'test3.txt' not found\n");
    NOK(ok);

    IS_LINE(in.cur_line(), "test2.txt", 1, "a");

    in.push_text("C\nD");
    IS_LINE(in.cur_line(), "test2.txt", 1, "");

    OK(in.getline());
    IS_LINE(in.cur_line(), "test2.txt", 1, "C");

    OK(in.getline());
    IS_LINE(in.cur_line(), "test2.txt", 1, "D");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "test2.txt", 1, "");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "test2.txt", 1, "");

    in.pop();
    IS_LINE(in.cur_line(), "test2.txt", 1, "a");

    OK(in.getline());
    IS_LINE(in.cur_line(), "test2.txt", 2, "b");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "test2.txt", 2, "");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "test2.txt", 2, "");

    in.pop();
    IS_LINE(in.cur_line(), "test1.txt", 1, "1");

    OK(in.getline());
    IS_LINE(in.cur_line(), "test1.txt", 2, "2");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "test1.txt", 2, "");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "test1.txt", 2, "");

    in.pop();
    IS_LINE(in.cur_line(), "", 0, "A");

    OK(in.getline());
    IS_LINE(in.cur_line(), "", 0, "B");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "", 0, "");

    NOK(in.getline());
    IS_LINE(in.cur_line(), "", 0, "");

    in.pop();
    IS_LINE(in.cur_line(), "", 0, "");

    // extra pop is no-op
    in.pop();
    IS_LINE(in.cur_line(), "", 0, "");

    remove("test1.txt");
    remove("test2.txt");
    remove("test3.txt");
}
