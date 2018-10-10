//-----------------------------------------------------------------------------
// z80asm restart
// unit tests
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "test.h"
#include "../utils.h"
#ifdef _WIN32
#include <windows.h>
#else // POSIX
#include <unistd.h>
#endif

void test_atom()
{
	Atom p1, p2, q1, q2;
	p1 = make_atom("hello");
	p2 = make_atom("world");
	q1 = make_atom("hello");
	q2 = make_atom("world");
	OK(p1 == q1);
	OK(p2 == q2);
	IS_STR(p1, "hello");
	IS_STR(p2, "world");
}

void test_spew_slurp()
{
	remove_file("test.1");
	NOK(file_exists("test.1"));
	spew("test.1", "hello world");
	OK(file_exists("test.1"));

	string text = slurp("test.1");
	IS_STR(text.c_str(), "hello world");

	remove_file("test.1");

	try {
		text = slurp("test.1");
		FAIL();
	}
	catch (exception& e) {
		PASS();
		DIAG(e.what());
	}

	try {
		spew("dir/does/not/exit/test.1", "hello world");
		FAIL();
	}
	catch (exception& e) {
		PASS();
		DIAG(e.what());
	}
}

void test_make_remove_dir()
{
#ifdef _WIN32
	RemoveDirectory("test_dir");
#else
	rmdir("test_dir");
#endif

	ASSERT(!dir_exists("test_dir"));
	make_path("test_dir/x/y/z");
	ASSERT(dir_exists("test_dir/x/y/z"));
	spew("test_dir/x/y/z/abc.txt", "hello");
	OK(slurp("test_dir/x/y/z/abc.txt") == "hello");
	remove_dir("test_dir/x/y/z");           // fails, directory not empty
	OK(slurp("test_dir/x/y/z/abc.txt") == "hello");
	remove_file("test_dir/x/y/z/abc.txt");

	remove_dir("test_dir/x/y/z");
	NOK(dir_exists("test_dir/x/y/z"));
	remove_dir("test_dir/x/y");
	NOK(dir_exists("test_dir/x/y"));
	remove_dir("test_dir/x");
	NOK(dir_exists("test_dir/x"));
	remove_dir("test_dir");
	NOK(dir_exists("test_dir"));
}

void test_iequals()
{
	OK(iequals("", ""));
	NOK(iequals("", "x"));
	OK(iequals("hello", "hello"));
	OK(iequals("HELLo", "hello"));
	NOK(iequals("hello", "hellox"));
}

void test_split()
{
	vector<string> tokens;

	tokens = split("", ',');
	IS(tokens.size(), 0);

	tokens = split("ab", ',');
	IS(tokens.size(), 1);
	IS(tokens[0], "ab");

	tokens = split("ab,", ',');
	IS(tokens.size(), 1);
	IS(tokens[0], "ab");

	tokens = split("ab,cd", ',');
	IS(tokens.size(), 2);
	IS(tokens[0], "ab");
	IS(tokens[1], "cd");

	tokens = split("ab,cd,", ',');
	IS(tokens.size(), 2);
	IS(tokens[0], "ab");
	IS(tokens[1], "cd");

	tokens = split("ab,cd,,", ',');
	IS(tokens.size(), 3);
	IS(tokens[0], "ab");
	IS(tokens[1], "cd");
	IS(tokens[2], "");

	tokens = split("ab,cd,,ef", ',');
	IS(tokens.size(), 4);
	IS(tokens[0], "ab");
	IS(tokens[1], "cd");
	IS(tokens[2], "");
	IS(tokens[3], "ef");

	tokens = split(",ab,cd,,ef", ',');
	IS(tokens.size(), 5);
	IS(tokens[0], "");
	IS(tokens[1], "ab");
	IS(tokens[2], "cd");
	IS(tokens[3], "");
	IS(tokens[4], "ef");
}

void test_join()
{
	IS(join({}, ','), "");
	IS(join({"a"}, ','), "a");
	IS(join({"a", "b"}, ','), "a,b");
	IS(join({"a", "", "b"}, ','), "a,,b");
	IS(join({"", "a", "", "b"}, ','), ",a,,b");
}

