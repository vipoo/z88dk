//-----------------------------------------------------------------------------
// String Utilities - based on UT_string
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#pragma once

#include "utarray.h"
#include "uthash.h"
#include "utstring.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

//-----------------------------------------------------------------------------
// C-strings
//-----------------------------------------------------------------------------

// convert string to upper / lower case -modify in place,
// return address of string
char* cstr_toupper(char* str);
char* cstr_tolower(char* str);

// remove end newline and whitespace - modify in place, return address of string
char* cstr_chomp(char* str);

// remove begin and end whitespace - modify in place, return address of string
char* cstr_strip(char* str);

// convert C-escape sequences - modify in place, return final length
// to allow strings with '\0' characters
// accepts \b, \f, \n, \r, \t, \v, \xhh, \? \ooo
int cstr_compress_escapes(char* str);

// case insensitive compare
int cstr_case_cmp(const char* s1, const char* s2);
int cstr_case_ncmp(const char* s1, const char* s2, size_t n);

//-----------------------------------------------------------------------------
// str_t: alias to UT_string
//-----------------------------------------------------------------------------
typedef UT_string str_t;

#define str_data(x)     utstring_body(x)
#define str_len(x)      utstring_len(x)
#define str_sync_len(x) (str_len(x) = strlen(str_data(x)))

str_t* str_new();
str_t* str_new_copy(const char* src);
void str_free(str_t* str);

void str_clear(str_t* str);

void str_reserve(str_t* str, size_t amt);

void str_set(str_t* str, const char* src);
void str_set_f(str_t* str, const char* fmt, ...);
void str_set_n(str_t* str, const char* data, size_t len);
void str_set_str(str_t* str, str_t* src);

void str_append(str_t* str, const char* src);
void str_append_f(str_t* str, const char* fmt, ...);
void str_append_n(str_t* str, const char* data, size_t len);
void str_append_str(str_t* str, str_t* src);

// get a line from stream, handle CR, CR-LF, and LF line ends, replace with LF
// return pointer to str_data, or NULL if no more input
char* str_getline(str_t* str, FILE* stream);

// apply a cstr function to the body of an str
void str_apply(str_t* str, char* (*f)(char*));

#define str_toupper(s)          str_apply((s), cstr_toupper)
#define str_tolower(s)          str_apply((s), cstr_tolower)
#define str_chomp(s)            str_apply((s), cstr_chomp)
#define str_strip(s)            str_apply((s), cstr_strip)
#define str_compress_escapes(s) str_apply((s), (char *(*)(char*))cstr_compress_escapes)

//-----------------------------------------------------------------------------
// argv_t: alias to UT_array of strings
//-----------------------------------------------------------------------------
typedef UT_array argv_t;

#define argv_eltptr(x, i)   ((char**)utarray_eltptr((x), (i)))      // returns NULL if out ot range
#define argv_front(x)       ((char**)_utarray_eltptr((x), 0))
#define argv_back(x)        ((char**)_utarray_eltptr((x), utarray_len(x)))
#define argv_len(x)         utarray_len(x)

argv_t* argv_new();
void argv_free(argv_t* argv);
void argv_clear(argv_t* argv);

void argv_push(argv_t* argv, const char* str);
void argv_pop(argv_t* argv);
void argv_shift(argv_t* argv);
void argv_unshift(argv_t* argv, const char* str);
void argv_insert(argv_t* argv, size_t idx, const char* str);
void argv_erase(argv_t* argv, size_t pos, size_t len);

void argv_sort(argv_t* argv);

// get element by index, NULL if outside range
char* argv_get(argv_t* argv, size_t idx);

// set element at idx
// grows array if needed to make index valid, fills empty values with NULL
void argv_set(argv_t* argv, size_t idx, const char* str);

//-----------------------------------------------------------------------------
// map: set of strings mapped to int, or char* or void*
//-----------------------------------------------------------------------------
typedef struct map_elem_t {
	const char* key;
	union {
		int num;
		void *ptr;
	};
	UT_hash_handle hh;
} map_elem_t;

typedef struct map_t {
	map_elem_t* elems;
	size_t count;			// number of elements
	bool icase;				// if true, keys are case insensitive
	str_t* key;				// normalized key
	void(*free_ptr)(void*);	// if not NULL, used to free void* ptr when element is removed
} map_t;

// compare function used by sort
typedef int(*map_compare_func)(map_elem_t* a, map_elem_t* b);

map_t* map_new();
map_t* map_new_icase();
map_t* map_new_xt(bool icase, void(*free_ptr)(void*));

void map_free(map_t* map);

// add or replace item in map
void map_set(map_t* map, const char* key);
void map_set_num(map_t* map, const char* key, int num);
void map_set_ptr(map_t* map, const char* key, void* ptr);

// delete item in map
void map_remove_elem(map_t* map, map_elem_t* elem);
void map_remove(map_t* map, const char* key);
void map_remove_all(map_t* map);

// check if key exists
bool map_exists(map_t* map, const char* key);

// return value, 0 or NULL if key not in map
map_elem_t* map_get_elem(map_t* map, const char* key);
int         map_get_num(map_t* map, const char* key);
void*       map_get_ptr(map_t* map, const char* key);

// iterate through map, return NULL at end of search
map_elem_t* map_first(map_t* map);
map_elem_t* map_next(map_elem_t* iter);

// sort the items in the map
void map_sort(map_t* map, map_compare_func compare);

//-----------------------------------------------------------------------------
// string pool
//-----------------------------------------------------------------------------
const char* spool_add(const char* str);
