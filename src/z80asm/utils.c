/*
Z88DK Z80 Macro Assembler

Utilities

Copyright (C) Paulo Custodio, 2011-2019
License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
Repository: https://github.com/z88dk/z88dk
*/

#include "utils.h"
#include "uthash.h"

#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <string.h>
#include <sys/stat.h>

//-----------------------------------------------------------------------------
// types
//-----------------------------------------------------------------------------

// string pool
typedef struct str_pool_t {
	char* str;
	UT_hash_handle hh;
} str_pool_t;


//-----------------------------------------------------------------------------
// global data
//-----------------------------------------------------------------------------
static str_pool_t* spool = NULL;


//-----------------------------------------------------------------------------
// init
//-----------------------------------------------------------------------------
static void spool_deinit();

static void utils_deinit(void)
{
	spool_deinit();
}

static void utils_init()
{
	static bool inited = false;
	if (!inited) {
		atexit(utils_deinit);
		inited = true;
	}
}

//-----------------------------------------------------------------------------
// error messages and check memory allocation
//-----------------------------------------------------------------------------
static void check_mem(void* p)
{
	if (!p) {
		fputs("Out of memory", stderr);
		exit(EXIT_FAILURE);
	}
}

static void check_file(FILE* fp, const char* filename)
{
	if (!fp) {
		perror(filename);
		exit(EXIT_FAILURE);
	}
}

void die(char* msg, ...)
{
	va_list argptr;

	va_start(argptr, msg);
	vfprintf(stderr, msg, argptr);
	va_end(argptr);

	exit(EXIT_FAILURE);
}

void* xmalloc(size_t size)
{
	void* ptr = malloc(size);
	check_mem(ptr);
	return ptr;
}

void* xcalloc(size_t num, size_t size)
{
	void* ptr = calloc(num, size);
	check_mem(ptr);
	return ptr;
}

void* xrealloc(void* ptr, size_t size)
{
	void* new_ptr = realloc(ptr, size);
	check_mem(new_ptr);
	return new_ptr;

}

char* xstrdup(const char* str)
{
	char* ptr = strdup(str);
	check_mem(ptr);
	return ptr;
}

//-----------------------------------------------------------------------------
// string pool
//-----------------------------------------------------------------------------
static void spool_deinit()
{
	str_pool_t* elem, * tmp;
	HASH_ITER(hh, spool, elem, tmp) {
		HASH_DEL(spool, elem);
		xfree(elem);
	}
}

const char* str_pool_add(const char* str)
{
	utils_init();

	if (str == NULL) return NULL;		// special case

	str_pool_t* found;
	HASH_FIND_STR(spool, str, found);
	if (found) return found->str;		// found

	found = xnew(str_pool_t);
	found->str = xstrdup(str);

	HASH_ADD_STR(spool, str, found);

	return found->str;
}

void utstring_toupper(UT_string* str)
{
	for (char* p = utstring_body(str); *p; p++)
		* p = toupper(*p);
}

void utstring_tolower(UT_string* str)
{
	for (char* p = utstring_body(str); *p; p++)
		* p = tolower(*p);
}

void utstring_chomp(UT_string* str)
{
	char* end = utstring_body(str) + utstring_len(str);
	while (end > utstring_body(str) && isspace(end[-1]))
		end--;
	*end = '\0';
	utstring_len(str) = end - utstring_body(str);
}

void utstring_strip(UT_string* str)
{
	char* start = utstring_body(str);
	while (*start != '\0' && isspace(*start))
		start++;
	size_t len = utstring_len(str) - (start - utstring_body(str));
	memmove(utstring_body(str), start, len + 1);	// move also '\0'
	utstring_len(str) = len;
	utstring_chomp(str);							// remove ending spaces	
}

//-----------------------------------------------------------------------------
// file utils
//-----------------------------------------------------------------------------
FILE* xfopen(const char* filename, const char* mode)
{
	FILE* fp = fopen(filename, mode);
	check_file(fp, filename);
	return fp;
}

void xfclose_(FILE** fp)
{
	if (fclose(*fp) != 0)
		die("Failed to close file\n");
	*fp = NULL;
}

void xfwrite(const void* ptr, size_t size, size_t count, FILE* stream)
{
	size_t num = fwrite(ptr, size, count, stream);
	if (num != count)
		die("Failed to write %u bytes to file\n", size * count);
}

void xfread(void* ptr, size_t size, size_t count, FILE* stream)
{
	size_t num = fread(ptr, size, count, stream);
	if (num != count)
		die("Failed to read %u bytes from file\n", size * count);
}

void xremove(const char* filename)
{
	if (file_exists(filename)) {
		if (0 != remove(filename)) {
			perror(filename);
			exit(EXIT_FAILURE);
		}
	}
}

//-----------------------------------------------------------------------------
// file checks
//-----------------------------------------------------------------------------
bool file_exists(const char* filename)
{
	struct stat sb;
	if ((stat(filename, &sb) == 0) && (sb.st_mode & S_IFREG))
		return true;
	else
		return false;
}

bool dir_exists(const char* dirname)
{
	struct stat sb;
	if ((stat(dirname, &sb) == 0) && (sb.st_mode & S_IFDIR))
		return true;
	else
		return false;
}

long file_size(const char* filename)
{
	struct stat sb;
	if ((stat(filename, &sb) == 0) && (sb.st_mode & S_IFREG))
		return sb.st_size;
	else
		return -1;
}