void test_expand_env_vars()
{
	putenv("TEST1=");
	putenv("TEST2=");
	putenv("TEST3=world");
	putenv("TEST4=hello");

	string text = "x${TEST1}${TEST1}y${TEST2}${TEST2}z$(TEST3)$(TEST3)%TEST4%%TEST4%";
	string ret = expand_env_vars(text);
	IS(text, "x${TEST1}${TEST1}y${TEST2}${TEST2}z$(TEST3)$(TEST3)%TEST4%%TEST4%");
	IS(ret, "xyzworldworldhellohello");

	auto_expand_env_vars(text);
	IS(text, "xyzworldworldhellohello");

	putenv("TEST1=TEST2");
	putenv("TEST2=hello");

	text = "x${${TEST1}}y";
	auto_expand_env_vars(text);
	IS(text, "xhelloy");

	putenv("TEST1=");
	putenv("TEST2=");
	putenv("TEST3=");
	putenv("TEST4=");
}

void test_simplify_path()
{
	IS_STR(simplify_path(""), "");
	IS_STR(simplify_path("/"), "/");
	IS_STR(simplify_path("\\"), "/");
	IS_STR(simplify_path("//\\"), "/");
	IS_STR(simplify_path("//\\a"), "/a");
	IS_STR(simplify_path("//\\a/"), "/a/");
	IS_STR(simplify_path("//\\a/b"), "/a/b");
	IS_STR(simplify_path("//\\a//\\b"), "/a/b");
}

void test_canonize_path()
{
#ifdef _WIN32
	IS_STR(canonize_path(""), "");
	IS_STR(canonize_path("/"), "\\");
	IS_STR(canonize_path("\\"), "\\");
	IS_STR(canonize_path("//\\"), "\\");
	IS_STR(canonize_path("//\\a"), "\\a");
	IS_STR(canonize_path("//\\a/"), "\\a\\");
	IS_STR(canonize_path("//\\a/b"), "\\a\\b");
	IS_STR(canonize_path("//\\a//\\b"), "\\a\\b");
#else
	IS_STR(canonize_path(""), "");
	IS_STR(canonize_path("/"), "/");
	IS_STR(canonize_path("\\"), "/");
	IS_STR(canonize_path("//\\"), "/");
	IS_STR(canonize_path("//\\a"), "/a");
	IS_STR(canonize_path("//\\a/"), "/a/");
	IS_STR(canonize_path("//\\a/b"), "/a/b");
	IS_STR(canonize_path("//\\a//\\b"), "/a/b");
#endif
}

void test_get_dirname()
{
	IS_STR(get_dirname(""), ".");
	IS_STR(get_dirname("."), ".");
	IS_STR(get_dirname(".."), ".");
	IS_STR(get_dirname("/"), "/");
	IS_STR(get_dirname("usr"), ".");
	IS_STR(get_dirname("/usr"), "/");
	IS_STR(get_dirname("/usr/"), "/");
	IS_STR(get_dirname("/usr/lib"), "/usr");
	IS_STR(get_dirname("/usr/lib/"), "/usr");
#ifdef _WIN32
	IS_STR(get_dirname("a:"), "a:.");
	IS_STR(get_dirname("a:."), "a:.");
	IS_STR(get_dirname("a:.."), "a:.");
	IS_STR(get_dirname("a:/"), "a:/");
	IS_STR(get_dirname("a:usr"), "a:.");
	IS_STR(get_dirname("a:/usr"), "a:/");
	IS_STR(get_dirname("a:/usr/"), "a:/");
	IS_STR(get_dirname("a:/usr/lib"), "a:/usr");
	IS_STR(get_dirname("a:/usr/lib/"), "a:/usr");
#endif
}

