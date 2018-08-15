//-----------------------------------------------------------------------------
// z80asm assembler
// utilities
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once
#include <iostream>
#include <string>
#include <vector>

// string pool
using Atom = const char *;
Atom make_atom(const std::string& value);

// spew and slurp binary files; thow exception on error
std::string slurp(const std::string& filename);
void spew(const std::string& filename, const std::string& text);

// make a directory recursively
void make_path(const std::string& dirname);

// remove a file
void remove_file(const std::string& filename);

// remove a directory, if empty
void remove_dir(const std::string& dirname);

// case insensitive std::string compare
bool iequals(const std::string& a, const std::string& b);

// remove double-slashes and replace all slashes by forward slashes
std::string simplify_path(std::string path);

// change to backslashes in windows, forward slashes otherwise
std::string canonize_path(std::string path);

// basename and dirname as in Linux
std::string get_dirname(std::string path);
std::string get_basename(std::string path);

// extension
std::string get_extension(const std::string& path);
std::string replace_extension(const std::string& path,
                              const std::string& new_ext);

// combine directory and file name
std::string combine_path(std::string dir, std::string filename);

// search file in directory path, return empty std::string if not found
std::string search_file(const std::string& filename,
                        const std::vector<std::string>& dirs);

// read line from input file with any EOL terminator
std::istream& safe_getline(std::istream& is, std::string& t);

// check if file exists
bool file_exists(const std::string& filename);

// check if directory exists
bool dir_exists(const std::string& dirname);

// trim blanks from both ends in-place
void trim(std::string& text);

// chomp eol from the end in-place
void chomp(std::string& text);

// replace word by text, respect word boundaries, i.e. "hell" is not found in "hello"
void replace_words(std::string& text, const std::string& old_word,
                   const std::string& new_word);
