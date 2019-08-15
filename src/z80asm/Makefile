#------------------------------------------------------------------------------
# Z88DK Z80 Module Assembler
#
# Copyright (C) Paulo Custodio, 2011-2019
# License: http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk
#------------------------------------------------------------------------------
PROJ			:= z80asm

# EXESUFFIX is passed when cross-compiling Win32 on Linux
ifeq ($(OS),Windows_NT)
  EXESUFFIX 	:= .exe
else
  EXESUFFIX 	?=
endif

# UNIXem is needed in both Windows_NT and in a MinGW build in Unix
ifeq ($(EXESUFFIX),.exe)
  UNIXem_CFLAGS	:= -I../../ext/UNIXem/include
  UNIXem_OBJS	:= ../../ext/UNIXem/src/glob.o \
				   ../../ext/UNIXem/src/dirent.o
endif

CC 				?= gcc
INSTALL 		?= install
CROSS			?= 0

ASTYLE			:= astyle --project=.astylerc

#------------------------------------------------------------------------------
# Object files
#------------------------------------------------------------------------------
SRCS			:= $(filter-out test.c,$(wildcard *.c lib/*.c ../common/*.c ../../ext/regex/reg*.c))
OBJS 			:= $(SRCS:.c=.o) \
				   $(UNIXem_OBJS)
DEPENDS			:= $(SRCS:.c=.d)
TEST_SRC_MAIN	:= $(wildcard t/test_*.c)
TEST_SRC_LIB	:= t/testlib.c

#------------------------------------------------------------------------------
# variables
#------------------------------------------------------------------------------
TARGET 			= $(PROJ)$(EXESUFFIX)

OPT 			= -O3

STD 			= -std=gnu11
LOCAL_LIB 		:= lib
LOCAL_CFLAGS 	+= -MMD -I. -I$(LOCAL_LIB) -It -g -Wall $(STD) $(OPT) \
				   -I../common \
				   -I../../ext/optparse \
				   -I../../ext/regex \
				   -I../../ext/uthash/src \
				   $(UNIXem_CFLAGS)

#------------------------------------------------------------------------------
# main
#------------------------------------------------------------------------------
.PHONY: all

all: $(TARGET)

$(TARGET): ../config.h $(OBJS)
	$(CC) $(LOCAL_CFLAGS) $(CFLAGS) -o $(TARGET) $(OBJS) $(LDFLAGS)

../config.h:
	@echo \#define PREFIX \"/usr/local/share/z88dk\" 				 > $@
	@echo \#define UNIX 1											>> $@
	@echo \#define EXEC_PREFIX \"\"									>> $@
	@echo \#define Z88DK_VERSION \"build-$(shell date +%Y%m%d)\"	>> $@

%.o: %.c
	$(CC) $(LOCAL_CFLAGS) $(CFLAGS) -c -o $@ $<

# parser is too big to optimize with -O3
parse.o: parse.c
	$(CC) $(LOCAL_CFLAGS) $(CFLAGS) -O0 -c -o $@ $<

#------------------------------------------------------------------------------
# libraries
#------------------------------------------------------------------------------
.PHONY: z80asm_lib
all: z80asm_lib

z80asm_lib:
ifeq ($(CROSS),0)
	$(MAKE) -C dev/z80asm_lib
	cp dev/z80asm_lib/$(PROJ)-*.lib .
endif

clean::
	$(MAKE) -C dev/z80asm_lib clean
	$(RM) $(PROJ)-*.lib

#------------------------------------------------------------------------------
# developer generated source files, and test libs
#------------------------------------------------------------------------------
.PHONY: dev
dev:
	$(MAKE) -C tt
	$(MAKE) -C lib
	$(MAKE) -f dev/Makefile
	$(MAKE) astyle
	$(MAKE) all


clean::
	$(MAKE) -C lib clean

#------------------------------------------------------------------------------
# intall
#------------------------------------------------------------------------------
install: $(TARGET) z80asm_lib
	$(INSTALL) $(TARGET)     $(PREFIX)/bin/$(EXEC_PREFIX)$(TARGET)
	$(INSTALL) asmpp.pl      $(PREFIX)/bin/asmpp.pl
	$(MAKE) -C dev/z80asm_lib install PREFIX=$(PREFIX_SHARE)

#------------------------------------------------------------------------------
# clean
#------------------------------------------------------------------------------
clean::
	$(RM) *.core $(LOCAL_LIB)/*.core $(LOCAL_LIB)/t/*.core $(LOCAL_LIB)/t/uthash/*.core
	$(RM) *.o    $(LOCAL_LIB)/*.o    $(LOCAL_LIB)/t/*.o    $(LOCAL_LIB)/t/uthash/*.o
	$(RM) *.out  $(LOCAL_LIB)/*.out  $(LOCAL_LIB)/t/*.out  $(LOCAL_LIB)/t/uthash/*.out
	$(RM) *.orig $(LOCAL_LIB)/*.orig $(LOCAL_LIB)/t/*.orig $(LOCAL_LIB)/t/uthash/*.orig
	$(RM) *.exe  $(LOCAL_LIB)/*.exe  $(LOCAL_LIB)/t/*.exe  $(LOCAL_LIB)/t/uthash/*.exe
	$(RM) *.tmp  $(LOCAL_LIB)/*.tmp  $(LOCAL_LIB)/t/*.tmp  $(LOCAL_LIB)/t/uthash/*.tmp
	$(RM) *.bak  $(LOCAL_LIB)/*.bak  $(LOCAL_LIB)/t/*.bak  $(LOCAL_LIB)/t/uthash/*.bak
	$(RM) *.log  $(LOCAL_LIB)/*.log  $(LOCAL_LIB)/t/*.log  $(LOCAL_LIB)/t/uthash/*.log
	$(RM) *~     $(LOCAL_LIB)/*~     $(LOCAL_LIB)/t/*~     $(LOCAL_LIB)/t/uthash/*~
	$(RM) -rf Debug Release x1 x2 x3

#------------------------------------------------------------------------------
# astyle
#------------------------------------------------------------------------------
.PHONY: astyle

astyle:
	$(ASTYLE) $(wildcard *.[ch] lib/*.[ch] ../common/*.[ch])

clean::
	$(RM) *.orig lib/*.orig ../common/*.orig

#------------------------------------------------------------------------------
# test
#------------------------------------------------------------------------------
all: t/libtestlib.a

t/libtestlib.a : $(OBJS) $(TEST_SRC_LIB:.c=.o)
	ar rcs t/libtestlib.a $(OBJS) $(TEST_SRC_LIB:.c=.o)

$(TEST_SRC_MAIN:.c=.o) : t/libtestlib.a

.o.out :
	$(CC) $(CFLAGS) $< -o $(<:.o=$(EXESUFFIX)) $(LDFLAGS) -Lt -ltestlib
	$(<:.o=$(EXESUFFIX)) 2> $@~
	diff -w $(<:.o=.bmk) $@~
	mv -f $@~ $@

clean::
	$(RM) t/libtestlib.a t/*.o t/*.out lib/t/*.o lib/t/*.out $(TEST_SRC_MAIN:.c=$(EXESUFFIX))

test: $(TARGET) z80asm_lib
	$(MAKE) dev
	$(MAKE) test_z80asm
	$(MAKE) z80asm_lib
	$(MAKE) prove_c
	$(MAKE) prove_perl
	$(MAKE) -C dev/z80asm_lib test

testlib:
	$(MAKE) -C lib test

prove_c: t/libtestlib.a $(TEST_SRC_MAIN:.c=.o) $(TEST_SRC_MAIN:.c=.out)

prove_perl: $(TARGET)
	perl -S prove t/*.t

clean::
	$(RM) zcc_opt.def zcc_proj.lst

testzcc : $(TARGET)
	zcc +zx -lndos       -create-app -omicroman.bin ../../examples/microman.c
	zcc +zx -lndos -lmzx -create-app -omandel.bin   ../../examples/graphics/mandel.c
	eightyone microman.tap
	eightyone mandel.tap

clean::
	$(RM) zcc_opt.def microman.bin microman.tap
	$(RM) zcc_opt.def mandel.bin   mandel.tap

clean::
	$(RM) $(TARGET) $(LOCAL_LIB)/$(TARGET) test* $(LOCAL_LIB)/test*
	$(RM) t/*.tmp $(LOCAL_LIB)/t/*.tmp t/dev/*.tmp

#------------------------------------------------------------------------------
# new tests
#------------------------------------------------------------------------------
Z80ASM_TESTS_SRC	= t/test.c $(wildcard t/t_*.c)
Z80ASM_TESTS_OBJ	= $(Z80ASM_TESTS_SRC:.c=.o)
DEPENDS				+= $(Z80ASM_TESTS_SRC:.c=.d)

test_z80asm: t/libtestlib.a $(Z80ASM_TESTS_OBJ) t/test.def
	$(CC) $(CFLAGS) $(Z80ASM_TESTS_OBJ) -o t/test$(EXESUFFIX) $(LDFLAGS) -Lt -ltestlib
	t/test$(EXESUFFIX)

t/test.def: t/make_tests.pl $(Z80ASM_TESTS_SRC)
	perl t/make_tests.pl

#------------------------------------------------------------------------------
# Dependencies
#------------------------------------------------------------------------------
clean::
	rm -f $(DEPENDS)

-include $(DEPENDS)