void test_get_basename()
{
	IS_STR(get_basename(""), ".");
	IS_STR(get_basename("."), ".");
	IS_STR(get_basename(".."), "..");
	IS_STR(get_basename("/"), "/");
	IS_STR(get_basename("usr"), "usr");
	IS_STR(get_basename("/usr"), "usr");
	IS_STR(get_basename("/usr/"), "usr");
	IS_STR(get_basename("/usr/lib"), "lib");
	IS_STR(get_basename("/usr/lib/"), "lib");
#ifdef _WIN32
	IS_STR(get_basename("a:"), ".");
	IS_STR(get_basename("a:."), ".");
	IS_STR(get_basename("a:.."), "..");
	IS_STR(get_basename("a:/"), "/");
	IS_STR(get_basename("a:usr"), "usr");
	IS_STR(get_basename("a:/usr"), "usr");
	IS_STR(get_basename("a:/usr/"), "usr");
	IS_STR(get_basename("a:/usr/lib"), "lib");
	IS_STR(get_basename("a:/usr/lib/"), "lib");
#endif
}

void test_get_extension()
{
	IS_STR(get_extension("/abc.x/de.c"), ".c");
	IS_STR(get_extension("/abc.x/de.c.o"), ".o");
	IS_STR(get_extension("/abc.x/.c"), "");
	IS_STR(get_extension("/abc.x/de"), "");
#ifdef _WIN32
	IS_STR(get_extension("a:de.c"), ".c");
	IS_STR(get_extension("a:.c"), "");
#endif
}

void test_replace_extension()
{
	IS_STR(replace_extension("/abc.x/de.c", ".o"), "/abc.x/de.o");
	IS_STR(replace_extension("/abc.x/de.c", ""), "/abc.x/de");
	IS_STR(replace_extension("/abc.x/de.c.o", ".x"), "/abc.x/de.c.x");
	IS_STR(replace_extension("/abc.x/.c", ".o"), "/abc.x/.c.o");
	IS_STR(replace_extension("/abc.x/de", ".o"), "/abc.x/de.o");
#ifdef _WIN32
	IS_STR(replace_extension("a:de.c", ".o"), "a:de.o");
	IS_STR(replace_extension("a:.c", ".o"), "a:.c.o");
#endif
}

void test_combine_path()
{
	IS_STR(combine_path("", "file"), "file");
	IS_STR(combine_path("/", "file"), "/file");
	IS_STR(combine_path("//", "file"), "/file");
	IS_STR(combine_path("", "/file"), "/file");
	IS_STR(combine_path("/", "/file"), "/file");
	IS_STR(combine_path("//", "/file"), "/file");
	IS_STR(combine_path("dir", ""), "dir");
	IS_STR(combine_path("dir", "file"), "dir/file");
	IS_STR(combine_path("dir/", "file"), "dir/file");
	IS_STR(combine_path("dir//\\", "file"), "dir/file");
	IS_STR(combine_path("dir", "/file"), "dir/file");
	IS_STR(combine_path("dir", "//\\file"), "dir/file");

#ifdef _WIN32
	IS_STR(combine_path("", "b:file"), "b:file");
	IS_STR(combine_path("", "b:/file"), "b:/file");
	IS_STR(combine_path("c:", "file"), "c:file");
	IS_STR(combine_path("c:/", "file"), "c:/file");
	IS_STR(combine_path("c://", "file"), "c:/file");
	IS_STR(combine_path("c:", "/file"), "c:/file");
	IS_STR(combine_path("c:/", "/file"), "c:/file");
	IS_STR(combine_path("c://", "/file"), "c:/file");
	IS_STR(combine_path("a:dir", ""), "a:dir");
	IS_STR(combine_path("a:dir", "b:"), "a:dir");
	IS_STR(combine_path("a:dir", "b:file"), "a:dir/file");
	IS_STR(combine_path("a:dir", "b:/file"), "a:dir/file");
#endif
}

void test_getline()
{
	string s;

	ofstream out("test.txt", ios::binary);
	ASSERT(out.good());
	out.write("a\nb\rc\r\nd", 8);
	out.close();

	ifstream in("test.txt", ios::binary);
	ASSERT(in.good());

	OK(!safe_getline(in, s).eof());
	OK(s == "a");
	OK(!safe_getline(in, s).eof());
	OK(s == "b");
	OK(!safe_getline(in, s).eof());
	OK(s == "c");
	OK(!safe_getline(in, s).eof());
	OK(s == "d");
	OK(safe_getline(in, s).eof());
	OK(s == "");
	OK(safe_getline(in, s).eof());
	OK(s == "");
	in.close();

	remove_file("test.txt");
}

