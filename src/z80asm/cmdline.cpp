//-----------------------------------------------------------------------------
// z80asm restart
// main code
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "pch.h"
#include "../config.h"

#ifndef Z88DK_VERSION
#define Z88DK_VERSION "build " __DATE__
#endif
#define COPYRIGHT   "(c) InterLogic 1993-2009, Paulo Custodio 2011-2018"

// default file name extensions
#define FILEEXT_ASM     ".asm"
#define FILEEXT_LIST    ".lis"
#define FILEEXT_OBJ     ".o"
#define FILEEXT_DEF     ".def"
#define FILEEXT_ERR     ".err"
#define FILEEXT_BIN     ".bin"
#define FILEEXT_LIB     ".lib"
#define FILEEXT_SYM     ".sym"
#define FILEEXT_MAP     ".map"
#define FILEEXT_RELOC   ".reloc"

//-----------------------------------------------------------------------------
// global option flags
//-----------------------------------------------------------------------------
static int m_cpu = CPU_Z80;
static bool m_swap_ix_iy = false;
static bool m_verbose = false;
static bool m_verbose_debug = false;
static bool m_map = false;
static bool m_symtable = false;
static bool m_list = false;
static bool m_globaldef = false;
static bool m_debug_info = false;
static bool m_update = false;
static bool m_make_bin = false;
static bool m_split_bin = false;
static bool m_relocatable = false;
static bool m_reloc_info = false;
static int m_filler = 0;
const char* m_bin_file = NULL;
const char* m_lib_file = NULL;
const char* m_output_dir = NULL;

static vector<string> m_inc_path, m_lib_path, m_files;
static Argv m_args({});

//-----------------------------------------------------------------------------
// parse numeric arguments
//-----------------------------------------------------------------------------
static int number_arg(const char *arg)
{
	char *end;
	const char *p = arg;
	long lval;
	int radix;
	char suffix = '\0';

	if (p[0] == '$') {
		p++;
		radix = 16;
	}
	else if (p[0] == '0' && tolower(p[1]) == 'x') {
		p += 2;
		radix = 16;
	}
	else if (isdigit(p[0]) && tolower(p[strlen(p) - 1]) == 'h') {
		suffix = p[strlen(p) - 1];
		radix = 16;
	}
	else {
		radix = 10;
	}

	lval = strtol(p, &end, radix);
	if (*end != suffix || errno == ERANGE || lval < 0 || lval > INT_MAX)
		return -1;
	else
		return (int)lval;
}

static void option_origin(const char *origin_arg)
{
	int value = number_arg(origin_arg);
	if (value < 0 || value > 0xFFFF)
		err_fatal_s("invalid origin: ", origin_arg);
	else
		set_origin_option(value);
}

static void option_filler(const char *filler_arg)
{
	int value = number_arg(filler_arg);
	if (value < 0 || value > 0xFF)
		err_fatal_s("invalid filler value: ", filler_arg);
	else
		m_filler = value;
}

//-----------------------------------------------------------------------------
// search directory path
//-----------------------------------------------------------------------------
static const char *search_path(const char *filename, vector<string>& dirs)
{
	string found = search_file(filename, dirs);
	if (found.empty())
		return path_canon(filename);		// not found
	else
		return path_canon(found.c_str());	// found
}

//-----------------------------------------------------------------------------
// parse valid CPU names
//-----------------------------------------------------------------------------
const char *_cpu_name(int cpu_type, bool is_symbol)
{
	switch (cpu_type) {
	case CPU_Z80: return "z80";
	case CPU_Z80_ZXN: return is_symbol ? "z80_zxn" : "z80-zxn";
	case CPU_Z180: return "z180";
	case CPU_R2K: return "r2k";
	case CPU_R3K: return "r3k";
	case CPU_TI83: return "ti83";
	case CPU_TI83PLUS: return "ti83plus";
	default: assert(0); return NULL;
	}
}

const char *cpu_name(int cpu_type)
{
	return _cpu_name(cpu_type, false);
}

const char *cpu_symbol(int cpu_type)
{
	return _cpu_name(cpu_type, true);
}

const char *cpu_define(int cpu_type)
{
	string symbol = "__CPU_" + string(cpu_symbol(cpu_type)) + "__";
	transform(symbol.begin(), symbol.end(), symbol.begin(), ::toupper);
	return make_atom(symbol);
}

