//-----------------------------------------------------------------------------
// z80asm restart
// utilities
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "pch.h"
#ifdef _WIN32
#include <direct.h>
#include <windows.h>
#else // POSIX
#include <unistd.h>
#include <dirent.h>
#endif

bool fatal_throws = false;

Atom make_atom(const string& value)
{
	static unordered_set<string> interned;
	return interned.insert(value).first->c_str();
}

string slurp(const string& filename)
{
	ifstream ifs(filename, ios::binary);

	if (!ifs.good())
		throw runtime_error("open file " +
			filename + ": " +
			string(strerror(errno)));

	// get length of file:
	ifs.seekg(0, ifs.end);
	size_t size = static_cast<size_t>(ifs.tellg());
	ifs.seekg(0, ifs.beg);

	// read in whole file
	string text;
	text.resize(size);
	ifs.read(&text[0], size);

	return text;
}

void spew(const string& filename, const string& text)
{
	ofstream ofs(filename, ios::binary);

	if (!ofs.good())
		throw runtime_error("create file " +
			filename + ": " +
			string(strerror(errno)));

	ofs.write(&text[0], text.length());
}

void make_path(const string& dirname)
{
	if (dir_exists(dirname))            // end recursion
		return;

	make_path(get_dirname(dirname));    // recurse to create parent

#ifdef _WIN32
	CreateDirectory(dirname.c_str(), NULL);
#else
	mkdir(dirname.c_str(), 0777);
#endif
}

void remove_file(const string& filename)
{
	remove(filename.c_str());
}

void remove_dir(const string& dirname)
{
#ifdef _WIN32
	RemoveDirectory(dirname.c_str());
#else
	rmdir(dirname.c_str());
#endif
}

struct iequal {
	bool operator()(int c1, int c2) const
	{
		return toupper(c1) == toupper(c2);
	}
};

bool iequals(const string& a, const string& b)
{
	return a.size() == b.size() &&
		equal(a.begin(), a.end(), b.begin(), iequal());
}

// https://www.fluentcpp.com/2017/04/21/how-to-split-a-string-in-c/
vector<string> split(const string& s, char delimiter)
{
	vector<string> tokens;
	string token;
	istringstream token_stream(s);
	while (getline(token_stream, token, delimiter)) {
		tokens.push_back(token);
	}
	return tokens;
}

string join(const vector<string>& v, char delimiter)
{
	if (v.empty())
		return string();
	else if (v.size() == 1)
		return v[0];
	else {
		string ret = v[0];
		for (size_t i = 1; i < v.size(); i++)
			ret += delimiter + v[i];

		return ret;
	}
}

void auto_expand_env_vars(string& text)
{
#define ENV_VAR_RE	"([a-zA-Z0-9_]+)"
	static regex env_re[] = {
		regex("\\$\\{" ENV_VAR_RE "\\}"),	// ${ENV}
		regex("\\$\\(" ENV_VAR_RE "\\)"),	// $(ENV)
		regex("%" ENV_VAR_RE "%")			// %ENV%
	};
#undef ENV_VAR_RE

	bool matched;
	smatch match;
	do {
		matched = false;
		for (int i = 0; i < NUM_ELEMS(env_re); i++) {
			while (regex_search(text, match, env_re[i])) {
				const char * s = getenv(match[1].str().c_str());
				string var(s == NULL ? "" : s);

				/* Start of HACK
					The following and commented text.replace() works in newer version of g++,
					but not in g++-4.9.
					The std::smatch should return iterators to the original string, but in g++-4.9 it
					returns iterators to new copies of the original string, making it impossible to
					know where the regex matched to replace at that position.
					We also cannot use std::regex_replace because we need match[1] to getenv the
					text to replace.

					The solution is to do another search-replace in the text with the exact string
					matched in regex_search.

				text.replace(
					match[0].first - text.begin(),		// position of start of match
					match[0].second - match[0].first,	// lenght of match
					var);
				*/
				string found = match[0].str();
				size_t index = 0;
				while (true) {
					index = text.find(found, index);
					if (index == string::npos)
						break;
					text.replace(index, found.length(), var);
					index += var.length();
				}
				/* End of HACK */

				matched = true;
			}
		}
	} while (matched);
}