void test_file_checks()
{
	remove_file("test1.txt");
	spew("test2.txt", "");
	spew("test3.txt", "12345");

#ifdef _WIN32
	RemoveDirectory("test_dir1");
	CreateDirectory("test_dir2", NULL);
#else
	rmdir("test_dir1");
	mkdir("test_dir2", 0777);
#endif

	NOK(file_exists("test1.txt"));
	OK(file_exists("test2.txt"));
	OK(file_exists("test3.txt"));

	NOK(dir_exists("test_dir1"));
	OK(dir_exists("test_dir2"));

	remove_file("test1.txt");
	remove_file("test2.txt");
	remove_file("test3.txt");

#ifdef _WIN32
	RemoveDirectory("test_dir2");
#else
	rmdir("test_dir2");
#endif
}

void test_is_volume()
{
#ifdef _WIN32
	NOK(is_volume(""));
	NOK(is_volume("a"));
	OK(is_volume("a:"));
	NOK(is_volume("a:/"));
#else
	NOK(is_volume(""));
	NOK(is_volume("a"));
	NOK(is_volume("a:"));
	NOK(is_volume("a:/"));
#endif
}

void test_search_file_file_exists()
{
	spew("test.1", "");
	make_path("test_dir");
	spew("test_dir/test.1", "");
	spew("test_dir/test.2", "");

	OK(file_exists("test.1"));
	OK(file_exists("test_dir/test.1"));
	OK(file_exists("test_dir/test.2"));
	NOK(file_exists("test.3"));

	vector<string> dirs;
	IS_STR(search_file("test.1", dirs), "test.1");
	IS_STR(search_file("test.2", dirs), "");

	dirs.push_back("test_dir_not_found");
	dirs.push_back("test_dir");

	IS_STR(search_file("test.1", dirs), "test.1");
	IS_STR(search_file("test.2", dirs), "test_dir/test.2");
	IS_STR(search_file("test.3", dirs), "");

	remove_file("test.1");
	remove_file("test_dir/test.1");
	remove_file("test_dir/test.2");
	remove_dir("test_dir");

	NOK(file_exists("test.1"));
	NOK(file_exists("test_dir/test.1"));
	NOK(file_exists("test_dir/test.2"));
	NOK(file_exists("test.3"));
}

void test_wildcard_match()
{
	OK(wildcard_match("*", ""));
	OK(wildcard_match("*", "a"));
	OK(wildcard_match("*", "ab"));

	NOK(wildcard_match("ab*", ""));
	NOK(wildcard_match("ab*", "a"));
	OK(wildcard_match("ab*", "ab"));
	OK(wildcard_match("ab*", "abc"));
	OK(wildcard_match("ab*", "abcd"));

	NOK(wildcard_match("a*b", ""));
	NOK(wildcard_match("a*b", "a"));
	OK(wildcard_match("a*b", "ab"));
	OK(wildcard_match("a*b", "a1b"));
	OK(wildcard_match("a*b", "a12b"));
	OK(wildcard_match("a*b", "a123b"));

	NOK(wildcard_match("a**b", ""));
	NOK(wildcard_match("a**b", "a"));
	OK(wildcard_match("a**b", "ab"));
	OK(wildcard_match("a**b", "a1b"));
	OK(wildcard_match("a**b", "a12b"));
	OK(wildcard_match("a**b", "a123b"));

	NOK(wildcard_match("a?b", ""));
	NOK(wildcard_match("a?b", "a"));
	NOK(wildcard_match("a?b", "ab"));
	OK(wildcard_match("a?b", "a1b"));
	OK(wildcard_match("a?b", "a2b"));
	NOK(wildcard_match("a?b", "a12b"));
}

// private function
vector<string> utils_list_dir(const string& directory);

void test_has_wildcard()
{
	OK(has_wildcard("file*"));
	OK(has_wildcard("file?"));
	OK(has_wildcard("file**"));
	NOK(has_wildcard("file"));
}