int cpu_type(const char *cpu_name)
{
	string cpu(cpu_name);
	if (cpu == "z80") return CPU_Z80;
	else if (cpu == "z80-zxn") return CPU_Z80_ZXN;
	else if (cpu == "z180") return CPU_Z180;
	else if (cpu == "r2k") return CPU_R2K;
	else if (cpu == "r3k") return CPU_R3K;
	else if (cpu == "ti83") return CPU_TI83;
	else if (cpu == "ti83plus") return CPU_TI83PLUS;
	else return -1;
}

static void define_assembly_defines()
{
	define_static_def_sym(cpu_define(opt_cpu()), 1);

	if (opt_swap_ix_iy()) {
		define_static_def_sym("__SWAP_IX_IY__", 1);
	}
}


//-----------------------------------------------------------------------------
// run appmake
//-----------------------------------------------------------------------------
#define ZX_ORIGIN		 23760		// origin for unexpanded ZX Spectrum
#define ZX_ORIGIN_MIN	 ZX_ORIGIN
#define ZX_ORIGIN_MAX	 0xFFFF
#define ZX_APP_EXT		".tap"		// ZX Spectrum TAP file

#define ZX81_ORIGIN		 16514		// origin for ZX 81
#define ZX81_ORIGIN_MIN	 ZX81_ORIGIN
#define ZX81_ORIGIN_MAX  ZX81_ORIGIN
#define ZX81_APP_EXT	".P"		// ZX81 .P file

static bool m_appmake = false;

static const char* m_appmake_opts = "";
static const char* m_appmake_ext = "";
static int m_appmake_origin_min = -1;
static int m_appmake_origin_max = -1;

bool opt_appmake()
{
	return m_appmake;
}

void run_appmake(void)
{
	stringstream cmd;

	if (m_appmake) {
		Section *first_section = get_first_section(NULL);
		int origin = first_section->origin;
		if (origin < m_appmake_origin_min || origin > m_appmake_origin_max) {
			err_fatal_n("invalid origin: ", origin);
		}
		else {
			const char *bin_filename = get_bin_filename(get_first_module(NULL)->filename);
			const char *out_filename = make_atom(replace_extension(bin_filename, m_appmake_ext).c_str());

			cmd << "appmake " << m_appmake_opts << " -b \"" << bin_filename << "\" -o \""
				<< out_filename << "\" --org " << origin;

			if (opt_verbose())
				cout << cmd.str() << endl;

			int rv = system(cmd.str().c_str());
			if (rv != 0)
				err_fatal_s("command failed: ", cmd.str().c_str());
		}
	}
}

static void option_appmake_zx(void)
{
	m_appmake = true;

	m_appmake_opts = "+zx";
	m_appmake_ext = ZX_APP_EXT;
	m_appmake_origin_min = ZX_ORIGIN_MIN;
	m_appmake_origin_max = ZX_ORIGIN_MAX;
	set_origin_option(ZX_ORIGIN);

	m_make_bin = true;
}

static void option_appmake_zx81(void)
{
	m_appmake = true;

	m_appmake_opts = "+zx81";
	m_appmake_ext = ZX81_APP_EXT;
	m_appmake_origin_min = ZX81_ORIGIN_MIN;
	m_appmake_origin_max = ZX81_ORIGIN_MAX;
	set_origin_option(ZX81_ORIGIN);

	m_make_bin = true;
}

//-----------------------------------------------------------------------------
// options interface
//-----------------------------------------------------------------------------

int opt_cpu()
{
	return m_cpu;
}

bool opt_swap_ix_iy()
{
	return m_swap_ix_iy;
}

bool opt_verbose()
{
	return m_verbose;
}

bool opt_verbose_debug()
{
	return m_verbose_debug;
}

bool opt_map()
{
	return m_map;
}

bool opt_symtable()
{
	return m_symtable;
}

bool opt_list()
{
	return m_list;
}

bool opt_globaldef()
{
	return m_globaldef;
}

bool opt_debug_info()
{
	return m_debug_info;
}

bool opt_update()
{
	return m_update;
}

bool opt_make_bin()
{
	return m_make_bin;
}

bool opt_split_bin()
{
	return m_split_bin;
}

bool opt_relocatable()
{
	return m_relocatable;
}

bool opt_reloc_info()
{
	return m_reloc_info;
}

int opt_filler()
{
	return m_filler;
}

