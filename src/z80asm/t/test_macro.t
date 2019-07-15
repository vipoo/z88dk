#!/usr/bin/perl

# Z88DK Z80 Macro Assembler
#
# Copyright (C) Paulo Custodio, 2011-2018
# License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk/
#
# Test macros

use Modern::Perl;
use Test::More;
require './t/testlib.pl';

unlink_testfiles();

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
	nop
END
check_bin_file("test.bin", pack("C*", 0));
check_text_file("test.lis", <<'END', "list file");
1     0000  00          	nop
2     0001              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define nil 0
#UNDEF  nil
#undef  nil			; ignored
#define nil nop		; define macro
	nil
END
check_bin_file("test.bin", pack("C*", 0));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define nil 0
2     0000              #UNDEF  nil
3     0000              #undef  nil			; ignored
4     0000              #define nil nop		; define macro
5     0000  00          	nil
6     0001              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define label here
.label jp here
END
check_bin_file("test.bin", pack("C*", 0xC3, 0, 0));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define label here
2     0000  C3 00 00    .label jp here
3     0003              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "", 1, "", <<'ERR');
#define nil nop
#define nil nop
	nil
END
Error at file 'test.asm' line 2: macro 'nil' redefined
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#comment
END
check_bin_file("test.bin", "");
check_text_file("test.lis", <<'END', "list file");
1     0000              #comment
2     0000              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "", 1, "", <<'ERR');
#define .3 nop
#define 3 nop
END
Error at file 'test.asm' line 1: syntax error
Error at file 'test.asm' line 2: syntax error
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#DEFINE .one 1
#Define @two 2
#define #three 3
#define $four 4
#define %five 5
#define ._ 6
#define _ 7
defb .one, @two, #three, $four, %five, ._, _, ".one\'";comment
END
check_bin_file("test.bin", pack("C*", 1..7).".one'");
check_text_file("test.lis", <<'END', "list file");
1     0000              #DEFINE .one 1
2     0000              #Define @two 2
3     0000              #define #three 3
4     0000              #define $four 4
5     0000              #define %five 5
6     0000              #define ._ 6
7     0000              #define _ 7
8     0000  01 02 03 04 05 06 07 2E 6F 6E 65 27 
                        defb .one, @two, #three, $four, %five, ._, _, ".one\'";comment
9     000C              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define set equ
one=1
 two    =    2
three  equ  3
four   Equ  4
five   EQU  5
six    set  6
.seven set  7
eight: set  8
defb one,two,three,four,five,six,seven,eight
END
check_bin_file("test.bin", pack("C*", 1..8));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define set equ
2     0000              one=1
3     0000               two    =    2
4     0000              three  equ  3
5     0000              four   Equ  4
6     0000              five   EQU  5
7     0000              six    set  6
8     0000              .seven set  7
9     0000              eight: set  8
10    0000  01 02 03 04 05 06 07 08 
                        defb one,two,three,four,five,six,seven,eight
11    0008              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
aa equ 1\bb equ 2\cc = 3
defb aa,bb,cc
END
check_bin_file("test.bin", pack("C*", 1, 2, 3));
check_text_file("test.lis", <<'END', "list file");
1     0000              aa equ 1\bb equ 2\cc = 3
2     0000  01 02 03    defb aa,bb,cc
3     0003              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
bb equ 1?1:0:cc equ 2:dd = 3
aa:defb aa:defb bb:defb cc\defb dd
END
check_bin_file("test.bin", pack("C*", 0, 1, 2, 3));
check_text_file("test.lis", <<'END', "list file");
1     0000              bb equ 1?1:0:cc equ 2:dd = 3
2     0000  00 01 02 03 aa:defb aa:defb bb:defb cc\defb dd
3     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
 ld b,d\ld c,e
END
check_bin_file("test.bin", pack("C*", 0x42, 0x4B));
check_text_file("test.lis", <<'END', "list file");
1     0000  42 4B        ld b,d\ld c,e
2     0002              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
 defb ASMPC,$:defb ASMPC,$
END
check_bin_file("test.bin", pack("C*", 0, 0, 0, 0));
check_text_file("test.lis", <<'END', "list file");
1     0000  00 00 00 00  defb ASMPC,$:defb ASMPC,$
2     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define continuation_line 1 \
	+ 1 \
	+ 1
	defb continuation_line
END
check_bin_file("test.bin", pack("C*", 3));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define continuation_line 1 \
2     0000              	+ 1 \
3     0000              	+ 1
4     0000  03          	defb continuation_line
5     0001              
END


if (0) {

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define SCREEN_ADDR(row,column,scan) 0x4000 + ((row & 0x18) << 8) + ((row & 0x07) << 5) + (column) + (scan << 8)
	ld de, SCREEN_ADDR(0,0,0)
END
check_bin_file("test.bin", pack("C*", 1..8));
check_text_file("test.lis", <<'END', "list file");
END

}

unlink_testfiles();
done_testing();
