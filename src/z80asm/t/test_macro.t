#!/usr/bin/perl

# Z88DK Z80 Macro Assembler
#
# Copyright (C) Paulo Custodio, 2011-2019
# License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk/
#
# Test macros

use Modern::Perl;
use Test::More;
require './t/testlib.pl';

unlink_testfiles();

#------------------------------------------------------------------------------
unlink_testfiles();

z80asm(<<'END', "-b -l");
	nop
END

check_bin_file("test.bin", pack("C*", 0));

check_text_file("test.lis", <<'END', "list file");
1     0000  00          	nop
2     0001              
END

ok !-f "test.i";

#------------------------------------------------------------------------------
unlink_testfiles();

z80asm(<<'END', "-b -l -E");
	nop
END

check_bin_file("test.bin", pack("C*", 0));

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;		nop
	LINE 1, "test.asm"
		nop
END

check_text_file("test.lis", <<'END', "list file");
1     0000  00          	nop
2     0001              
END

#------------------------------------------------------------------------------
unlink_testfiles();

z80asm(<<'END', "-b -l --preproc");
	nop
END

check_bin_file("test.bin", pack("C*", 0));

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;		nop
	LINE 1, "test.asm"
		nop
END

check_text_file("test.lis", <<'END', "list file");
1     0000  00          	nop
2     0001              
END

#------------------------------------------------------------------------------
spew("test.inc", <<'END');
	defb 1,2
END

z80asm(<<'END', "-b -l -E");
	include "test.inc"
	defb 3,4
END

check_bin_file("test.bin", pack("C*", 1..4));

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;		include "test.inc"
	LINE 1, "test.asm"
		include "test.inc"
;	LINE 1, "test.inc"
;		defb 1,2
	LINE 1, "test.inc"
		defb 1,2
;	LINE 2, "test.asm"
;		defb 3,4
	LINE 2, "test.asm"
		defb 3,4
END

check_text_file("test.lis", <<'END', "list file");
1     0000              	include "test.inc"
1     0000  01 02       	defb 1,2
2     0002              
2     0002  03 04       	defb 3,4
3     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#define nil 0
#UNDEF  nil
#undef  nil			; ignored
#define nil nop		; define macro
	nil				; comment
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define nil 0
;	LINE 2, "test.asm"
;	#UNDEF  nil
;	LINE 3, "test.asm"
;	#undef  nil			; ignored
;	LINE 4, "test.asm"
;	#define nil nop		; define macro
;	LINE 5, "test.asm"
;		nil				; comment
	LINE 5, "test.asm"
		nop				
END

check_bin_file("test.bin", pack("C*", 0));

check_text_file("test.lis", <<'END', "list file");
1     0000              #define nil 0
2     0000              #UNDEF  nil
3     0000              #undef  nil			; ignored
4     0000              #define nil nop		; define macro
5     0000  00          	nil				; comment
6     0001              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#define label here
.label jp here
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define label here
;	LINE 2, "test.asm"
;	.label jp here
	LINE 2, "test.asm"
	.here jp here
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
Error at 'test.asm' line 2: macro 'nil' redefined
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#comment
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#comment
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
Error at 'test.asm' line 1: syntax error
Error at 'test.asm' line 2: syntax error
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#DEFINE .one 1
#Define @two 2
#define #three 3
#define $four 4
#define %five 5
#define ._ 6
#define _ 7
defb .one, @two, #three, $four, %five, ._, _, ".one\'";comment
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#DEFINE .one 1
;	LINE 2, "test.asm"
;	#Define @two 2
;	LINE 3, "test.asm"
;	#define #three 3
;	LINE 4, "test.asm"
;	#define $four 4
;	LINE 5, "test.asm"
;	#define %five 5
;	LINE 6, "test.asm"
;	#define ._ 6
;	LINE 7, "test.asm"
;	#define _ 7
;	LINE 8, "test.asm"
;	defb .one, @two, #three, $four, %five, ._, _, ".one\'";comment
	LINE 8, "test.asm"
	defb 1, 2, 3, 4, 5, 6, 7, ".one\'"
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
z80asm(<<'END', "-b -l -E");
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

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define set equ
;	LINE 2, "test.asm"
;	one=1
	LINE 2, "test.asm"
	defc one = 1
;	LINE 3, "test.asm"
;	 two    =    2
	LINE 3, "test.asm"
	defc two =     2
;	LINE 4, "test.asm"
;	three  equ  3
	LINE 4, "test.asm"
	defc three =   3