void opt_push_inc_path(const char *directory)
{
	m_inc_path.push_back(directory);
}

void opt_pop_inc_path()
{
	if (!m_inc_path.empty())
		m_inc_path.pop_back();
}

const char *opt_search_source(const char *filename)
{
	return search_path(filename, m_inc_path);
}

const char *opt_search_library(const char *filename)
{
	return search_path(filename, m_lib_path);
}

const char *opt_bin_file()
{
	if (m_make_bin)
		return m_bin_file;
	else
		return NULL;
}

const char *opt_consol_obj_file()
{
	if (m_make_bin)
		return NULL;
	else if (!m_bin_file)
		return NULL;
	else
		return get_obj_filename(m_bin_file);
}

const char *opt_lib_file()
{
	return m_lib_file;
}

const char *opt_output_dir()
{
	return m_output_dir;
}

// only for debug
extern "C" void _debug_set_symtable_list()
{
	m_symtable = true;
	m_list = true;
}

char **opt_argv()
{
	return m_args.argv();
}

int opt_argc()
{
	return m_args.argc();
}

//-----------------------------------------------------------------------------
// parse command line files
//-----------------------------------------------------------------------------
static void add_list_file(const string& file);

// search for source file in path
// search with the given extension, with.asm extension and with.o extension
// if not found, return original file
static string search_source(const string& base_file)
{
	string found;

	if (file_exists(base_file))
		return base_file;

	found = opt_search_source(base_file.c_str());
	if (file_exists(found))
		return found;

	found = get_asm_filename(base_file.c_str());
	if (file_exists(found))
		return found;

	found = opt_search_source(found.c_str());
	if (file_exists(found))
		return found;

	found = get_obj_filename(base_file.c_str());
	if (file_exists(found))
		return found;

	found = opt_search_source(found.c_str());
	if (file_exists(found))
		return found;

	err_error_at_s("cannot find file: ", base_file.c_str());
	err_fatal_exit();

	return string();	// not reached
}

static void add_file(string file)
{
	string exp_file;
	vector<string> exp_files;

	trim(file);
	if (!file.empty()) {
		switch (file[0]) {
		case '@':		// file list
			exp_file = file.substr(1);
			trim(exp_file);
			exp_file = expand_env_vars(exp_file);
			if (has_wildcard(exp_file)) {
				exp_files = expand_file_glob(exp_file);

				if (exp_files.empty()) {
					err_error_at_s("no match: ", file.c_str());
					err_fatal_exit();
				}

				for (auto& it : exp_files)
					add_list_file(it);
			}
			else {
				add_list_file(exp_file);
			}
			break;

		default:
			exp_file = expand_env_vars(file);
			if (has_wildcard(exp_file)) {
				exp_files = expand_file_glob(exp_file);

				if (exp_files.empty()) {
					err_error_at_s("no match: ", file.c_str());
					err_fatal_exit();
				}

				for (auto& it : exp_files)
					m_files.push_back(search_source(it));
			}
			else {
				m_files.push_back(search_source(exp_file));
			}
		}
	}
}

static void add_list_file(const string& file)
{
	string found_file = opt_search_source(file.c_str());

	if (err_file_is_open(found_file.c_str())) {
		err_error_at_s("recursive include: ", file.c_str());
		err_fatal_exit();
	}

	opt_push_inc_path(get_dirname(found_file).c_str());
	{
		ifstream ifs(found_file, ios::binary);
		if (!ifs.good()) {
			err_error_at_s("cannot open file: ", file.c_str());
			err_fatal_exit();
		}

		if (m_verbose)
			cout << "Open list file: " << simplify_path(found_file) << endl;

		err_push(file.c_str(), 0);
		{
			string line;
			while (safe_getline(ifs, line).good()) {
				g_err_loc.line_nr++;
				trim(line);
				if (!line.empty()) {
					switch (line[0]) {
					case ';':		// comment
					case '#':
						break;

					default:
						add_file(line);
					}
				}
			}
		}
		err_pop();
	}
	opt_pop_inc_path();
}

//-----------------------------------------------------------------------------
// parse command line options
//-----------------------------------------------------------------------------
static void usage()
{
	cout
		<< "Z80 Module Assembler " Z88DK_VERSION << endl
		<< COPYRIGHT << endl
		<< endl
		<< "Usage:" << endl
		<< "  z80asm [OPTIONS...] {FILE | @LIST}..." << endl
		<< endl;
}

