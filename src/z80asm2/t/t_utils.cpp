//-----------------------------------------------------------------------------
// z80asm unit tests
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "test.h"
#include "../utils.h"

#ifdef _WIN32
#include <windows.h>
#else // POSIX
#include <unistd.h>
#endif
#include <sys/stat.h>


void test_redirect()
{
    std::cout << "# standard output" << std::endl;
    std::cerr << "# standard error" << std::endl;

    START_CAPTURE();
    std::cout << "# redirected output" << std::endl;
    std::cerr << "# redirected error" << std::endl;
    END_CAPTURE("# redirected output\n",
                "# redirected error\n");
}

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

    std::string text = slurp("test.1");
    IS_STR(text.c_str(), "hello world");

    remove_file("test.1");

    try {
        text = slurp("test.1");
        FAIL();
    }
    catch (std::exception& e) {
        PASS();
        DIAG(e.what());
    }

    try {
        spew("dir/does/not/exit/test.1", "hello world");
        FAIL();
    }
    catch (std::exception& e) {
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
    IS_STR(combine_path("dir", "file"), "dir/file");
    IS_STR(combine_path("dir/", "file"), "dir/file");
    IS_STR(combine_path("dir//\\", "file"), "dir/file");
    IS_STR(combine_path("dir", "/file"), "dir/file");
    IS_STR(combine_path("dir", "//\\file"), "dir/file");

#ifdef _WIN32
    IS_STR(combine_path("a:dir", "b:file"), "a:dir/file");
    IS_STR(combine_path("a:dir", "b:/file"), "a:dir/file");
#endif
}

void test_getline()
{
    std::string s;

    std::ofstream out("test.txt", std::ios::binary);
    ASSERT(out.good());
    out.write("a\nb\rc\r\nd", 8);
    out.close();

    std::ifstream in("test.txt", std::ios::binary);
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

    std::vector<std::string> dirs;
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

void test_strip()
{
    std::string text;

    text = " \r\n\t\v\f  \r\n\t\v\f ";
    trim(text);
    IS_STR(text, "");

    text = " \r\n\t\v\f hello \r\n\t\v\f ";
    trim(text);
    IS_STR(text, "hello");
}

void test_chomp()
{
    std::string text;

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

void test_replace_words()
{
    std::string text;

    text = "hello world";
    replace_words(text, "hello", "ola");
    replace_words(text, "world", "mundo");
    OK(text == "ola mundo");

    text = "hello world";
    replace_words(text, "hell", "HELL");
    OK(text == "hello world");

    text = "hello";
    replace_words(text, "llo", "LLO");
    OK(text == "hello");

    text = "he#ll#o";
    replace_words(text, "#ll#", "LL");
    OK(text == "heLLo");

    text = "#ll#";
    replace_words(text, "#ll#", "LL");
    OK(text == "LL");
}