string expand_env_vars(const string& input)
{
	string text = input;
	auto_expand_env_vars(text);
	return text;
}

static inline bool isslash(char c)
{
	return c == '/' || c == '\\';
}

string simplify_path(string path)
{
	replace(path.begin(), path.end(), '\\', '/');
	auto pos = path.find("//");

	while (pos != string::npos) {
		path.erase(pos, 1);
		pos = path.find("//", pos);
	}

	return path;
}

string canonize_path(string path)
{
#ifdef _WIN32
	path = simplify_path(path);
	replace(path.begin(), path.end(), '/', '\\');
	return path;
#else
	return simplify_path(path);
#endif
}

static size_t skip_volume(const string& path)
{
#ifdef _WIN32
	if (path.length() >= 2 && isalpha(path[0]) && path[1] == ':')
		return 2;
#else
	(void)path;		// shut up warning
#endif
	return 0;
}

string get_dirname(string path)
{
	if (path.empty())
		return ".";

	path = simplify_path(path);
	size_t volume_size = skip_volume(path);

	if (path.length() == volume_size)
		return path + ".";
	else if (path.substr(volume_size) == "/")
		return path;

	// remove end slashes
	while (path.length() > 0 && path.back() == '/')
		path.pop_back();

	// find last slash
	size_t p = path.find_last_of('/');

	if (p == string::npos)
		return path.substr(0, volume_size) + ".";
	else if (p == volume_size)
		return path.substr(0, volume_size) + "/";
	else
		return path.substr(0, p);
}

string get_basename(string path)
{
	path.erase(0, skip_volume(path));
	path = simplify_path(path);

	if (path.empty())
		return ".";
	else if (path == "/")
		return path;

	// remove end slashes
	while (path.length() > 0 && path.back() == '/')
		path.pop_back();

	// find last slash
	size_t p = path.find_last_of('/');

	if (p == string::npos)
		return path;
	else
		return path.substr(p + 1);
}

string get_current_dir()
{
	char cwd[FILENAME_MAX];

#ifdef _WIN32
	if (_getcwd(cwd, sizeof(cwd)))
		return simplify_path(cwd);
#else
	if (getcwd(cwd, sizeof(cwd)))
		return simplify_path(cwd);
#endif

	return string(".");		// in case of error
}


string get_extension(const string& path)
{
	auto name = get_basename(path);
	size_t pos = name.find_last_of('.');

	if (pos != string::npos && pos != 0)
		return name.substr(pos);
	else
		return "";
}

string replace_extension(const string& path,
	const string& new_ext)
{
	size_t ext_len = get_extension(path).length();
	return simplify_path(path.substr(0, path.length() - ext_len) + new_ext);
}

string combine_path(string dir, string file)
{
	dir = simplify_path(dir);
	file = simplify_path(file);

	if (is_volume(dir))
		return dir + file;			// no slash

	size_t volume_pos = skip_volume(dir);
	while (dir.length() > volume_pos + 1 && dir.back() == '/')
		dir.pop_back();

	if (dir.empty())
		return file;

	volume_pos = skip_volume(file);
	while (volume_pos < file.length() && file[volume_pos] == '/')
		volume_pos++;

	file.erase(0, volume_pos);

	if (file.empty())
		return dir;
	else if (dir.back() == '/')
		return dir + file;
	else
		return dir + "/" + file;
}

string search_file(const string& filename,
	const vector<string>& dirs)
{
	if (file_exists(filename))
		return filename;

	for (auto& dir : dirs) {
		auto combined = combine_path(dir, filename);

		if (file_exists(combined))
			return combined;
	}

	return string();   // not found
}