static void exit_usage()
{
	usage();
	exit(EXIT_SUCCESS);
}

static void exit_help()
{
	usage();
	cout
		<< " Help options:" << endl
		<< "  -h, -?, --help      Show help options" << endl
		<< "  -v, --verbose       Be verbose" << endl
		<< endl
		<< " Environment options:" << endl
		<< "  -I, --inc-path arg  Append to include search path" << endl
		<< "  -L, --lib-path arg  Append to library search path" << endl
		<< "  -D, --define arg    Define a symbol" << endl
		<< endl
		<< " Assemble options:" << endl
		<< "  -m, --cpu arg       z80, z180, z80-zxn (ZX Next z80 variant)," << endl
		<< "                      r2k, r3k (Rabbit 2000 / 3000)," << endl
		<< "                      ti83, ti83plus (default: z80)" << endl
		<< "      --IXIY          Swap IX and IY" << endl
		<< "  -d, --update        Assemble only updated files" << endl
		<< "  -s, --symtable      Generate module symbol table" << endl
		<< "  -l, --list          Generate module list file" << endl
		<< endl
		<< " Link options:" << endl
		<< "  -b, --make-bin      Assemble and link" << endl
		<< "      --split-bin     One binary file per section" << endl
		<< "      --filler arg    Filler byte for DEFS" << endl
		<< "  -r, --origin arg    Link at origin address" << endl
		<< "  -R, --relocatable   Generate relocation code" << endl
		<< "      --reloc-info    Generate relocation information" << endl
		<< "  -m, --map           Generate map file" << endl
		<< "  -g, --globaldef     Generate global definition file" << endl
		<< "      --debug         Debug info in map file" << endl
		<< endl
		<< " Libraries options:" << endl
		<< "  -x, --make-lib arg  Create library" << endl
		<< "  -i, --link-lib arg  Link with library" << endl
		<< endl
		<< " Output options:" << endl
		<< "  -O, --out-dir arg   Output directory" << endl
		<< "  -o, --output arg    Output file" << endl
		<< endl
		<< " Appmake options:" << endl
		<< "  +zx81               Generate .p file, origin at 16514" << endl
		<< "  +zx                 Generate .tap file, origin at 23760 or" << endl
		<< "                      above Ramtop with - rORG > 24000" << endl
		<< endl;
	exit(EXIT_SUCCESS);
}

static void opt_define(const string& arg)
{
	static regex symbol_re("[_[:alpha:]][_[:alnum:]]*");

	if (!regex_match(arg, symbol_re))
		err_fatal_s("illegal identifier: ", arg.c_str());

	define_static_def_sym(arg.c_str(), 1);
}

static bool option_arg(int& i, int argc, char *argv[],
	const string& short_opt, const string& long_opt,
	string& arg)
{
	string opt = argv[i];
	arg.clear();

	if (opt == long_opt) {
		i++;
		if (i < argc) {
			arg = expand_env_vars(argv[i]);
			return true;
		}
		else {
			err_fatal_s("option requires argument: ", opt.c_str());
			return false;	// not reached
		}
	}
	else if (opt.substr(0, short_opt.length() + 1) == short_opt + "=") {
		arg = expand_env_vars(opt.substr(short_opt.length() + 1).c_str());
		return true;
	}
	else if (opt.substr(0, long_opt.length() + 1) == long_opt + "=") {
		arg = expand_env_vars(opt.substr(long_opt.length() + 1).c_str());
		return true;
	}
	else if (opt.substr(0, short_opt.length()) == short_opt ) {
		arg = expand_env_vars(opt.substr(short_opt.length()).c_str());
		return true;
	}
	else {
		return false;
	}
}

static void init_options()
{
	m_inc_path.clear();
	m_lib_path.clear();
	m_files.clear();
}

#define DEBUG_OPT "-vv"

static bool has_vv(int argc, char *argv[])
{
	for (int i = 0; i < argc; i++)
		if (string(argv[i]) == DEBUG_OPT)
			return true;
	return false;
}

