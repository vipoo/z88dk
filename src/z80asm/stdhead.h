//-----------------------------------------------------------------------------
// z80asm restart
// standard headers
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#include <exception>
#include <stdexcept>
using std::exception;
using std::runtime_error;

#include <iostream>
#include <fstream>
#include <sstream>
#include <streambuf>
using std::cout;
using std::cerr;
using std::endl;
using std::ifstream;
using std::istream;
using std::ios;
using std::ofstream;
using std::ostream;
using std::streambuf;
using std::stringstream;
using std::istringstream;

#include <string>
using std::string;
using std::to_string;
using std::getline;

#include <memory>
using std::make_shared;
using std::shared_ptr;

#include <vector>
using std::vector;

#include <list>
using std::list;

#include <unordered_map>
using std::unordered_map;

#include <unordered_set>
using std::unordered_set;

#include <algorithm>
using std::find_if;
using std::sort;
using std::transform;
using std::unique;

#include <utility>
using std::make_pair;

#include <regex>
using std::regex;
using std::smatch;
using std::regex_search;
using std::regex_match;

#include <iterator>
using std::distance;

#include <cassert>
#include <cerrno>
#include <cctype>
#include <climits>
#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include <sys/stat.h>
