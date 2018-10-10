//-----------------------------------------------------------------------------
// z80asm restart
// errors
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "pch.h"

// global data
int g_err_count = 0;
Location g_err_loc;

class ErrorsInit {
public:
	ErrorsInit() {
		g_err_loc = Location{ make_atom(""), 0 };
	}
};

static ErrorsInit init;		// initialize module

// local data
static vector<Location>	locations;

void err_init()
{
}

void err_push(const char* err_file, int line_nr)
{
	locations.push_back(g_err_loc);
	g_err_loc = Location{ make_atom(err_file), line_nr };
}

void err_pop()
{
	if (locations.empty())
		g_err_loc = Location{ make_atom(""), 0 };
	else {
		g_err_loc = locations.back();
		locations.pop_back();
	}
}

bool err_file_is_open(const char* err_file)
{
	for (auto& it : locations)
		if (string(it.file) == string(err_file))
			return true;
	return false;
}


#define FatalError(cerr_args) \
	cerr << "Error: " << cerr_args << endl; \
	err_fatal_exit()

void err_fatal_exit()
{
	exit(EXIT_FAILURE);
}

void err_fatal(const char* msg)
{
	FatalError(msg);
}

void err_fatal_s(const char* msg, const char *s1)
{
	FatalError(msg << s1);
}

void err_fatal_n(const char* msg, int n1)
{
	FatalError(msg << n1);
}

#undef FatalError


#define Error(cerr_args) \
	cerr << "Error: " << cerr_args << endl; \
	g_err_count++

#define ErrorAt(cerr_args) \
	if (*(g_err_loc.file) != '\0' && g_err_loc.line_nr != 0) { \
		Error(g_err_loc.file << ":" << g_err_loc.line_nr << ": " << cerr_args); \
	} else { \
		Error(cerr_args); \
	}

#define Warn(cerr_args) \
	cerr << "Warning: " << cerr_args << endl

#define WarnAt(cerr_args) \
	Warn(g_err_loc.file << ":" << g_err_loc.line_nr << ": " << cerr_args)


void err_error(const char* msg)
{
	Error(msg);
}

void err_error_s(const char* msg, const char *s1)
{
	Error(msg << s1);
}

void err_error_n(const char* msg, int n1)
{
	Error(msg << n1);
}


void err_error_at(const char* msg)
{
	ErrorAt(msg);
}

void err_error_at_s(const char* msg, const char *s1)
{
	ErrorAt(msg << s1);
}

void err_error_at_n(const char* msg, int n1)
{
	ErrorAt(msg << n1);
}


void err_warn_at(const char* msg)
{
	WarnAt(msg);
}

void err_warn_at_s(const char* msg, const char *s1)
{
	WarnAt(msg << s1);
}

void err_warn_at_n(const char* msg, int n1)
{
	WarnAt(msg << n1);
}

#undef Error
#undef ErrorAt
#undef Warn
#undef WarnAt
