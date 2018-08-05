//-----------------------------------------------------------------------------
// z80asm assembler
// command line options
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "ccdefs.h"

Options opts;

void Options::usage()
{
	std::cout << "Usage: z80asm2 [options] [files]" << std::endl
		<< "Options:" << std::endl
		<< "  -v    verbose" << std::endl
		<< "  -Idir add directory to include path" << std::endl;
}

bool Options::parse(int argc, char ** argv)
{
	int argi;
	char *argp;

	for (argi = 1; argi < argc; argi++) {
		argp = argv[argi];
		switch (*argp++) {			// 1st char
		case '-':
			switch (*argp++) {		// 2nd char
			case 'I':
				if (*argp) {
					include_path.push_back(argp);
					continue;
				}
				else if (++argi < argc) {
					include_path.push_back(argv[argi]);
					continue;
				}
				else {
					std::cerr << "Option -I requires argument" << std::endl;
					return false;
				}
			case 'v':
				if (!*argp) {
					verbose = true;
					continue;
				}
				else {
					std::cerr << "Unknown option " << argv[argi] << std::endl;
					return false;
				}
			default:
				std::cerr << "Unknown option " << argv[argi] << std::endl;
				return false;
			}
			break;

		default:
			args.push_back(argv[argi]);
			continue;
		}
	}
	return true;
}
