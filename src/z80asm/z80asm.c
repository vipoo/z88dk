/*
Z88DK Z80 Macro Assembler

Copyright (C) Gunther Strube, InterLogic 1993-99
Copyright (C) Paulo Custodio, 2011-2017
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/pauloscustodio/z88dk-z80asm
*/

#include "directives.h"
#include "fileutil.h"
#include "libfile.h"
#include "listfile.h"
#include "macros.h"
#include "modlink.h"
#include "module.h"
#include "zobjfile.h"
#include "parse.h"
#include "types.h"
#include "strutil.h"
#include "symbol.h"
#include "die.h"
#include "model.h"

#include "cmdline.h"
#include "errors.h"

#include <sys/stat.h>

/* external functions */
void Z80pass2( void );
void CreateBinFile( void );


/* local functions */
void ReleaseLibraries( void );
struct libfile *NewLibrary( void );

extern char Z80objhdr[];

byte_t reloc_routine[] =
    "\x08\xD9\xFD\xE5\xE1\x01\x49\x00\x09\x5E\x23\x56\xD5\x23\x4E\x23"
    "\x46\x23\xE5\x09\x44\x4D\xE3\x7E\x23\xB7\x20\x06\x5E\x23\x56\x23"
    "\x18\x03\x16\x00\x5F\xE3\x19\x5E\x23\x56\xEB\x09\xEB\x72\x2B\x73"
    "\xD1\xE3\x2B\x7C\xB5\xE3\xD5\x20\xDD\xF1\xF1\xFD\x36\x00\xC3\xFD"
    "\x71\x01\xFD\x70\x02\xD9\x08\xFD\xE9";

size_t sizeof_relocroutine = 73;
size_t sizeof_reloctable   = 0;

char *reloctable = NULL, *relocptr = NULL;

struct liblist *libraryhdr;

/* local functions */
static void query_assemble(const char *src_filename );
static void do_assemble(const char *src_filename );

/*-----------------------------------------------------------------------------
*   Assemble one source file
*	- if a .o file is given, and it exists, it is used without trying to assemble first
*	- if the given file exists, whatever the extension, try to assembly it
*	- if all above fail, try to replace/append the .asm extension and assemble
*	- if all above fail, try to replace/append the .o extension and link
*----------------------------------------------------------------------------*/
void assemble_file( const char *filename )
{
	// must canonize input file name so that comparison to .o below works
	filename = path_canon(filename);

	const char *src_filename;
	const char *obj_filename;
	bool load_obj_only;
	Module *module;

	/* create output directory*/
	obj_filename = path_canon(get_obj_filename(filename));
	path_mkdir(path_dir(obj_filename));

	/* try to load object file */
	if (strcmp(filename, obj_filename) == 0 &&			/* input is object file */
		c_file_exists(filename)							/* .o file exists */
		) {
		load_obj_only = true;
		src_filename = filename;
	}
	else {
		load_obj_only = false;

		/* use input file if it exists */
		if (c_file_exists(filename)) {
			src_filename = filename;						/* use whatever extension was given */
		}
		else {
			const char *asm_filename = get_asm_filename(filename);
			if (c_file_exists(asm_filename)) {				/* file with .asm extension exists */
				src_filename = asm_filename;
			}
			else if (c_file_exists(obj_filename)) {
				load_obj_only = true;
				src_filename = obj_filename;
			}
			else {				
				error_read_file(filename);
				return;
			}
		}
	}
	
	/* append the directoy of the file being assembled to the include path 
	   and remove it at function end */
	opt_push_inc_path(path_dir(src_filename));

    /* normal case - assemble a asm source file */
    cur_list = opt_list();		/* initial LSTON status */

	/* when building libraries need to reset codearea to allow total library size > 64K
	   when building binary cannot reset codearea so that each module is linked
	   after the previous one, allocating addresses */
	if (!(opt_make_bin() || opt_bin_file() || opt_consol_obj_file()))
		reset_codearea();

    /* Create module data structures for new file */
	module = set_cur_module( new_module() );
	module->filename = spool_add( src_filename );

	/* Create error file */
	remove(get_err_filename(src_filename));
	open_error_file(src_filename);

	if (load_obj_only) {
		if (check_object_file(obj_filename)) {
			if (!objmodule_loaded(obj_filename))
				error_not_obj_file(src_filename);	/* invalid object file */
		}
	}
	else
		query_assemble(src_filename);			/* try to assemble, check -d */

    set_error_null();							/* no more module in error messages */
	cur_list = false;

	/* finished assembly, remove dirname from include path */
	opt_pop_inc_path();
}

/*-----------------------------------------------------------------------------
*	Assemble file or load object module size if datestamp option was given
*	and object file is up-to-date
*----------------------------------------------------------------------------*/
static void query_assemble(const char *src_filename )
{
    struct stat src_stat, obj_stat;
    int src_stat_result, obj_stat_result;
	const char *obj_filename = get_obj_filename( src_filename );

    /* get time stamp of files, error if source not found */
    src_stat_result = stat( src_filename, &src_stat );		/* BUG_0033 */
    obj_stat_result = stat( obj_filename, &obj_stat );

    if ( opt_update() &&									/* -d option */
            obj_stat_result >= 0 &&							/* object file exists */
            ( src_stat_result >= 0 ?						/* if source file exists, ... */
              src_stat.st_mtime <= obj_stat.st_mtime		/* ... source older than object */
              : true										/* ... else source does not exist, but object exists
															   --> consider up-to-date (e.g. test.c -> test.o) */
            ) &&
            objmodule_loaded(obj_filename)					/* object file valid and size loaded */
       )
    {
        /* OK - object file is up-to-date */
    }
    else
    {
        /* Assemble source file */
        do_assemble( src_filename );
    }
}

