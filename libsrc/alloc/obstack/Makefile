#
# Wahey, a messed up makefile for building libraries!
#
# $Id: Makefile,v 1.24 2016-07-02 14:44:33 dom Exp $

include ../../Make.config

TARGET ?= test

NEWLIBGLOBS := "$(NEWLIB_DIRECTORY)/alloc/obstack/c/sccz80/*.asm" "$(NEWLIB_DIRECTORY)/alloc/obstack/z80/*.asm"
NEWLIB_TARGETS := obj/newlib-z80 obj/newlib-z80n obj/newlib-r2k obj/newlib-ixiy obj/newlib-8080

space :=
space +=

OBJECTS = $(CLASSIC_OBJECTS) 

.PHONY: dirs  $(NEWLIB_TARGETS)

all: dirs $(OBJECTS) $(NEWLIB_TARGETS)

obj/newlib-z80:  
	@$(ASSEMBLER) -O=obj/z80/x -I.. -mz80 -D__CLASSIC $(NEWLIBGLOBS)

obj/newlib-r2k:  
	@$(ASSEMBLER) -O=obj/r2k/x -I.. -mr2k -D__CLASSIC $(NEWLIBGLOBS)

obj/newlib-z80n:  
	@$(ASSEMBLER) -O=obj/z80n/x -I.. -mz80n -D__CLASSIC $(NEWLIBGLOBS)

obj/newlib-ixiy:  
	@$(ASSEMBLER) -O=obj/ixiy/x -I.. -mz80 -IXIY -D__CLASSIC $(NEWLIBGLOBS)

obj/newlib-8080:  
	@$(ASSEMBLER) -O=obj/8080/x -I.. -m8080 -D__CLASSIC $(NEWLIBGLOBS)

dirs:
	@mkdir -p obj/z80 obj/z80n obj/ixiy obj/r2k obj/8080


clean:
	$(RM) -fr obj 
