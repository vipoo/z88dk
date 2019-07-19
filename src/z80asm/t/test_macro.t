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

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define continuation_line 1 \
END
check_bin_file("test.bin", "");
check_text_file("test.lis", <<'END', "list file");
1     0000              #define continuation_line 1 \
2     0000              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "", 1, "", <<'ERR');
#defcont 	add hl,hl
END
Error at file 'test.asm' line 1: #defcont without #define
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define 	mult8
#defcont 	add hl,hl
#defcont 	add hl,hl
#defcont 	add hl,hl
	ld hl,3
	mult8
END
check_bin_file("test.bin", pack("C*", 0x21, 3, 0, 0x29, 0x29, 0x29));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define 	mult8
2     0000              #defcont 	add hl,hl
3     0000              #defcont 	add hl,hl
4     0000              #defcont 	add hl,hl
5     0000  21 03 00    	ld hl,3
6     0003  29 29 29    	mult8
7     0006              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define aaa 22
#define bbb 20
#define ccc aaa+bbb
	defb ccc
END
check_bin_file("test.bin", pack("C*", 42));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define aaa 22
2     0000              #define bbb 20
3     0000              #define ccc aaa+bbb
4     0000  2A          	defb ccc
5     0001              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define aaa bbb
#define bbb ccc
#define ccc 1
	defb aaa
END
check_bin_file("test.bin", pack("C*", 1));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define aaa bbb
2     0000              #define bbb ccc
3     0000              #define ccc 1
4     0000  01          	defb aaa
5     0001              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "", 1, "", <<'ERR');
#define aaa bbb
#define bbb ccc
#define ccc aaa
	defb aaa
END
Error at file 'test.asm' line 4: recursion expanding macro 'aaa'
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define SCREEN_ADDR(row,column,scan) \
		0x4000 + \
		((row & 0x18) << 8) + \
		((row & 0x07) << 5) + \
		(column) + (scan << 8)
	ld de, SCREEN_ADDR(0,0,0);comment
	ld de, SCREEN_ADDR 0,0,0; comment
	ld de, SCREEN_ADDR 0,1,0; comment
	ld de, SCREEN_ADDR 1,0,0; comment
	ld de, SCREEN_ADDR 0,0,1; comment
END
check_bin_file("test.bin", pack("C*", 
							0x11, 0x00, 0x40,
							0x11, 0x00, 0x40,
							0x11, 0x01, 0x40,
							0x11, 0x20, 0x40,
							0x11, 0x00, 0x41));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define SCREEN_ADDR(row,column,scan) \
2     0000              		0x4000 + \
3     0000              		((row & 0x18) << 8) + \
4     0000              		((row & 0x07) << 5) + \
5     0000              		(column) + (scan << 8)
6     0000  11 00 40    	ld de, SCREEN_ADDR(0,0,0);comment
7     0003  11 00 40    	ld de, SCREEN_ADDR 0,0,0; comment
8     0006  11 01 40    	ld de, SCREEN_ADDR 0,1,0; comment
9     0009  11 20 40    	ld de, SCREEN_ADDR 1,0,0; comment
10    000C  11 00 41    	ld de, SCREEN_ADDR 0,0,1; comment
11    000F              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define aa(x,y) (x+y)
#define bb(a,b) aa(a,b)*aa(a,b)
	defb bb(2,4)
END
check_bin_file("test.bin", pack("C*", 36));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define aa(x,y) (x+y)
2     0000              #define bb(a,b) aa(a,b)*aa(a,b)
3     0000  24          	defb bb(2,4)
4     0001              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define aa(x,y) (x+y)
#define bb(a,b) aa(a,b)*aa a,b
	defb bb 2,4;
END
check_bin_file("test.bin", pack("C*", 36));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define aa(x,y) (x+y)
2     0000              #define bb(a,b) aa(a,b)*aa a,b
3     0000  24          	defb bb 2,4;
4     0001              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "", 1, "", <<'ERR');
#define aaa(a,b)	a+b
	defb aaa
END
Error at file 'test.asm' line 2: missing macro arguments
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define aa(x,y) (x+y)
	defb "aa(2,3)"
END
check_bin_file("test.bin", pack("C*", 0x61, 0x61, 0x28, 0x32, 0x2C, 0x33, 0x29));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define aa(x,y) (x+y)
2     0000  61 61 28 32 2C 33 29 
                        	defb "aa(2,3)"
3     0007              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define aa(x) x
	defb aa(<1,2,3>),4
	defb aa(<5,6,7>)
	defb aa<8,9,10>
END
check_bin_file("test.bin", pack("C*", 1..10));
check_text_file("test.lis", <<'END', "list file");
1     0000              #define aa(x) x
2     0000  01 02 03 04 	defb aa(<1,2,3>),4
3     0004  05 06 07    	defb aa(<5,6,7>)
4     0007  08 09 0A    	defb aa<8,9,10>
5     000A              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define VERSION 1.23
	defb # VERSION
END
check_bin_file("test.bin", "1.23");
check_text_file("test.lis", <<'END', "list file");
1     0000              #define VERSION 1.23
2     0000  31 2E 32 33 	defb # VERSION
3     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
#define aa(x) # x
	defb aa(1.23)
END
check_bin_file("test.bin", "1.23");
check_text_file("test.lis", <<'END', "list file");
1     0000              #define aa(x) # x
2     0000  31 2E 32 33 	defb aa(1.23)
3     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
	defb # VERSION
	defb #VERSION
END
check_bin_file("test.bin", "VERSION" x 2);
check_text_file("test.lis", <<'END', "list file");
1     0000  56 45 52 53 49 4F 4E 
                        	defb # VERSION
2     0007  56 45 52 53 49 4F 4E 
                        	defb #VERSION
3     000E              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l");
	defb # 523
END
check_bin_file("test.bin", "523");
check_text_file("test.lis", <<'END', "list file");
1     0000  35 32 33    	defb # 523
2     0003              
END

#------------------------------------------------------------------------------
# z80asm: stringify numeric constant in defm #864
# https://github.com/z88dk/z88dk/issues/864
z80asm(<<'END', "-b -l");
	defc CORE_VERSION = 14010
	defm "Requires Core v", #CORE_VERSION, ' '+0x80
END
check_bin_file("test.bin", "Requires Core v14010".chr(ord(' ')+0x80));
check_text_file("test.lis", <<'END', "list file");
1     0000              	defc CORE_VERSION = 14010
2     0000  52 65 71 75 69 72 65 73 20 43 6F 72 65 20 76 43 4F 52 45 5F 56 45 52 53 49 4F 4E A0 
                        	defm "Requires Core v", #CORE_VERSION, ' '+0x80
3     001C              
END

unlink_testfiles();
done_testing();
