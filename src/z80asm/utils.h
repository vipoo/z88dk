//-----------------------------------------------------------------------------
// z80asm assembler
// Utilities
// Copyright (C) Paulo Custodio, 2011-2019
// License: http://www.perlfoundation.org/artistic_license_2_0
// Repository: https://github.com/z88dk/z88dk
//-----------------------------------------------------------------------------
#pragma once

#include "utarray.h"
#include "utstring.h"

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

//---------- MACROS ----------//

// MIN, MAX, ABS, CLAMP
//#undef	MIN
#define MIN(a, b)  		(((a) < (b)) ? (a) : (b))

//#undef	MAX
#define MAX(a, b)  		(((a) > (b)) ? (a) : (b))

//#undef	ABS
#define ABS(a)	   		(((a) < 0) ? -(a) : (a))

//#undef	CLAMP
#define CLAMP(x, low, high)  \
						(((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

// number of elements of array
#define NUM_ELEMS(a)	((sizeof(a) / sizeof((a)[0])))

//---------- TYPES ----------//
typedef uint8_t byte_t;

//---------- FATAL ERRORS ----------//
void die(char* msg, ...);

//---------- STRING POOL ----------//
const char* str_pool_add(const char* str);
const char* str_pool_add_n(const char* str, size_t size);

//---------- MEMORY ALLOCATION ----------//

// check memory allocation
void* xmalloc(size_t size);
void* xcalloc(size_t num, size_t size);
void* xrealloc(void* ptr, size_t size);
char* xstrdup(const char* str);
char* xstrndup(const char* str, size_t size);

#define xnew(type)			((type*)xcalloc(1, sizeof(type)))
#define xfree(p)			(free(p), (p) = NULL)

//---------- CHECK SYSTEM CALLS ----------//

void xatexit(void(*func)(void));
void xsystem(const char* command);
void xremove(const char* filename);
void xmkdir(const char* dirname);
void xrmdir(const char* dirname);

//---------- CHECK FILE IO ----------//

FILE* xfopen(const char* filename, const char* mode);
void xfclose_(FILE** fp);
#define xfclose(fp)			xfclose_(&(fp))

// read/write bytes
void xfwrite(const void* ptr, size_t size, size_t count, FILE* fp);
void xfread(void* ptr, size_t size, size_t count, FILE* fp);

void xfwrite_bytes(const void* ptr, size_t size, FILE* fp);
void xfwrite_str(const char* str, FILE* fp);
void xfwrite_utstring(const UT_string* str, FILE* fp);

void xfread_bytes(void* ptr, size_t size, FILE* fp);
void xfread_utstring(UT_string* str, size_t size, FILE* fp);

// read/write integers
void xfwrite_int8(int value, FILE* fp);
void xfwrite_uint8(unsigned value, FILE* fp);

void xfwrite_int16(int value, FILE* fp);
void xfwrite_uint16(unsigned value, FILE* fp);

void xfwrite_int32(int value, FILE* fp);
void xfwrite_uint32(unsigned value, FILE* fp);

int xfread_int8(FILE* fp);
unsigned xfread_uint8(FILE* fp);

int xfread_int16(FILE* fp);
unsigned xfread_uint16(FILE* fp);

int xfread_int32(FILE* fp);
unsigned xfread_uint32(FILE* fp);

// read/write counted strings (8 or 16 bit length followed by string)
void xfwrite_count8str_bytes(const char* str, size_t size, FILE* fp);
void xfwrite_count16str_bytes(const char* str, size_t size, FILE* fp);

void xfwrite_count8str_str(const char* str, FILE* fp);
void xfwrite_count16str_str(const char* str, FILE* fp);

void xfwrite_count8str_utstring(const UT_string* str, FILE* fp);
void xfwrite_count16str_utstring(const UT_string* str, FILE* fp);

void xfread_count8str_utstring(UT_string* str, FILE* fp);
void xfread_count16str_utstring(UT_string* str, FILE* fp);

// seek/tell
long xftell(FILE* fp);
void xfseek(FILE* fp, long offset, int origin);

// hold the file nane and FILE* together
typedef struct {
    FILE*		file;		// open file handle
    const char* filename;	// file name, stored in string pool
} OpenFile;

//---------- READ/WRITE FILES ----------//

void file_spew_n(const char* filename, const void* ptr, size_t size);
void file_spew(const char* filename, const char* text);
void file_spew_utstring(const char* filename, const UT_string* str);

char* file_slurp_alloc(const char* filename);		// user must free pointer
void file_slurp_utstring(const char* filename, UT_string* str);

//---------- CREATE/REMOVE/SEARCH DIRECTORIES ----------//

// list files in directories, user must free UT_array
UT_array* path_find_all(const char* dirname, bool recursive);
UT_array* path_find_files(const char* dirname, bool recursive);

// find files, expand '*', '?' and '**' (recursive list of all subdirs)
UT_array* path_find_glob(const char* pattern);

// search for a file on the given directory list, return full path name in string pool
// return original file name if dir_list is NULL or file does not exist
const char* path_search(const char* filename, UT_array* dir_list);

// create/remve a directory and all parents above/children below it
void path_mkdir(const char* dirname);
void path_rmdir(const char* dirname);

//---------- PATHNAME MANIPULATION ----------//

// strings are allocated in str_pool

// change to forward slashes, remove extra slashes and dots
const char* path_canon(const char* path);

// same as path_canon but with back-slashes on windows and forward slashes everywhere else
const char* path_os(const char* path);

// combine two paths "a","b" -> "a/b"
const char* path_combine(const char* path1, const char* path2);

// extract path components
const char* path_dir(const char* path);
const char* path_file(const char* path);
const char* path_ext(const char* path);

// manipulate extension
const char* path_remove_ext(const char* path);
const char* path_replace_ext(const char* path, const char* new_ext);

//---------- CHECK FILESYSTEM ----------//

bool file_exists(const char* filename);
bool dir_exists(const char* dirname);
long file_size(const char* filename);		// -1 if not regular file

//---------- C-STRINGS ----------//

// convert alphanum character to a digit in base-36, return -1 if not alphanum
int char_digit(char c);

// convert string to upper/lower case; modify in place, return address of string
char* str_toupper(char* str);
char* str_tolower(char* str);

// remove blanks; modify in place, return address of string
char* str_chomp(char* str);					// remove from end
char* str_strip(char* str);					// remove from start and end

// convert C-escape sequences - modify in place, return final length
// to allow strings with '\0' characters
// accepts \b, \f, \n, \r, \t, \v, \xhh, \? \ooo
size_t str_compress_escapes(char* str);

// case insensitive compare
int str_case_cmp(const char* s1, const char* s2);
int str_case_n_cmp(const char* s1, const char* s2, size_t n);

//---------- UT-STRINGS ----------//

UT_string* utstring_alloc(void);			// utstring_new() as function
void utstring_set(UT_string* str, const char* src);
void utstring_set_printf(UT_string* str, const char* fmt, ...);

void utstring_toupper(UT_string* str);
void utstring_tolower(UT_string* str);
void utstring_chomp(UT_string* str);
void utstring_strip(UT_string* str);
void utstring_compress_escapes(UT_string* str);

//---------- UT-ARRAYS ----------//

UT_array* utarray_alloc(const UT_icd* icd);				// utarray_new() as function
void* utarray_safe_eltptr(UT_array* arr, size_t idx);	// expand if needed

// UT_arrays of strdup'ed strings
UT_array* utarray_str_alloc(void);			// utarray_new(strs,&ut_str_icd) as function
void utarray_str_push_back(UT_array* arr, const char* str);

void utarray_str_sort(UT_array* arr);		// sort an array of strings