// https://www.codeproject.com/Articles/1088/Wildcard-string-compare-globbing
bool wildcard_match(const string& wildcard, const string& text)
{
	// Written by Jack Handy - <A href="mailto:jakkhandy@hotmail.com">jakkhandy@hotmail.com</A>
	const char *wild_p = wildcard.c_str();
	const char *text_p = text.c_str();
	const char *cp = NULL, *mp = NULL;

	while ((*text_p) && (*wild_p != '*')) {
		if ((*wild_p != *text_p) && (*wild_p != '?')) {
			return false;
		}
		wild_p++;
		text_p++;
	}

	while (*text_p) {
		if (*wild_p == '*') {
			if (!*++wild_p) {
				return true;
			}
			mp = wild_p;
			cp = text_p + 1;
		}
		else if ((*wild_p == *text_p) || (*wild_p == '?')) {
			wild_p++;
			text_p++;
		}
		else {
			wild_p = mp;
			text_p = cp++;
		}
	}

	while (*wild_p == '*') {
		wild_p++;
	}
	return !*wild_p;
}

vector<string> utils_list_dir(const string& directory)
{
	vector<string> result;
	if (!dir_exists(directory))
		return result;

#ifdef _WIN32
	WIN32_FIND_DATA FindFileData;
	HANDLE hFind;
	string pattern = combine_path(directory, "*");

	hFind = FindFirstFile(pattern.c_str(), &FindFileData);
	if (hFind == INVALID_HANDLE_VALUE) {
		cerr << "FindFirstFile " << directory << " failed: " << GetLastError();
		err_fatal_exit();
	}
	else {
		do {
			string file(FindFileData.cFileName);
			if (file != "." && file != "..")
				result.push_back(file);
		} while (FindNextFile(hFind, &FindFileData) != 0);
	}
	FindClose(hFind);
#else
	DIR *dp;
	struct dirent *ep;
	dp = opendir(directory.c_str());

	if (dp == NULL) {
		perror(directory.c_str());
		exit(EXIT_FAILURE);
	}
	else {
		while ((ep = readdir(dp)) != NULL) {
			string file(ep->d_name);
			if (file != "." && file != "..")
				result.push_back(file);
		}
		closedir(dp);
	}
#endif

	sort(result.begin(), result.end());

	return result;
}

static void expand_file_glob_recurse(vector<string>& result,
	string left, string right)
{
	if (right.empty()) {
		if (file_exists(left))
			result.push_back(left);
		return;
	}

	string dir;
	auto p = right.find('/');
	if (p == string::npos) {						// last level
		dir = right;
		right.clear();
	}
	else {
		dir = right.substr(0, p);
		right = right.substr(p + 1);
		if (dir.empty()) {
			expand_file_glob_recurse(result, left, right);		// skip dir and recurse
			return;
		}
	}

	if (!has_wildcard(dir)) {					// no wild card
		string path = combine_path(left, dir);
		if (right.empty()) {					// last component - file
			if (file_exists(path))
				result.push_back(path);
			return;
		}
		else {									// middle component - dir
			if (dir_exists(path))
				expand_file_glob_recurse(result, path, right);	// recuse
			return;
		}
	}
	else if (dir.find("**") != string::npos) {	// recursive subdir wildcard

		// ** -> null
		if (dir == "**")
			expand_file_glob_recurse(result, left, right);								// recuse

		auto files = utils_list_dir(left);
		for (auto& file : files) {
			string path = combine_path(left, file);
			if (right.empty()) {					// last component - file
				if (file_exists(path) && wildcard_match(dir, file))
					result.push_back(path);
			}
			else {									// middle component - dir
				if (dir_exists(path) && wildcard_match(dir, file)) {
					// ** -> dir ath this level that matches
					expand_file_glob_recurse(result, path, right);						// recuse

					// ** -> test any subdir
					expand_file_glob_recurse(result, path, combine_path(dir, right));	// recuse
				}
			}
		}
		return;
	}
	else {											// non-recursive wildcard
		auto files = utils_list_dir(left);
		for (auto& file : files) {
			string path = combine_path(left, file);
			if (right.empty()) {					// last component - file
				if (file_exists(path) && wildcard_match(dir, file))
					result.push_back(path);
			}
			else {									// middle component - dir
				if (dir_exists(path) && wildcard_match(dir, file))
					expand_file_glob_recurse(result, path, right);	// recuse
			}
		}
		return;
	}
}