;	LINE 5, "test.asm"
;	four   Equ  4
	LINE 5, "test.asm"
	defc four =   4
;	LINE 6, "test.asm"
;	five   EQU  5
	LINE 6, "test.asm"
	defc five =   5
;	LINE 7, "test.asm"
;	six    set  6
	LINE 7, "test.asm"
	defc six =   6
;	LINE 8, "test.asm"
;	.seven set  7
	LINE 8, "test.asm"
	defc seven =   7
;	LINE 9, "test.asm"
;	eight: set  8
	LINE 9, "test.asm"
	defc eight =   8
;	LINE 10, "test.asm"
;	defb one,two,three,four,five,six,seven,eight
	LINE 10, "test.asm"
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
z80asm(<<'END', "-b -l -E");
aa equ 1\bb equ 2\cc = 3
defb aa,bb,cc
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	aa equ 1\bb equ 2\cc = 3
	LINE 1, "test.asm"
	defc aa =  1
	LINE 1, "test.asm"
	defc bb =  2
	LINE 1, "test.asm"
	defc cc =  3
;	LINE 2, "test.asm"
;	defb aa,bb,cc
	LINE 2, "test.asm"
	defb aa,bb,cc
END

check_bin_file("test.bin", pack("C*", 1, 2, 3));

check_text_file("test.lis", <<'END', "list file");
1     0000              aa equ 1\bb equ 2\cc = 3
2     0000  01 02 03    defb aa,bb,cc
3     0003              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
bb equ 1?1:0:cc equ 2:dd = 3
aa:defb aa:defb bb:defb cc\defb dd
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	bb equ 1?1:0:cc equ 2:dd = 3
	LINE 1, "test.asm"
	defc bb =  1?1:0
	LINE 1, "test.asm"
	defc cc =  2
	LINE 1, "test.asm"
	defc dd =  3
;	LINE 2, "test.asm"
;	aa:defb aa:defb bb:defb cc\defb dd
	LINE 2, "test.asm"
	aa:defb aa
	LINE 2, "test.asm"
	defb bb
	LINE 2, "test.asm"
	defb cc
	LINE 2, "test.asm"
	defb dd
END

check_bin_file("test.bin", pack("C*", 0, 1, 2, 3));

check_text_file("test.lis", <<'END', "list file");
1     0000              bb equ 1?1:0:cc equ 2:dd = 3
2     0000  00 01 02 03 aa:defb aa:defb bb:defb cc\defb dd
3     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
 ld b,d\ld c,e
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	 ld b,d\ld c,e
	LINE 1, "test.asm"
	 ld b,d
	LINE 1, "test.asm"
	ld c,e
END

check_bin_file("test.bin", pack("C*", 0x42, 0x4B));

check_text_file("test.lis", <<'END', "list file");
1     0000  42 4B        ld b,d\ld c,e
2     0002              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
 defb ASMPC,$:defb ASMPC,$
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	 defb ASMPC,$:defb ASMPC,$
	LINE 1, "test.asm"
	 defb ASMPC,$
	LINE 1, "test.asm"
	defb ASMPC,$
END

check_bin_file("test.bin", pack("C*", 0, 0, 0, 0));

check_text_file("test.lis", <<'END', "list file");
1     0000  00 00 00 00  defb ASMPC,$:defb ASMPC,$
2     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#define continuation_line 1 \
	+ 1 \
	+ 1
	defb continuation_line
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define continuation_line 1 \
;	LINE 2, "test.asm"
;		+ 1 \
;	LINE 3, "test.asm"
;		+ 1
;	LINE 4, "test.asm"
;		defb continuation_line
	LINE 4, "test.asm"
		defb 1  	+ 1  	+ 1
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
z80asm(<<'END', "-b -l -E");
#define continuation_line 1 \
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define continuation_line 1 \
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
Error at 'test.asm' line 1: #defcont without #define
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#define 	mult8
#defcont 	add hl,hl
#defcont 	add hl,hl
#defcont 	add hl,hl
	ld hl,3
	mult8
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define 	mult8
;	LINE 2, "test.asm"
;	#defcont 	add hl,hl
;	LINE 3, "test.asm"
;	#defcont 	add hl,hl
;	LINE 4, "test.asm"
;	#defcont 	add hl,hl
;	LINE 5, "test.asm"
;		ld hl,3
	LINE 5, "test.asm"
		ld hl,3
