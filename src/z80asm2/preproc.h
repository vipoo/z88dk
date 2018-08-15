//-----------------------------------------------------------------------------
// z80asm assembler
// preprocessor
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#include "buffers.h"

#include <list>
#include <memory>

size_t preproc_max_fill();

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
    void init_scan(const std::string& text_);

    // check if a token follows
    enum { NONE, INCLUDE };
    int is_keyword();
    std::string is_label();

    // assert a token follows, error if not
    std::string get_include_filename();
    bool get_end_of_statement();

    // parse
    bool parse_line();
    bool parse_directive();
    bool parse_opt_label_directive();
    void parse_include();

    std::string label_asm(const std::string& label);
    void do_label(const std::string& label);
    void undo_label(const std::string& label);
};
