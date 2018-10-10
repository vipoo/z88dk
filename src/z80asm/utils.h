//-----------------------------------------------------------------------------
// z80asm restart
// utilities
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once
#include "stdhead.h"

// string pool
using Atom = const char *;
Atom make_atom(const string& value);

// spew and slurp binary files; thow exception on error
string slurp(const string& filename);
void spew(const string& filename, const string& text);

// make a directory recursively
void make_path(const string& dirname);

// remove a file
void remove_file(const string& filename);

// remove a directory, if empty
void remove_dir(const string& dirname);

// case insensitive string compare
bool iequals(const string& a, const string& b);

// split a string by delimiter, join vector by delimiter
vector<string> split(const string& s, char delimiter);
string join(const vector<string>& v, char delimiter);

// replace all references to ${env} env vars
void auto_expand_env_vars(string& text);
string expand_env_vars(const string& input);

// remove double-slashes and replace all slashes by forward slashes
string simplify_path(string path);

// change to backslashes in windows, forward slashes otherwise
string canonize_path(string path);

// basename and dirname as in Linux
string get_dirname(string path);
string get_basename(string path);

string get_current_dir();

// extension
string get_extension(const string& path);
string replace_extension(const string& path,
	const string& new_ext);

// combine directory and file name
string combine_path(string dir, string filename);

// search file in directory path, return empty string if not found
string search_file(const string& filename, const vector<string>& dirs);

// shell-like wild card match (*, ?)
bool wildcard_match(const string& wildcard, const string& text);

// expand list of files that match wild cards (**, *, ?) - ** for recursive directory search
bool has_wildcard(const string& file);
vector<string> expand_file_glob(string wildcard);

// read line from input file with any EOL terminator
istream& safe_getline(istream& is, string& t);

// check if file exists
bool file_exists(const string& filename);

// check if directory exists
bool dir_exists(const string& dirname);

// return true if in windows and path is "X:", where X is any letter
bool is_volume(const string& path);

// trim blanks from both ends in-place
void trim(string& text);

// chomp eol from the end in-place
void chomp(string& text);

// convert a vector or strings to argc/argv
class Argv
{
public:
	Argv(const vector<string>& args);
	virtual ~Argv();

	void init(const vector<string>& args);
	void clear();

	char** argv();
	int argc();

private:
	void clear_();

	int m_size{ 0 };
	char** m_args{ nullptr };
};