;	LINE 6, "test.asm"
;		mult8
	LINE 6, "test.asm"
		add hl,hl
	LINE 6, "test.asm"
	add hl,hl
	LINE 6, "test.asm"
	add hl,hl
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
z80asm(<<'END', "-b -l -E");
#define aaa 22
#define bbb 20
#define ccc aaa+bbb
	defb ccc
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define aaa 22
;	LINE 2, "test.asm"
;	#define bbb 20
;	LINE 3, "test.asm"
;	#define ccc aaa+bbb
;	LINE 4, "test.asm"
;		defb ccc
	LINE 4, "test.asm"
		defb 22+20
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
z80asm(<<'END', "-b -l -E");
#define aaa bbb
#define bbb ccc
#define ccc 1
	defb aaa
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define aaa bbb
;	LINE 2, "test.asm"
;	#define bbb ccc
;	LINE 3, "test.asm"
;	#define ccc 1
;	LINE 4, "test.asm"
;		defb aaa
	LINE 4, "test.asm"
		defb 1
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
Error at 'test.asm' line 4: recursion expanding macro 'aaa'
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
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

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define SCREEN_ADDR(row,column,scan) \
;	LINE 2, "test.asm"
;			0x4000 + \
;	LINE 3, "test.asm"
;			((row & 0x18) << 8) + \
;	LINE 4, "test.asm"
;			((row & 0x07) << 5) + \
;	LINE 5, "test.asm"
;			(column) + (scan << 8)
;	LINE 6, "test.asm"
;		ld de, SCREEN_ADDR(0,0,0);comment
	LINE 6, "test.asm"
		ld de,  		0x4000 +  		((0 & 0x18) << 8) +  		((0 & 0x07) << 5) +  		(0) + (0 << 8)
;	LINE 7, "test.asm"
;		ld de, SCREEN_ADDR 0,0,0; comment
	LINE 7, "test.asm"
		ld de,  		0x4000 +  		((0 & 0x18) << 8) +  		((0 & 0x07) << 5) +  		(0) + (0 << 8)
;	LINE 8, "test.asm"
;		ld de, SCREEN_ADDR 0,1,0; comment
	LINE 8, "test.asm"
		ld de,  		0x4000 +  		((0 & 0x18) << 8) +  		((0 & 0x07) << 5) +  		(1) + (0 << 8)
;	LINE 9, "test.asm"
;		ld de, SCREEN_ADDR 1,0,0; comment
	LINE 9, "test.asm"
		ld de,  		0x4000 +  		((1 & 0x18) << 8) +  		((1 & 0x07) << 5) +  		(0) + (0 << 8)
;	LINE 10, "test.asm"
;		ld de, SCREEN_ADDR 0,0,1; comment
	LINE 10, "test.asm"
		ld de,  		0x4000 +  		((0 & 0x18) << 8) +  		((0 & 0x07) << 5) +  		(0) + (1 << 8)
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
z80asm(<<'END', "-b -l -E");
#define aa(x,y) (x+y)
#define bb(a,b) aa(a,b)*aa(a,b)
	defb bb(2,4)
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define aa(x,y) (x+y)
;	LINE 2, "test.asm"
;	#define bb(a,b) aa(a,b)*aa(a,b)
;	LINE 3, "test.asm"
;		defb bb(2,4)
	LINE 3, "test.asm"
		defb (2+4)*(2+4)
END

check_bin_file("test.bin", pack("C*", 36));

check_text_file("test.lis", <<'END', "list file");
1     0000              #define aa(x,y) (x+y)
2     0000              #define bb(a,b) aa(a,b)*aa(a,b)
3     0000  24          	defb bb(2,4)
4     0001              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#define aa(x,y) (x+y)
#define bb(a,b) aa(a,b)*aa a,b
	defb bb 2,4;
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define aa(x,y) (x+y)
;	LINE 2, "test.asm"
;	#define bb(a,b) aa(a,b)*aa a,b
;	LINE 3, "test.asm"
;		defb bb 2,4;
	LINE 3, "test.asm"
		defb (2+4)*(2+4)
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
Error at 'test.asm' line 2: missing macro arguments
ERR

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#define aa(x,y) (x+y)
	defb "aa(2,3)"
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define aa(x,y) (x+y)
;	LINE 2, "test.asm"
;		defb "aa(2,3)"
	LINE 2, "test.asm"
		defb "aa(2,3)"
END

check_bin_file("test.bin", "aa(2,3)");

