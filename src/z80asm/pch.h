//-----------------------------------------------------------------------------
// z80asm restart
// precompiled headers
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#include "cmdline.h"
#include "errors.h"
#include "utils.h"
#include "z80asm.h"
#include "stdhead.h"

#ifndef NUM_ELEMS
#define NUM_ELEMS(a)	((int)(sizeof(a) / sizeof((a)[0])))
#endif

// old headers
extern "C" {
#include "codearea.h"
#include "fileutil.h"
#include "macros.h"
#include "model.h"
#include "modlink.h"
#include "module.h"
#include "symtab.h"
#include "z80asm.h"
}
