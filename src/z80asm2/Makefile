#------------------------------------------------------------------------------
# Z88DK Z80 Module Assembler
# Copyright (C) Paulo Custodio, 2011-2018
# License: http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk
#------------------------------------------------------------------------------
PROJ		:= z80asm2

include ../Make.common

CXX		?= g++
CXXFLAGS	+= -g -Wall -Wextra -std=gnu++11 -MMD
INSTALL 	?= install
CROSS		?= 0

#------------------------------------------------------------------------------
# Object files
#------------------------------------------------------------------------------
SRCS		:= $(wildcard *.cpp)
OBJS_ALL	:= $(SRCS:.cpp=.o)
OBJS		:= $(OBJS_ALL:z80asm.o=)

T_SRCS 		:= $(wildcard t/*.cpp)
T_OBJS		:= $(T_SRCS:.cpp=.o)

DEPENDS		+= $(SRCS:.cpp=.d) $(T_SRCS:.cpp=.d)


#------------------------------------------------------------------------------
.PHONY: all clean test valgrind astyle

#------------------------------------------------------------------------------
# main
#------------------------------------------------------------------------------
all: $(PROJ)$(EXE)

$(OBJS_ALL): ../config.h

../config.h:
	@echo Create $@
	@echo \#define PREFIX \"/usr/local/share/z88dk\" 		 > $@
	@echo \#define UNIX 1						>> $@
	@echo \#define EXEC_PREFIX \"\"					>> $@
	@echo \#define Z88DK_VERSION \"build-$(shell date +%Y%m%d)\"	>> $@

$(eval $(call MAKE_CXX_EXE,$(PROJ),$(OBJS_ALL),0))

#------------------------------------------------------------------------------
# re2c
#------------------------------------------------------------------------------
RE2C		:= re2c
RE2C_ROOT	:= ../../ext/re2c/re2c
RE2C_FLAGS	:= -i --no-generation-date -W -T
CXXFLAGS	+= -I$(RE2C_ROOT)

RE2C_SRCS	:= \
$(wildcard $(RE2C_ROOT)/bootstrap/src/ast/*.cc) \
$(wildcard $(RE2C_ROOT)/bootstrap/src/conf/*.cc) \
$(wildcard $(RE2C_ROOT)/src/*.cc) \
$(wildcard $(RE2C_ROOT)/src/adfa/*.cc) \
$(wildcard $(RE2C_ROOT)/src/ast/*.cc) \
$(wildcard $(RE2C_ROOT)/src/code/*.cc) \
$(wildcard $(RE2C_ROOT)/src/conf/*.cc) \
$(wildcard $(RE2C_ROOT)/src/dfa/*.cc) \
$(wildcard $(RE2C_ROOT)/src/dfa/cfg/*.cc) \
$(wildcard $(RE2C_ROOT)/src/nfa/*.cc) \
$(wildcard $(RE2C_ROOT)/src/re/*.cc) \
$(wildcard $(RE2C_ROOT)/src/re/encoding/*.cc) \
$(wildcard $(RE2C_ROOT)/src/re/encoding/utf16/*.cc) \
$(wildcard $(RE2C_ROOT)/src/re/encoding/utf8/*.cc) \
$(wildcard $(RE2C_ROOT)/src/skeleton/*.cc) \
$(wildcard $(RE2C_ROOT)/src/util/*.cc)
RE2C_OBJS	:= $(RE2C_SRCS:.cc=.o)

DEPENDS		+= $(RE2C_SRCS:.cc=.d)

#------------------------------------------------------------------------------
all: $(RE2C)$(EXE)

$(RE2C_OBJS): $(RE2C_ROOT)/config.h

$(RE2C_ROOT)/config.h:
	@echo Create $@
	@echo '#define HAVE_STDINT_H 1'          > $@
	@echo '#define PACKAGE_VERSION "1.0.3"' >> $@

#------------------------------------------------------------------------------
define MAKE_RE2C
$(PROJ)$(EXE): $(1).o

$(1).cpp: $(1).re $(RE2C)$(EXE)
	./$(RE2C)$(EXE) $(RE2C_FLAGS) -o $(1).cpp1 $(1).re
	sed -e "s/\r//" < $(1).cpp1 > $(1).cpp
	$(RM) $(1).cpp1
endef

$(eval $(call MAKE_RE2C,preproc_re))

$(eval $(call MAKE_CXX_EXE,$(RE2C),$(RE2C_OBJS),0))

#------------------------------------------------------------------------------
# astyle
#------------------------------------------------------------------------------
# install
#------------------------------------------------------------------------------
install:
	$(INSTALL) $(PROJ)$(EXE)	$(PREFIX)/bin/$(EXEC_PREFIX)$(PROJ)$(EXE)

#------------------------------------------------------------------------------
test:: $(PROJ)$(EXE)
	perl -S prove t/*.t

t/test.o: t/test.def

t/test.def: t/*.cpp Makefile t/make_tests.pl
	perl t/make_tests.pl

$(eval $(call MAKE_CXX_EXE,t/test,$(T_OBJS) $(OBJS),1))

#------------------------------------------------------------------------------
astyle:
	$(ASTYLE) $(wildcard *.cpp *.h t/*.cpp t/*.h)

#------------------------------------------------------------------------------
clean::
	$(RM) $(OBJS) $(DEPENDS)
	$(RM) *.core *.o *.d *.out *.orig *.exe *.tmp *.bak *.log *~ 
	$(RM) t/*.core t/*.o t/*.d t/*.out t/*.orig t/*.exe t/*.tmp t/*.bak t/*.log t/*~ 

#------------------------------------------------------------------------------
# depedencies
#------------------------------------------------------------------------------
-include $(DEPENDS)
