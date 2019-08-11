/*
Z88DK Z80 Macro Assembler

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk

Error handling.
*/

#define _ ,

// #define X(type,func,params,fmt_args) ...

X(ErrError, error_read_file, const char *filename, 
	"cannot read '%s'" _ filename)
X(ErrError, error_write_file, const char *filename, 
	"cannot write '%s'" _ filename)
X(ErrError, error_include_recursion, const char *filename, 
	"cannot include '%s' recursively" _ filename)
X(ErrError, error_no_src_file, , 
	"source file missing")
X(ErrError, error_illegal_option, const char *option, 
	"illegal option: %s" _ option)
X(ErrError, error_glob, const char *filename _ const char *error_msg, 
	"problem with '%s': %s" _ filename _ error_msg)
X(ErrError, error_glob_no_files, const char *filename, 
	"pattern '%s' returned no files" _ filename)
X(ErrError, error_not_regular_file, const char *filename, 
	"'%s' is not a regular file" _ filename)
X(ErrWarn, warn_symbol_different, const char *name _ const char *used, 
	"symbol '%s' used as '%s'" _ name _ used)
X(ErrWarn, warn_expr_in_parens, ,
	"interpreting indirect value as immediate")
X(ErrError, error_redefined_macro, const char *name, 
	"macro '%s' redefined" _ name)
X(ErrError, error_macro_defcont_without_define, , 
	"#defcont without #define")
X(ErrError, error_macro_recursion, const char *name, 
	"recursion expanding macro '%s'" _ name)
X(ErrError, error_missing_close_paren, ,
	"missing close parenthesis")
X(ErrError, error_missing_close_angle_bracket, , 
	"missing close angle bracket")
X(ErrError, error_missing_macro_arguments, , 
	"missing macro arguments")
X(ErrError, error_extra_macro_arguments, , 
	"extra macro arguments")
X(ErrError, error_syntax, ,
	"syntax error")
X(ErrError, error_syntax_expr, , 
	"syntax error in expression")
X(ErrError, error_invalid_squoted_string, ,
	"invalid single quoted character")
X(ErrError, error_unclosed_string, , 
	"unclosed quoted string")
X(ErrError, error_divide_by_zero, ,
	"division by zero")
X(ErrError, error_missing_block, , 
	"missing {} block")
X(ErrError, error_missing_close_block, , 
	"{} block not closed")
X(ErrError, error_unbalanced_struct_at, const char *filename _ int line_nr, 
	"unbalanced control structure started at '%s' line %d" _ filename _ line_nr)
X(ErrError, error_unbalanced_struct, , 
	"unbalanced control structure")
X(ErrError, error_not_defined, const char *name, 
	"symbol '%s' not defined" _ name)
X(ErrError, error_illegal_ident, ,
	"illegal identifier")
X(ErrError, error_jr_not_local, ,
	"relative jump address must be local")
X(ErrError, error_expected_const_expr, ,
	"expected constant expression")
X(ErrError, error_symbol_redefined, const char *name, 
	"symbol '%s' already defined" _ name)
X(ErrError, error_symbol_redefined_module, const char *name _ const char *module, 
	"symbol '%s' already defined in module '%s'" _ name _ module)
X(ErrError, error_symbol_decl_local, const char *name, 
	"symbol '%s' already declared local" _ name)
X(ErrError, error_symbol_redecl, const char *name, 
	"re-declaration of '%s' not allowed" _ name)
X(ErrError, error_expression_recursion, const char *name, 
	"expression for '%s' depends on itself" _ name)
X(ErrError, error_max_codesize, long size, 
	"max. code size of %ld bytes reached" _ size)
X(ErrError, error_org_redefined, , 
	"ORG redefined")
X(ErrError, error_align_redefined, , 
	"ALIGN redefined")
X(ErrError, error_org_not_aligned, int org _ int align, 
	"ORG '0x%04X' not ALIGNed '%d'" _ org _ align)
X(ErrError, error_invalid_org_option, const char *org_hex, 
	"invalid --origin option '%s'" _ org_hex)
X(ErrError, error_invalid_org, int origin, 
	"invalid origin: %d" _ origin)
X(ErrError, error_invalid_filler_option, const char *filler_hex, 
	"invalid filler value: %s" _ filler_hex)
X(ErrWarn, warn_org_ignored, const char *filename _ const char *section_name, 
	"ORG ignored at '%s', section '%s'" _ filename _ section_name)
X(ErrError, error_not_obj_file, const char *filename, 
	"'%s' not an object file" _ filename)
X(ErrError, error_obj_file_version, const char *filename _ int found_version _ int expected_version, 
	"object '%s' version %d, expected version %d" _ filename _ found_version _ expected_version)
X(ErrError, error_not_lib_file, const char *filename, 
	"'%s' not a library file" _ filename)
X(ErrError, error_lib_file_version, const char *filename _ int found_version _ int expected_version, 
	"library '%s' version %d, expected version %d" _ filename _ found_version _ expected_version)
X(ErrWarn, warn_int_range, long value, 
	"integer '%ld' out of range" _ value)
X(ErrError, error_int_range, long value, 
	"integer '%ld' out of range" _ value)
X(ErrError, error_base_register_illegal, long value, 
	"base register byte '%ld' is illegal" _ value)
X(ErrError, error_missing_arguments, , 
	"DMA missing register group member(s)")
X(ErrError, error_extra_arguments, , 
	"DMA too many arguments")
X(ErrError, error_port_A_timing, , 
	"port A timing is illegal")
X(ErrError, error_dma_unsupported_interrupts, , 
	"DMA does not support interrupts")
X(ErrError, error_dma_illegal_mode, , 
	"DMA mode is illegal")
X(ErrError, error_dma_illegal_command, , 
	"illegal DMA command")
X(ErrError, error_dma_illegal_read_mask, , 
	"DMA read mask is illegal")
X(ErrError, error_port_B_timing, , 
	"port B timing is illegal")
X(ErrWarn, warn_dma_unsupported_features, , 
	"DMA does not support some features")
X(ErrWarn, warn_dma_unsupported_command, ,
	"DMA does not implement this command")
X(ErrWarn, warn_dma_half_cycle_timing, , 
	"DMA does not support half cycle timing")
X(ErrWarn, warn_dma_ready_signal_unsupported, , 
	"DMA does not support ready signals")
X(ErrError, error_cmd_failed, const char *cmd,
	"command '%s' failed" _ cmd)

#undef X
#undef _
