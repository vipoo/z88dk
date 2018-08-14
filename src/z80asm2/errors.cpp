//-----------------------------------------------------------------------------
// z80asm assembler
// assembly errors
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "errors.h"
#include <cstring>

Errors err;

#define INPUT_ERR(input, out)           \
        header(input);                  \
        std::cerr << out;               \
        footer(input);                  \
        count++

#define PREPROC_ERR(preproc, out)       \
        INPUT_ERR(preproc.input, out);  \
        footer(preproc)

void Errors::e_syntax(const Preproc& preproc)
{
    PREPROC_ERR(preproc, "syntax error");
}

void Errors::e_file_not_found(const Input& input, const std::string& filename)
{
    INPUT_ERR(input, "file '" << filename << "' not found");
}

void Errors::e_read_file(const Input& input, const std::string& filename)
{
    INPUT_ERR(input, "cannot read file '" << filename << "'");
}

void Errors::e_write_file(const Input& input, const std::string& filename)
{
    INPUT_ERR(input, "cannot write file '" << filename << "'");
}

void Errors::e_recursive_include(const Input& input,
                                 const std::string& filename)
{
    INPUT_ERR(input, "cannot include file '" << filename << "' recursively");
}

void Errors::header(const Input& input)
{
    const Line& line = input.cur_line();
    std::cerr << "Error";

    if (strlen(line.filename) != 0 && line.line_nr != 0)
        std::cerr << " at file '" << line.filename << "' line " << line.line_nr;

    std::cerr << ": ";
}

void Errors::footer(const Input&)
{
    std::cerr << std::endl;
}

void Errors::footer(const Preproc& preproc)
{
    if (preproc.p) {
        // show source line
        std::cerr << "\t";
        int col = 0;

        for (const auto& it : preproc.text) {
            if (it == '\t') {
                int spaces = 8 - (col % 8);
                std::cerr << std::string(spaces, ' ');
                col += spaces;
            }
            else {
                std::cerr << it;
                col++;
            }
        }

        std::cerr << std::endl;

        // show arrow
        std::cerr << "\t";
        col = 0;
        int n = 0;

        for (const auto& it : preproc.text) {
            if (preproc.text.c_str() + n == preproc.p)
                break;
            else {
                if (it == '\t') {
                    int spaces = 8 - (col % 8);
                    std::cerr << std::string(spaces, '-');
                    col += spaces;
                }
                else {
                    std::cerr << '-';
                    col++;
                }
            }

            n++;
        }

        std::cerr << "^" << std::endl;
    }
}
