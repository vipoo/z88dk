//-----------------------------------------------------------------------------
// z80asm assembler
// assembly errors
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#include "buffers.h"
#include <string>

struct Errors {
    int count{ 0 };

    void e_file_not_found(const Input& input, const std::string& filename);
    void e_recursive_include(const Input& input, const std::string& filename);

private:
    void header(const Input& input);
    void footer(const Input& input);
};

extern Errors err;      // singleton
