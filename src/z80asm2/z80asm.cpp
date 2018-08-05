//-----------------------------------------------------------------------------
// z80asm assembler
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "ccdefs.h"

int main(int argc, char** argv)
{
    opts.parse(argc, argv);

    if (opts.args.size() == 0) {
        opts.usage();
        return 0;
    }
}
