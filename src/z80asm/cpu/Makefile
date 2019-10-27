
# EXESUFFIX is passed when cross-compiling Win32 on Linux
ifeq ($(OS),Windows_NT)
  EXESUFFIX 	:= .exe
else
  EXESUFFIX 	?=
endif

.PHONY: all test clean
all: 
test:
clean::

all: opcodes.csv
opcodes.csv: cpu.pl
	perl cpu.pl

test: run_tests.out
run_tests.out: cpu.pl z88dk-ticks$(EXESUFFIX) z80asm$(EXESUFFIX)
	perl cpu.pl run
	touch run_tests.out
clean::
	$(RM) run_tests.out 

z88dk-ticks$(EXESUFFIX): $(wildcard ../../ticks/*.c ../../ticks/*.h)
	$(MAKE) -C ../../ticks
	cp ../../ticks/z88dk-ticks$(EXESUFFIX) .
clean::
	$(RM) z88dk-ticks$(EXESUFFIX)

z80asm$(EXESUFFIX): $(wildcard ../*.c ../*.h ../dev/cpu/*.pl)
	$(MAKE) -C .. dev
	cp ../z80asm$(EXESUFFIX) .
clean::
	$(RM) z80asm$(EXESUFFIX)
