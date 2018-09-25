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

int main(int argc, char *argv[])
{
	return z80asm_main(argc, argv);
}