bool has_wildcard(const string& file)
{
	if (file.find_first_of("*?") == string::npos)
		return false;
	else
		return true;
}

vector<string> expand_file_glob(string wildcard)
{
	vector<string> result;

	wildcard = simplify_path(wildcard);

	if (file_exists(wildcard)) {
		result.push_back(wildcard);
	}
	else if (!has_wildcard(wildcard)) {
		;						// no wild cards, and no file match
	}
	else {
		string left;
		string right = wildcard;

		// handle root dir
#ifdef _WIN32
		if (right.length() > 2 && is_volume(right.substr(0, 2))) {
			left += right.substr(0, 2);
			right = right.substr(2);
		}
#endif
		if (!right.empty() && right[0] == '/') {
			left += "/";
			right.erase(right.begin());
		}

		// expand subdirs
		expand_file_glob_recurse(result, left, right);
	}

	// sort and remove duplicates
	sort(result.begin(), result.end());
	result.erase(unique(result.begin(), result.end()), result.end());

	return result;
}

// https://stackoverflow.com/questions/6089231/getting-std-ifstream-to-handle-lf-cr-and-crlf
istream& safe_getline(istream& is, string& t)
{
	t.clear();

	// The characters in the stream are read one-by-one using a streambuf.
	// That is faster than reading them one-by-one using the istream.
	// Code that uses streambuf this way must be guarded by a sentry object.
	// The sentry object performs various tasks,
	// such as thread synchronization and updating the stream state.

	istream::sentry se(is, true);
	streambuf* sb = is.rdbuf();

	for (;;) {
		int c = sb->sbumpc();

		switch (c) {
		case '\n':
			return is;

		case '\r':
			if (sb->sgetc() == '\n')
				sb->sbumpc();

			return is;

		case streambuf::traits_type::eof():

			// Also handle the case when the last line has no line ending
			if (t.empty())
				is.setstate(ios::eofbit);

			return is;

		default:
			t += (char)c;
		}
	}
}

bool file_exists(const string& filename)
{
	struct stat sb;

	if (stat(filename.c_str(), &sb) == 0 && (sb.st_mode & S_IFREG))
		return true;
	else
		return false;
}

bool dir_exists(const string& dirname)
{
	struct stat sb;

	if ((stat(dirname.c_str(), &sb) == 0) && (sb.st_mode & S_IFDIR))
		return true;
	else
		return false;
}

bool is_volume(const string& path)
{
#if _WIN32
	if (path.length() == 2 && isalpha(path[0]) && path[1] == ':')
		return true;
#else
	(void)path;		// shut up warning
#endif
	return false;
}

void trim(string& text)
{
	text.erase(text.begin(), find_if(text.begin(), text.end(),
		[](int ch) {
		return !isspace(ch);
	}));
	text.erase(find_if(text.rbegin(), text.rend(),
		[](int ch) {
		return !isspace(ch);
	}).base(), text.end());
}

void chomp(string& text)
{
	text.erase(find_if(text.rbegin(), text.rend(),
		[](int ch) {
		return !(ch == '\r' || ch == '\n');
	}).base(), text.end());
}

Argv::Argv(const vector<string>& args)
{
	init(args);
}

Argv::~Argv()
{
	clear_();
}

void Argv::init(const vector<string>& args)
{
	clear_();

	m_size = args.size();
	m_args = new char*[args.size() + 1];
	for (int i = 0; i < m_size; i++) {
		m_args[i] = strdup(args[i].c_str());
	}
	m_args[m_size] = nullptr;
}

void Argv::clear()
{
	init({});
}

char ** Argv::argv()
{
	return m_args;
}

int Argv::argc()
{
	return m_size;
}

void Argv::clear_()
{
	if (m_args) {
		for (int i = 0; i < m_size; i++) {
			free(m_args[i]);
		}
		delete[] m_args;
	}
}