void test_list_dir()
{
	const char* test_files[] = {
		"test/a.asm",
		"test/b.c",
		"test/c.o",

		"test/d1/d.asm",
		"test/d1/e.c",
		"test/d1/f.o",
		"test/d1/sub1/a/a.asm",
		"test/d1/sub1/a/b.asm",
		"test/d1/sub1/b/a.asm",
		"test/d1/sub1/b/b.asm",
		"test/d1/sub2/a/a.asm",
		"test/d1/sub2/a/b.asm",
		"test/d1/sub2/b/a.asm",
		"test/d1/sub2/b/b.asm",

		"test/d2/g.asm",
		"test/d2/h.c",
		"test/d2/i.o",
		"test/d2/sub1/a/a.asm",
		"test/d2/sub1/a/b.asm",
		"test/d2/sub1/b/a.asm",
		"test/d2/sub1/b/b.asm",
		"test/d2/sub2/a/a.asm",
		"test/d2/sub2/a/b.asm",
		"test/d2/sub2/b/a.asm",
		"test/d2/sub2/b/b.asm",

	};

	// create test files
	for (int i = 0; i < NUM_ELEMS(test_files); i++) {
		string parent = get_dirname(test_files[i]);
		make_path(parent);
		ASSERT(dir_exists(parent));
		spew(test_files[i], "");
		ASSERT(file_exists(test_files[i]));
	}

	vector<string> list;

	ASSERT(!dir_exists("test2"));
	list = utils_list_dir("test2");
	IS(list.size(), 0);

	list = utils_list_dir("test");
	IS(list.size(), 5);
	IS(list[0], "a.asm");
	IS(list[1], "b.c");
	IS(list[2], "c.o");
	IS(list[3], "d1");
	IS(list[4], "d2");

	ASSERT(!file_exists("test2"));
	list = expand_file_glob("test2");
	IS(list.size(), 0);

	list = expand_file_glob("test/\\/a.asm");
	IS(list.size(), 1);
	IS(list[0], "test/a.asm");

	list = expand_file_glob("test/\\/?.?");
	IS(list.size(), 2);
	IS(list[0], "test/b.c");
	IS(list[1], "test/c.o");

	list = expand_file_glob("test/\\/?.*");
	IS(list.size(), 3);
	IS(list[0], "test/a.asm");
	IS(list[1], "test/b.c");
	IS(list[2], "test/c.o");

	list = expand_file_glob("test/*");
	IS(list.size(), 3);
	IS(list[0], "test/a.asm");
	IS(list[1], "test/b.c");
	IS(list[2], "test/c.o");

	list = expand_file_glob("test/*1/*.asm");
	IS(list.size(), 1);
	IS(list[0], "test/d1/d.asm");

	list = expand_file_glob("test/*/*.asm");
	IS(list.size(), 2);
	IS(list[0], "test/d1/d.asm");
	IS(list[1], "test/d2/g.asm");

	list = expand_file_glob("test/**1/*.asm");
	IS(list.size(), 1);
	IS(list[0], "test/d1/d.asm");

	list = expand_file_glob("test/**1/**/*.asm");
	IS(list.size(), 9);
	IS(list[0], "test/d1/d.asm");
	IS(list[1], "test/d1/sub1/a/a.asm");
	IS(list[2], "test/d1/sub1/a/b.asm");
	IS(list[3], "test/d1/sub1/b/a.asm");
	IS(list[4], "test/d1/sub1/b/b.asm");
	IS(list[5], "test/d1/sub2/a/a.asm");
	IS(list[6], "test/d1/sub2/a/b.asm");
	IS(list[7], "test/d1/sub2/b/a.asm");
	IS(list[8], "test/d1/sub2/b/b.asm");

	list = expand_file_glob("test/**/a.asm");
	IS(list.size(), 9);
	IS(list[0], "test/a.asm");
	IS(list[1], "test/d1/sub1/a/a.asm");
	IS(list[2], "test/d1/sub1/b/a.asm");
	IS(list[3], "test/d1/sub2/a/a.asm");
	IS(list[4], "test/d1/sub2/b/a.asm");
	IS(list[5], "test/d2/sub1/a/a.asm");
	IS(list[6], "test/d2/sub1/b/a.asm");
	IS(list[7], "test/d2/sub2/a/a.asm");
	IS(list[8], "test/d2/sub2/b/a.asm");

	string cwd = get_current_dir();
	string pattern = combine_path(cwd, "test/*1/*.asm");
	list = expand_file_glob(pattern);
	IS(list.size(), 1);
	IS(list[0], combine_path(cwd,"test/d1/d.asm"));

#ifdef _WIN32
	ASSERT(cwd.length() > 2);
	ASSERT(is_volume(cwd.substr(0, 2)));
	pattern = combine_path(cwd.substr(2), "test/*1/*.asm");
	list = expand_file_glob(pattern);
	IS(list.size(), 1);
	IS(list[0], combine_path(cwd.substr(2), "test/d1/d.asm"));
#endif

	string cwd_pattern = cwd;
	cwd_pattern[3] = '?';		// transform top dir into wildcard

	pattern = combine_path(cwd_pattern, "test/*1/*.asm");
	list = expand_file_glob(pattern);
	IS(list.size(), 1);
	IS(list[0], combine_path(cwd, "test/d1/d.asm"));

#ifdef _WIN32
	ASSERT(cwd.length() > 2);
	ASSERT(is_volume(cwd.substr(0, 2)));
	pattern = combine_path(cwd_pattern.substr(2), "test/*1/*.asm");
	list = expand_file_glob(pattern);
	IS(list.size(), 1);
	IS(list[0], combine_path(cwd.substr(2), "test/d1/d.asm"));
#endif

	// remove test files
	for (int i = NUM_ELEMS(test_files) - 1; i >= 0; i--) {
		remove_file(test_files[i]);
		ASSERT(!file_exists(test_files[i]));
	}
	for (int i = NUM_ELEMS(test_files) - 1; i >= 0; i--) {
		string parent = get_dirname(test_files[i]);
		while (parent != "." && dir_exists(parent)) {
			remove_dir(parent);
			parent = get_dirname(parent);
		}
	}

	ASSERT(!dir_exists("test"));
}