// return true if pushed files
static bool parse_options(int argc, char *argv[])
{
	if (m_verbose_debug || has_vv(argc, argv)) {
		cout << "Current directory: " << get_current_dir() << endl;
		cout << "Command line: z80asm";
		for (int i = 0; i < argc; i++)
			cout << " " << argv[i];
		cout << endl;
	}

	bool has_files = false;

	for (int i = 0; i < argc; i++) {
		string opt = argv[i];
		string arg;

		if (argv[i][0] == '-') {
			if (has_files) {
				err_fatal_s("illegal source file: ", opt.c_str());
			}
			else if (opt == "--") {
				i++;
				while (i < argc) {
					add_file(argv[i]);
					has_files = true;
					i++;
				}
			}
			else if (opt == "-?" || opt == "-h" || opt == "--help") {
				exit_help();
			}
			else if (opt == DEBUG_OPT) {
				m_verbose = true;
				m_verbose_debug = true;
			}
			else if (opt == "-v" || opt == "--verbose") {
				m_verbose = true;
			}
			else if (opt == "--map") {
				m_map = true;
			}
			else if (opt == "-s" || opt == "--symtable") {
				m_symtable = true;
			}
			else if (opt == "-l" || opt == "--list") {
				m_list = true;
			}
			else if (opt == "-g" || opt == "--globaldef") {
				m_globaldef = true;
			}
			else if (opt == "--debug") {
				m_debug_info = true;
				m_map = true;
			}
			else if (opt == "-IXIY" || opt == "-IYIX" || opt == "--IXIY" || opt == "--IYIX") {
				m_swap_ix_iy = true;
			}
			else if (opt == "-d" || opt == "--update") {
				m_update = true;
			}
			else if (opt == "-b" || opt == "--make-bin") {
				m_make_bin = true;
			}
			else if (opt == "--split-bin") {
				m_split_bin = true;
			}
			else if (opt == "-R" || opt == "--relocatable") {
				m_relocatable = true;
			}
			else if (opt == "--reloc-info") {
				m_reloc_info = true;
			}
			else if (option_arg(i, argc, argv, "-I", "--inc-path", arg)) {
				m_inc_path.push_back(arg);
			}
			else if (option_arg(i, argc, argv, "-L", "--lib-path", arg)) {
				m_lib_path.push_back(arg);
			}
			else if (option_arg(i, argc, argv, "-D", "--define", arg)) {
				opt_define(arg);
			}
			else if (option_arg(i, argc, argv, "-m", "--cpu", arg)) {
				if (arg.empty() || arg[0] == '-') {	// if next is an option -> --map
					if (!arg.empty())
						i--;
					m_map = true;
				}
				else {
					int cpu = cpu_type(arg.c_str());
					if (cpu < 0)
						err_fatal_s("invalid cpu: ", arg.c_str());
					else
						m_cpu = cpu;
				}
			}
			else if (option_arg(i, argc, argv, "--filler", "--filler", arg)) {
				option_filler(arg.c_str());
			}
			else if (option_arg(i, argc, argv, "-r", "--origin", arg)) {
				option_origin(arg.c_str());
			}
			else if (option_arg(i, argc, argv, "-o", "--output", arg)) {
				m_bin_file = make_atom(arg);
			}
			else if (option_arg(i, argc, argv, "-O", "--out-dir", arg)) {
				m_output_dir = make_atom(path_canon(arg.c_str()));
				path_mkdir(m_output_dir);
			}
			else if (option_arg(i, argc, argv, "-x", "--make-lib", arg)) {
				m_lib_file = make_atom(arg);
			}
			else if (option_arg(i, argc, argv, "-i", "--link-lib", arg)) {
				GetLibfile(arg.c_str());
			}
			else {
				err_fatal_s("illegal option: ", argv[i]);
			}
		}
		else if (argv[i][0] == '+') {
			if (has_files) {
				err_fatal_s("illegal source file: ", opt.c_str());
			}
			else if (opt == "+zx") {
				option_appmake_zx();
			}
			else if (opt == "+zx81") {
				option_appmake_zx81();
			}
			else {
				err_fatal_s("illegal option: ", argv[i]);
			}
		}
		else {
			add_file(argv[i]);
			has_files = true;
		}
	}

	return has_files;
}

// parse options in Z80ASM
static void parse_env_options()
{
	const char* opts_env = getenv("Z80ASM");
	if (opts_env) {
		auto opts_list = split(opts_env, ' ');
		for (auto& it : opts_list)
			trim(it);
		Argv args(opts_list);
		parse_options(args.argc(), args.argv());

		if (m_verbose)
			cout << "Options from Z80ASM: " << opts_env << endl;
	}
}

