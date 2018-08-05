//-----------------------------------------------------------------------------
// z80asm assembler
// command line options
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#include <string>
#include <vector>

struct Options
{
	bool						verbose;
	std::vector<std::string>	include_path;		// -I option
	std::vector<std::string>	args;				// input file names

	// parse options, return true if no errors
	bool parse(int argc, char **argv);

	static void usage();
};

extern Options opts;		// singleton
