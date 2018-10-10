//-----------------------------------------------------------------------------
// z80asm restart
// errors
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
	struct Location {
		const char*	file;
		int			line_nr;
	};
#else
	typedef struct Location {
		const char*	file;
		int			line_nr;
	} Location;
#endif

// global error count and location
extern int g_err_count;
extern Location g_err_loc;

// push new location, pop old
void err_push(const char* err_file, int line_nr);
void err_pop();
bool err_file_is_open(const char* err_file);	// check stack

// exit with EXIT_FAILURE for fatal errors
void err_fatal_exit();

void err_fatal(const char* msg);
void err_fatal_s(const char* msg, const char *s1);
void err_fatal_n(const char* msg, int n1);

// show error message and increment g_err_count
void err_error(const char* msg);
void err_error_s(const char* msg, const char *s1);
void err_error_n(const char* msg, int n1);

void err_error_at(const char* msg);
void err_error_at_s(const char* msg, const char *s1);
void err_error_at_n(const char* msg, int n1);

// show warning message
void err_warn_at(const char* msg);
void err_warn_at_s(const char* msg, const char *s1);
void err_warn_at_n(const char* msg, int n1);



#ifdef __cplusplus
} // extern "C"
#endif