static void parse_cmdline(int argc, char *argv[])
{
	if (argc == 1)
		exit_usage();

	init_options();
	parse_env_options();

	bool has_files = parse_options(argc - 1, argv + 1);

	if (!has_files)
		err_fatal("source file missing");

	m_args.init(m_files);
}

//-----------------------------------------------------------------------------
// z80asm standard library
// search in current die, then in exe path, then in exe path / .. / lib,
// then in ZCCCFG / ..
// Ignore if not found, probably benign - user will see undefined symbols
// __z80asm__xxx if the library routines are called
//-----------------------------------------------------------------------------
static bool check_library(const string& lib_name)
{
	if (file_exists(lib_name))
		return true;

	if (opt_verbose())
		cout << "Library not found: " << simplify_path(lib_name) << endl;

	return false;
}

static string search_z80asm_lib()
{
	string lib_name, f;

	// Build libary file name
	lib_name = "z80asm-"
		+ string(cpu_symbol(opt_cpu())) + "-"
		+ string(opt_swap_ix_iy() ? "ixiy" : "")
		+ ".lib";

	// try to read from current directory
	if (check_library(lib_name))
		return lib_name;

	// try to read from PREFIX/lib
	f = combine_path(PREFIX, combine_path("lib", lib_name));
	if (check_library(f))
		return f;

	// try to read form -L path
	f = opt_search_library(get_lib_filename(lib_name.c_str()));
	if (f != lib_name) {		// not the same, to avoid repeating verbose output
		if (check_library(f))
			return f;
	}

	// try to read from ZCCCFG/.. */
	const char* zcccfg = getenv("ZCCCFG");
	if (zcccfg) {
		f = combine_path(zcccfg, combine_path("..", lib_name));
		if (check_library(f))
			return f;
	}

	return string();		// not found
}

static void include_z80asm_lib()
{
	string library = search_z80asm_lib();

	if (!library.empty())
		GetLibfile(library.c_str());
}

//-----------------------------------------------------------------------------
// file extension
//-----------------------------------------------------------------------------
static const char *path_prepend_output_dir(const char *filename)
{
	const char* output_dir = opt_output_dir();
	if (output_dir) {
		return make_atom(combine_path(output_dir, filename));
	}
	else {
		return make_atom(filename);
	}
}

const char *get_list_filename(const char *filename)
{
	return path_prepend_output_dir(replace_extension(filename, FILEEXT_LIST).c_str());
}

const char *get_def_filename(const char *filename)
{
	return path_prepend_output_dir(replace_extension(filename, FILEEXT_DEF).c_str());
}

const char *get_err_filename(const char *filename)
{
	return path_prepend_output_dir(replace_extension(filename, FILEEXT_ERR).c_str());
}

const char *get_bin_filename(const char *filename)
{
	return path_prepend_output_dir(replace_extension(filename, FILEEXT_BIN).c_str());
}

const char *get_lib_filename(const char *filename)
{
	return make_atom(replace_extension(filename, FILEEXT_LIB).c_str());
}

const char *get_sym_filename(const char *filename)
{
	return path_prepend_output_dir(replace_extension(filename, FILEEXT_SYM).c_str());
}

const char *get_map_filename(const char *filename)
{
	return path_prepend_output_dir(replace_extension(filename, FILEEXT_MAP).c_str());
}

const char *get_reloc_filename(const char *filename)
{
	return path_prepend_output_dir(replace_extension(filename, FILEEXT_RELOC).c_str());
}

const char *get_asm_filename(const char *filename)
{
	return make_atom(replace_extension(filename, FILEEXT_ASM).c_str());
}

const char *get_obj_filename(const char *filename)
{
	return path_prepend_output_dir(replace_extension(filename, FILEEXT_OBJ).c_str());
}

//-----------------------------------------------------------------------------
// main
//-----------------------------------------------------------------------------
int zmain(int argc, char *argv[])
{
	model_init();				// init global data
	init_libraryhdr();			// initialise to no library files
	init_macros();
	parse_cmdline(argc, argv);

	include_z80asm_lib();		// search for z80asm-*.lib, append to library path
	define_assembly_defines();	// defined options-dependent constants

	// assemble each file
	if (!g_err_count) {
		argc = opt_argc();
		argv = opt_argv();
		for (int i = 0; i < argc; i++)
			assemble_file(argv[i]);
	}

	return z80asm_main();
}