void test_strip()
{
	string text;

	text = " \r\n\t\v\f  \r\n\t\v\f ";
	trim(text);
	IS_STR(text, "");

	text = " \r\n\t\v\f hello \r\n\t\v\f ";
	trim(text);
	IS_STR(text, "hello");
}

void test_chomp()
{
	string text;

	text = " \r\n\t\v\f  \r\n\t\v\f ";
	chomp(text);
	IS_STR(text, " \r\n\t\v\f  \r\n\t\v\f ");

	text = " hello ";
	chomp(text);
	IS_STR(text, " hello ");

	text = " hello \r";
	chomp(text);
	IS_STR(text, " hello ");

	text = " hello \n";
	chomp(text);
	IS_STR(text, " hello ");

	text = " hello \r\r\n\n";
	chomp(text);
	IS_STR(text, " hello ");
}

void test_argv()
{
	{
		Argv a({});
		char** p = a.argv();
		int n = a.argc();
		ASSERT(p);
		IS(n, 0);
		OK(p[0] == nullptr);
	}
	{
		Argv a({ "one" });
		char** p = a.argv();
		int n = a.argc();
		ASSERT(p);
		IS(n, 1);
		IS(string(p[0]), "one");
		OK(p[1] == nullptr);
	}
	{
		Argv a({ "one", "two" });
		char** p = a.argv();
		int n = a.argc();
		ASSERT(p);
		IS(n, 2);
		IS(string(p[0]), "one");
		IS(string(p[1]), "two");
		OK(p[2] == nullptr);
	}
	{
		Argv a({ "one", "two" });
		char** p = a.argv();
		int n = a.argc();
		ASSERT(p);
		IS(n, 2);
		IS(string(p[0]), "one");
		IS(string(p[1]), "two");
		OK(p[2] == nullptr);

		a.clear();
		p = a.argv();
		n = a.argc();
		ASSERT(p);
		IS(n, 0);
		OK(p[0] == nullptr);

		a.init({ "one", "two" });
		p = a.argv();
		n = a.argc();
		ASSERT(p);
		IS(n, 2);
		IS(string(p[0]), "one");
		IS(string(p[1]), "two");
		OK(p[2] == nullptr);

		a.clear();
		p = a.argv();
		n = a.argc();
		ASSERT(p);
		IS(n, 0);
		OK(p[0] == nullptr);
	}
}
