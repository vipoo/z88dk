/*
Z88DK Z80 Module Assembler

Copyright (C) Paulo Custodio, 2011-2017
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk

Main function
*/
#ifdef __cplusplus
	extern "C" int z80asm_main(int argc, char *argv[]);
#else
	#include "z80asm.h"
#endif
#include "assembler.h"

extern zasm_t* g_zasm;


int main(int argc, char *argv[])
{
	g_zasm = zasm_new();

	int rv = z80asm_main(argc, argv);

	zasm_free(g_zasm);

	return rv;
}