check_text_file("test.lis", <<'END', "list file");
1     0000              #define aa(x,y) (x+y)
2     0000  61 61 28 32 2C 33 29 
                        	defb "aa(2,3)"
3     0007              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#define aa(x) x
	defb aa(<1,2,3>),4
	defb aa(<5,6,7>)
	defb aa<8,9,10>
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define aa(x) x
;	LINE 2, "test.asm"
;		defb aa(<1,2,3>),4
	LINE 2, "test.asm"
		defb 1,2,3,4
;	LINE 3, "test.asm"
;		defb aa(<5,6,7>)
	LINE 3, "test.asm"
		defb 5,6,7
;	LINE 4, "test.asm"
;		defb aa<8,9,10>
	LINE 4, "test.asm"
		defb 8,9,10
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
z80asm(<<'END', "-b -l -E");
#define VERSION 1.23
	defb # VERSION
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define VERSION 1.23
;	LINE 2, "test.asm"
;		defb # VERSION
	LINE 2, "test.asm"
		defb "1.23"
END

check_bin_file("test.bin", "1.23");

check_text_file("test.lis", <<'END', "list file");
1     0000              #define VERSION 1.23
2     0000  31 2E 32 33 	defb # VERSION
3     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
#define aa(x) # x
	defb aa(1.23)
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define aa(x) # x
;	LINE 2, "test.asm"
;		defb aa(1.23)
	LINE 2, "test.asm"
		defb "1.23"
END

check_bin_file("test.bin", "1.23");

check_text_file("test.lis", <<'END', "list file");
1     0000              #define aa(x) # x
2     0000  31 2E 32 33 	defb aa(1.23)
3     0004              
END

#------------------------------------------------------------------------------
z80asm(<<'END', "-b -l -E");
	defb # VERSION
	defb #VERSION
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;		defb # VERSION
	LINE 1, "test.asm"
		defb "VERSION"
;	LINE 2, "test.asm"
;		defb #VERSION
	LINE 2, "test.asm"
		defb "VERSION"
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
z80asm(<<'END', "-b -l -E");
	defb # 523
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;		defb # 523
	LINE 1, "test.asm"
		defb "523"
END

check_bin_file("test.bin", "523");

check_text_file("test.lis", <<'END', "list file");
1     0000  35 32 33    	defb # 523
2     0003              
END

#------------------------------------------------------------------------------
# z80asm: stringify numeric constant in defm #864
# https://github.com/z88dk/z88dk/issues/864
SKIP: {
skip "Does not work with DEFC constants", 1;

z80asm(<<'END', "-b -l -E");
	defc CORE_VERSION = 14010
	defm "Requires Core v", #CORE_VERSION, ' '+0x80
END

check_text_file("test.i", <<'END', "preproc file");
END

check_bin_file("test.bin", "Requires Core v14010".chr(ord(' ')+0x80));

check_text_file("test.lis", <<'END', "list file");
END
}

z80asm(<<'END', "-b -l -E");
#define CORE_VERSION 14010
	defm "Requires Core v", # CORE_VERSION, ' '+0x80
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define CORE_VERSION 14010
;	LINE 2, "test.asm"
;		defm "Requires Core v", # CORE_VERSION, ' '+0x80
	LINE 2, "test.asm"
		defm "Requires Core v", "14010", ' '+0x80
END

check_bin_file("test.bin", "Requires Core v14010".chr(ord(' ')+0x80));

check_text_file("test.lis", <<'END', "list file");
1     0000              #define CORE_VERSION 14010
2     0000  52 65 71 75 69 72 65 73 20 43 6F 72 65 20 76 31 34 30 31 30 A0 
                        	defm "Requires Core v", # CORE_VERSION, ' '+0x80
3     0015              
END


#------------------------------------------------------------------------------
# ##-operator
z80asm(<<'END', "-b -l -E");
#define aaa 2
#define bbb 3
	defb aaa ## bbb
END

check_text_file("test.i", <<'END', "preproc file");
;	LINE 1, "test.asm"
;	#define aaa 2
;	LINE 2, "test.asm"
;	#define bbb 3
;	LINE 3, "test.asm"
;		defb aaa ## bbb
	LINE 3, "test.asm"
		defb 23
END

check_bin_file("test.bin", pack("C*", 23));

check_text_file("test.lis", <<'END', "list file");
1     0000              #define aaa 2
2     0000              #define bbb 3
3     0000  17          	defb aaa ## bbb
4     0001              
END

unlink_testfiles();
done_testing();
