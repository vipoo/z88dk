//-----------------------------------------------------------------------------
// z80asm assembler
// preprocessor
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#include "buffers.h"

#include <list>
#include <memory>

// preprocess a source file, produce a list of Line objects
struct Preproc {
    Input input;
    std::list<std::shared_ptr<Line> > lines;

    virtual ~Preproc();

    // preprocess a file, output to lines
    // called recursively by INCLUDE
    void process(const std::string& filename);

    // preprocess file.asm, build file.i
    static void do_process(const std::string& asm_filename);

private:
    // scanner
    std::string text;                   // scanned text
    const char* p{ nullptr };           // scan pointer
    void init_scan(const std::string& text_);

    enum { NONE, INCLUDE };
    int get_keyword();
    std::string get_include_filename();
    bool check_end();

    bool parse_line();
    bool parse_directive();
    void parse_include();

    void parse();
};
