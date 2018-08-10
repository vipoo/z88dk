//-----------------------------------------------------------------------------
// z80asm assembler
// assembly errors
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "ccdefs.h"

Errors err;

#define ERR(out)            \
        header(input);      \
        std::cerr << out;   \
        footer(input);      \
        count++

void Errors::e_syntax(const Input& input)
{
    ERR("syntax error");
}

void Errors::e_file_not_found(const Input& input, const std::string& filename)
{
    ERR("file '" << filename << "' not found");
}

void Errors::e_read_file(const Input& input, const std::string& filename)
{
    ERR("cannot read file '" << filename << "'");
}

void Errors::e_write_file(const Input& input, const std::string& filename)
{
    ERR("cannot write file '" << filename << "'");
}

void Errors::e_recursive_include(const Input& input,
                                 const std::string& filename)
{
    ERR("cannot include file '" << filename << "' recursively");
}

void Errors::header(const Input& input)
{
    const Line line = input.cur_line();
    std::cerr << "Error";

    if (strlen(line.filename) != 0 && line.line_nr != 0)
        std::cerr << " at file '" << line.filename << "' line " << line.line_nr;

    std::cerr << ": ";
}

void Errors::footer(const Input&)
{
    std::cerr << std::endl;
}
