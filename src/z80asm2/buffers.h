//-----------------------------------------------------------------------------
// z80asm assembler
// input buffers
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#include "utils.h"

#include <fstream>
#include <memory>
#include <string>

// one input line - keep filename and line_nr through parsing
struct Line {
    Atom    filename{ "" };
    int     line_nr{ 0 };
    std::string text;

    Line(const std::string& filename_ = "", int line_nr_ = 0,
         const std::string& text_ = "");
};

// one input buffer from input file or macro expansion
struct Buffer {
    Line    cur_line;       // current input line, updated by getline()
    bool    pushed_include_path{ false };

    Buffer(const std::string& filename_ = "", int line_nr_ = 0);
    virtual ~Buffer();

private:
    std::ifstream   ifs;
    std::string     text;           // pushed text
    size_t          textp{ 0 };     // point at next pushed text to return

public:
    // open a file, return false on error
    bool open_file(const std::string& filename_);

    // prepare to parse a text block
    void push_text(const std::string& text_);

    // get a line from text_buffer or from file, return false on end of input
    // newline characater is discarded
    bool getline();
};

// stack of input contexts to handle includes
struct Input {
    std::vector<std::shared_ptr<Buffer> > stack;

    // return current input in top buffer, ("",0,"") if stack empty
    const Line& cur_line() const;

    // push a new buffer to return the given text
    void push_text(const std::string& text);

    // try to open file and push it to the stack
    // returns false, error messages and does not open file
    // if file not found or recursive include
    bool push_file(const std::string& filename_);

    // pop one file/text
    void pop();

    // get first/next line of the top buffer, return false on end of input
    bool getline();

private:
    // true if file open in input stack
    bool has_file_open(const std::string& filename) const;
};
