//-----------------------------------------------------------------------------
// z80asm unit tests
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "test.h"

static int count_run = 0;
static int count_failed = 0;

RedirectOutput::RedirectOutput()
    : old_out(std::cout.rdbuf(out_buffer.rdbuf()))
    , old_err(std::cerr.rdbuf(err_buffer.rdbuf()))
{}

RedirectOutput::~RedirectOutput()
{
    std::cout.rdbuf(old_out);
    std::cerr.rdbuf(old_err);
}

std::string RedirectOutput::out() const
{
    return out_buffer.str();
}

std::string RedirectOutput::err() const
{
    return err_buffer.str();
}

static void print_summary()
{
    std::cout << "1.." << count_run << std::endl;

    if (count_failed)
        DIAG("Failed " << count_failed << " test"
             << (count_failed > 1 ? "s" : "") << " of " << count_run);
}

void is_ok(bool value, const std::string& filename, int line_nr)
{
    count_run++;

    if (!value)
        std::cout << "not ";

    std::cout << "ok " << count_run << std::endl;

    if (!value) {
        count_failed++;
        DIAG("Failed test at " << filename << " line " << line_nr);
    }
}

int main()
{
    try {
#include "test.def"
        PASS();
    }
    catch (std::exception& e) {
        FAIL();
        DIAG(e.what());
    }

    print_summary();

    if (!count_failed)
        return EXIT_SUCCESS;
    else
        return EXIT_FAILURE;
}
