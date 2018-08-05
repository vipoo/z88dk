//-----------------------------------------------------------------------------
// z80asm unit tests
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "test.h"
#include "../ccdefs.h"

void test_options_ok()
{
	char **argv = (char**)calloc(8, sizeof(char*));
	argv[0] = strdup("z80asm2");
	argv[1] = strdup("file1.asm");
	argv[2] = strdup("-v");
	argv[3] = strdup("-I");
	argv[4] = strdup("dir1");
	argv[5] = strdup("file2.asm");
	argv[6] = strdup("-Idir2");
	argv[7] = strdup("file3.asm");

	OK(opts.parse(8, argv));

	OK(opts.verbose);

	IS(opts.args.size(), 3);
	IS_STR(opts.args[0], "file1.asm");
	IS_STR(opts.args[1], "file2.asm");
	IS_STR(opts.args[2], "file3.asm");

	IS(opts.include_path.size(), 2);
	IS_STR(opts.include_path[0], "dir1");
	IS_STR(opts.include_path[1], "dir2");

	for (int i = 0; i < 8; i++)
		free(argv[i]);
	free(argv);
}

void test_options_v_error()
{
	char **argv = (char**)calloc(2, sizeof(char*));
	argv[0] = strdup("z80asm2");
	argv[1] = strdup("-vx");

	bool ok;
	START_CAPTURE();
	ok = opts.parse(2, argv);
	END_CAPTURE("", "Unknown option -vx\n");
	OK(!ok);

	for (int i = 0; i < 2; i++)
		free(argv[i]);
	free(argv);
}

void test_options_I_error()
{
	char **argv = (char**)calloc(2, sizeof(char*));
	argv[0] = strdup("z80asm2");
	argv[1] = strdup("-I");

	bool ok;
	START_CAPTURE();
	ok = opts.parse(2, argv);
	END_CAPTURE("", "Option -I requires argument\n");
	OK(!ok);

	for (int i = 0; i < 2; i++)
		free(argv[i]);
	free(argv);
}

