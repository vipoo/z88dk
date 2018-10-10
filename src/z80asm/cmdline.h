//-----------------------------------------------------------------------------
// z80asm restart
// main code
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

// constants
enum {
	CPU_Z80		= (1 << 0),
	CPU_Z80_ZXN	= (1 << 1),
	CPU_Z180    = (1 << 2),
	CPU_R2K		= (1 << 3),
	CPU_R3K		= (1 << 4),
	CPU_TI83	= (1 << 5),
	CPU_TI83PLUS= (1 << 6),
};

int zmain(int argc, char *argv[]);

int opt_cpu();
bool opt_swap_ix_iy();
bool opt_verbose();
bool opt_verbose_debug();
bool opt_map();
bool opt_symtable();
bool opt_list();
bool opt_globaldef();
bool opt_debug_info();
bool opt_update();
bool opt_make_bin();
bool opt_split_bin();
bool opt_relocatable();
bool opt_reloc_info();
bool opt_appmake();
int opt_filler();
const char *opt_bin_file();			// set by -o
const char *opt_consol_obj_file();	// set by -o && !-b
const char *opt_lib_file();			// set by -x
const char *opt_output_dir();		// set by -O

void opt_push_inc_path(const char *directory);
void opt_pop_inc_path();

const char *opt_search_source(const char *filename);
const char *opt_search_library(const char *filename);

// file arguments
char **opt_argv();
int opt_argc();

const char *cpu_name(int cpu_type);		// as accepted in command line, i.e. z80-zxn
const char *cpu_symbol(int cpu_type);	// as a valid symbol, i.e. z80_zxn
const char *cpu_define(int cpu_type);
int cpu_type(const char *cpu_name);		// -1 if not a valid CPU

void run_appmake(void);

const char *get_asm_filename(const char *filename);
const char *get_list_filename(const char *filename);
const char *get_obj_filename(const char *filename);
const char *get_def_filename(const char *filename);
const char *get_err_filename(const char *filename);
const char *get_bin_filename(const char *filename);
const char *get_lib_filename(const char *filename);
const char *get_sym_filename(const char *filename);
const char *get_map_filename(const char *filename);
const char *get_reloc_filename(const char *filename);

#ifdef __cplusplus
} // extern "C"
#endif