/*-----------------------------------------------------------------------------
*	Assemble one file
*----------------------------------------------------------------------------*/
static void do_assemble(const char *src_filename )
{
    int start_errors = g_err_count;     /* count errors in this source file */
	const char *obj_filename = get_obj_filename(src_filename);

	clear_macros();

	/* create list file */
	if (opt_list())
		list_open(get_list_filename(src_filename));

	/* initialize local symtab with copy of static one (-D defines) */
	copy_static_syms();

	/* Init ASMPC */
	set_PC(0);

	if (opt_verbose())
		printf("Assembling '%s' to '%s'\n", path_canon(src_filename), path_canon(obj_filename));

	parse_file(src_filename);

	list_end();						/* get_used_symbol will only generate page references until list_end() */

	asm_MODULE_default();			/* Module name must be defined */

	set_error_null();
	//set_error_module( CURRENTMODULE->modname );

	Z80pass2();						/* call pass 2 even if errors found, to issue pass2 errors */
	
	/*
	* Source file no longer needed (file could already have been closed, if error occurred during INCLUDE
	* processing).
	*/

	set_error_null();

	/* remove list file if more errors now than before */
	list_close(start_errors == g_err_count);

	/* remove incomplete object file */
	if (start_errors != g_err_count)
		remove(get_obj_filename(src_filename));

	close_error_file();

	remove_all_local_syms();
	remove_all_global_syms();
	ExprList_remove_all(CURRENTMODULE->exprs);

	if (opt_verbose())
		putchar('\n');    /* separate module texts */
}


void init_libraryhdr()
{
	libraryhdr = NULL;
	atexit(ReleaseLibraries);
}

/* search library file name, return found name in strpool */
const char *GetLibfile( const char *filename )
{
    struct libfile *newlib;
	const char     *found_libfilename;
    int len;

    newlib = NewLibrary();

    len = strlen( filename );

    if ( len == 0 )
	{
		error_not_lib_file(filename);
		return NULL;
	}
	
	found_libfilename = opt_search_library( get_lib_filename( filename ) );

    newlib->libfilename = m_strdup( found_libfilename );		/* freed when newlib is freed */

	if (!check_library_file(found_libfilename))					/* not a library or wrong version */
		return NULL;

	if (opt_verbose())
		printf("Reading library '%s'\n", path_canon(found_libfilename));

	return found_libfilename;
}


/* CH_0004 : always returns non-NULL, ERR_NO_MEMORY is signalled by exception */
struct libfile *
NewLibrary( void )
{
    struct libfile *newl;

    if ( libraryhdr == NULL )
    {
        libraryhdr = m_new( struct liblist );
        libraryhdr->firstlib = NULL;
        libraryhdr->currlib = NULL;     /* Library header initialised */
    }

    newl = m_new( struct libfile );
    newl->nextlib = NULL;
    newl->libfilename = NULL;
    newl->nextobjfile = -1;

    if ( libraryhdr->firstlib == NULL )
    {
        libraryhdr->firstlib = newl;
        libraryhdr->currlib = newl;     /* First library in list */
    }
    else
    {
        libraryhdr->currlib->nextlib = newl;    /* current/last library points now at new current */
        libraryhdr->currlib = newl;     /* pointer to current module updated */
    }

    return newl;
}



void
ReleaseLibraries( void )
{
    struct libfile *curptr, *tmpptr;

	if (!libraryhdr)
		return;

    curptr = libraryhdr->firstlib;

    while ( curptr != NULL )    /* while there are libraries */
    {
        if ( curptr->libfilename != NULL )
        {
            m_free( curptr->libfilename );
        }

        tmpptr = curptr;
        curptr = curptr->nextlib;
        m_free( tmpptr );       /* release library */
    }

    m_free( libraryhdr );       /* Release library header */
}


/***************************************************************************************************
 * Main entry of Z80asm
 ***************************************************************************************************/
int z80asm_main()
{
#if 0
	/* parse command line and call-back via assemble_file() */
	/* If filename starts with '@', reads the file as a list of filenames
	*	and assembles each one in turn */
	if (!g_err_count) {
		for (char **pfile = argv_front(argv_files); *pfile; pfile++)
			assemble_file(*pfile);
	}
#endif

	/* Create output file */
	if (!g_err_count) {
		if (opt_lib_file()) {
			make_library(opt_lib_file(), opt_argc(), opt_argv());
		}
		else if (opt_make_bin()) {
			link_modules();			

			if (!g_err_count)
				CreateBinFile();

			if (!g_err_count && opt_appmake())
				run_appmake();		/* call appmake if requested in the options */
		}
		else if (opt_consol_obj_file()) {	// -o consolidated obj
			link_modules();

			set_cur_module(get_first_module(NULL));
			
			CURRENTMODULE->filename = get_asm_filename(opt_consol_obj_file());
			CURRENTMODULE->modname = path_remove_ext(path_file(CURRENTMODULE->filename));

			if (!g_err_count)
				write_obj_file(opt_consol_obj_file());

			if (!g_err_count && opt_symtable())
				write_sym_file(CURRENTMODULE);
		}
	}

	set_error_null();
	close_error_file();

	delete_modules();		/* Release module information (symbols, etc.) */

	if (libraryhdr != NULL)
		ReleaseLibraries();    /* Release library information */

	if (opt_relocatable())
	{
		if (reloctable != NULL)
			m_free(reloctable);
	}

	free_macros();

    if ( g_err_count )
    {
        return 1;	/* signal error */
    }
    else
    {
        return 0;    /* assembler successfully ended */
    }
}
