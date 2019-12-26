#------------------------------------------------------------------------------
# Z88DK Z80 Module Assembler
#
# Build and test z80asm-*.lib
#
# Copyright (C) Gunther Strube, InterLogic 1993-99
# Copyright (C) Paulo Custodio, 2011-2019
# License: http://www.perlfoundation.org/artistic_license_2_0
#------------------------------------------------------------------------------
PROJ		:= z80asm

INSTALL 	?= install
Z80ASM_EXE	?= ../../$(PROJ)
CPUS		:= 8080 8085 gbz80 r2k r3k z180 z80 z80n
OPS		:= rlc rrc rl rr sla sra srl
RRS		:= bc de hl
OUT		:= out
SRC		:= \
	$(foreach op, $(OPS), $(foreach rr, $(RRS), $(OUT)/$(op)_$(rr).asm)) \
	$(filter-out test.asm,$(wildcard *.asm))

#------------------------------------------------------------------------------
# Macro for each library build
#------------------------------------------------------------------------------
define MAKE_LIB
all: $(PROJ)-$(strip $(1)).lib

$(PROJ)-$(strip $(1)).lib: $(PROJ)_lib.lst $(SRC) Makefile ../../zobjfile.h
	$(Z80ASM_EXE) -l -x$(PROJ)-$(strip $(1)).lib $(2) @$(PROJ)_lib.lst

clean::
	$(RM) $(PROJ)-$(strip $(1)).lib

install::
	$(INSTALL) $(PROJ)-$(strip $(1)).lib $(PREFIX)/lib/$(PROJ)-$(strip $(1)).lib
endef

define MAKE_ASM
$(OUT)/$(1)_$(2).asm: $(1)_RR.asm.m4 Makefile
	@mkdir -p $(OUT)
	m4 -D_RR=$(2) $(1)_RR.asm.m4 > $(OUT)/$(1)_$(2).asm
	perl ../../asmstyle.pl $(OUT)/$(1)_$(2).asm

clean::
	$(RM) $(OUT)/$(1)_$(2).o $(OUT)/$(1)_$(2).lis $(OUT)/$(1)_$(2).asm.bak
endef

#------------------------------------------------------------------------------
# Call for all variants
#------------------------------------------------------------------------------
$(foreach cpu,$(CPUS),$(eval $(call MAKE_LIB,$(cpu)-,-m$(cpu))))
$(foreach cpu,$(CPUS),$(eval $(call MAKE_LIB,$(cpu)-ixiy,-m$(cpu) --IXIY)))
$(foreach op,$(OPS),$(foreach rr,$(RRS),$(eval $(call MAKE_ASM,$(op),$(rr)))))

$(PROJ)_lib.lst: $(SRC) $(wildcard *.asm.m4) 
	$(RM) $(PROJ)_lib.lst
	$(foreach file, $(sort $(SRC)), echo $(file) >> $(PROJ)_lib.lst; )

clean::
	$(RM) $(SRC:.asm=.o) $(SRC:.asm=.lis) test.asm test.o test.bin *.bak

test: all
	perl -S prove t/*.t
