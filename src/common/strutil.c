//-----------------------------------------------------------------------------
// String Utilities - based on UT_string
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "strutil.h"
#include "die.h"
#include "uthash.h"
#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdlib.h>

//-----------------------------------------------------------------------------
// C-strings
//-----------------------------------------------------------------------------
char* cstr_toupper(char* str)
{
    for (char* p = str; *p; p++)
        *p = toupper(*p);

    return str;
}

char* cstr_tolower(char* str)
{
    for (char* p = str; *p; p++)
        *p = tolower(*p);

    return str;
}

char* cstr_chomp(char* str)
{
    for (char* p = str + strlen(str) - 1; p >= str && isspace(*p); p--)
        *p = '\0';

    return str;
}

char* cstr_strip(char* str)
{
    char* p;

    for (p = str; *p != '\0' && isspace(*p); p++) {}// skip begining spaces

    memmove(str, p, strlen(p) + 1);                 // move also '\0'
    return cstr_chomp(str);                         // remove ending spaces
}

static int char_digit(char c)
{
    if (isdigit(c))
        return c - '0';

    if (isxdigit(c))
        return 10 + toupper(c) - 'A';

    return -1;
}

/* convert C-escape sequences - modify in place, return final length
to allow strings with '\0' characters
Accepts \a, \b, \e, \f, \n, \r, \t, \v, \xhh, \{any} \ooo
code borrowed from GLib */
int cstr_compress_escapes(char* str)
{
    char* p = NULL, *q = NULL, *num = NULL;
    int base = 0, max_digits, digit;

    for (p = q = str; *p; p++) {
        if (*p == '\\') {
            p++;
            base = 0;                           /* decision octal/hex */

            switch (*p) {
            case '\0':
                p--;
                break;             /* trailing backslash - ignore */

            case 'a':
                *q++ = '\a';
                break;

            case 'b':
                *q++ = '\b';
                break;

            case 'e':
                *q++ = '\x1B';
                break;

            case 'f':
                *q++ = '\f';
                break;

            case 'n':
                *q++ = '\n';
                break;

            case 'r':
                *q++ = '\r';
                break;

            case 't':
                *q++ = '\t';
                break;

            case 'v':
                *q++ = '\v';
                break;

            case '0':
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
                num = p;                /* start of number */
                base = 8;
                max_digits = 3;

            /* fall through */
            case 'x':
                if (base == 0) {    /* not octal */
                    num = ++p;
                    base = 16;
                    max_digits = 2;
                }

                /* convert octal or hex number */
                *q = 0;

                while (p < num + max_digits &&
                       (digit = char_digit(*p)) >= 0 &&
                       digit < base) {
                    *q = *q * base + digit;
                    p++;
                }

                p--;
                q++;
                break;

            default:
                *q++ = *p;      /* any other char */
            }
        }
        else
            *q++ = *p;
    }

    *q = '\0';

    return q - str;
}

int cstr_case_cmp(const char* s1, const char* s2)
{
    if (s1 == s2)
        return 0;

    if (s1 == NULL)
        return -1;

    if (s2 == NULL)
        return 1;

    while (*s2 != '\0' && tolower(*s1) == tolower(*s2)) {
        s1++;
        s2++;
    }

    return (int)(tolower(*s1) - tolower(*s2));
}

int cstr_case_ncmp(const char* s1, const char* s2, size_t n)
{
    char c1, c2;

    if (s1 == s2)
        return 0;

    if (s1 == NULL)
        return -1;

    if (s2 == NULL)
        return 1;

    if (n == 0)
        return 0;

    do {
        c1 = tolower(*s1++);
        c2 = tolower(*s2++);
        n--;
    }
    while ((c1 != '\0') && (c1 == c2) && (n > 0));

    return (int)(c1 - c2);
}


//-----------------------------------------------------------------------------
// string str_t
//-----------------------------------------------------------------------------
str_t* str_new()
{
    str_t* str;
    utstring_new(str);
    return str;
}

str_t* str_new_copy(const char* src)
{
    str_t* str = str_new();
    str_set(str, src);
    return str;
}

void str_free(str_t* str)
{
    utstring_free(str);
}

void str_clear(str_t* str)
{
    utstring_clear(str);
}

// utstring_reserve(x) allocates 100+x; rewrite
void str_reserve(str_t* str, size_t amt)
{
    size_t new_size = str->i + amt + 1;

    if (new_size > str->n) {
        str->d = xrealloc(str->d, new_size);
        str->n = new_size;
    }

    str->d[str->n - 1] = '\0';
}

void str_set(str_t* str, const char* src)
{
    utstring_clear(str);
    utstring_bincpy(str, src, strlen(src));
}

void str_set_f(str_t* str, const char* fmt, ...)
{
    utstring_clear(str);
    va_list ap;
    va_start(ap, fmt);
    utstring_printf_va(str, fmt, ap);
    va_end(ap);
}

void str_set_n(str_t* str, const char* data, size_t len)
{
    utstring_clear(str);
    utstring_bincpy(str, data, len);
}

void str_set_str(str_t* str, str_t* src)
{
    utstring_clear(str);
    utstring_concat(str, src);
}

void str_append(str_t* str, const char* src)
{
    utstring_bincpy(str, src, strlen(src));
}

void str_append_f(str_t* str, const char* fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    utstring_printf_va(str, fmt, ap);
    va_end(ap);
}

void str_append_n(str_t* str, const char* data, size_t len)
{
    utstring_bincpy(str, data, len);
}

void str_append_str(str_t* str, str_t* src)
{
    utstring_concat(str, src);
}

char* str_getline(str_t* str, FILE* stream)
{
    int c;

    str_clear(str);

    while ((c = getc(stream)) != EOF) {
        if (c == '\r') {
            c = getc(stream);

            if (c != '\n')
                ungetc(c, stream);

            str_append(str, "\n");
            break;
        }
        else if (c == '\n') {
            str_append(str, "\n");
            break;
        }
        else {
            char c1 = c;
            str_append_n(str, &c1, 1);
        }
    }

    if (str_len(str))
        return str_data(str);
    else
        return NULL;
}

void str_apply(str_t* str, char* (*f)(char*))
{
    f(str_data(str));
    str_sync_len(str);
}

//-----------------------------------------------------------------------------
// string array
//-----------------------------------------------------------------------------

static void argv_add_end_marker(argv_t* argv)
{
    utarray_reserve(argv, 1);
    *(char**)_utarray_eltptr(argv, argv_len(argv)) = NULL;
}

argv_t* argv_new()
{
    argv_t* argv;
    utarray_new(argv, &ut_str_icd);
    argv_add_end_marker(argv);

    return argv;
}

void argv_free(argv_t* argv)
{
    utarray_free(argv);
}

void argv_clear(argv_t* argv)
{
    utarray_clear(argv);
    argv_add_end_marker(argv);
}

void argv_push(argv_t* argv, const char* str)
{
    utarray_push_back(argv, &str);
    argv_add_end_marker(argv);
}

void argv_pop(argv_t* argv)
{
    if (utarray_len(argv) > 0)
        utarray_pop_back(argv);

    argv_add_end_marker(argv);
}

void argv_shift(argv_t* argv)
{
    if (utarray_len(argv) > 0)
        utarray_erase(argv, 0, 1);

    argv_add_end_marker(argv);
}

void argv_unshift(argv_t* argv, const char* str)
{
    utarray_insert(argv, &str, 0);
    argv_add_end_marker(argv);
}

void argv_insert(argv_t* argv, size_t idx, const char* str)
{
    if (idx < argv_len(argv))
        utarray_insert(argv, &str, idx);
    else
        argv_set(argv, idx, str);

    argv_add_end_marker(argv);
}

void argv_erase(argv_t* argv, size_t pos, size_t len)
{
    if (pos + len > utarray_len(argv))
        len = utarray_len(argv) - pos;

    if (pos < utarray_len(argv))
        utarray_erase(argv, pos, len);

    argv_add_end_marker(argv);
}

static int argv_cmp(const void* a, const void* b)
{
    const char* _a = *(const char**)a;
    const char* _b = *(const char**)b;
    return strcmp(_a, _b);
}

void argv_sort(argv_t* argv)
{
    utarray_sort(argv, argv_cmp);
}

char* argv_get(argv_t* argv, size_t idx)
{
    char** elt = argv_eltptr(argv, idx);

    if (elt)
        return *elt;
    else
        return NULL;
}

void argv_set(argv_t* argv, size_t idx, const char* str)
{
    // expand array if needed
    size_t curlen = utarray_len(argv);
    size_t newlen = idx + 1;

    if (newlen > curlen) {
        utarray_reserve(argv, newlen + 1 - curlen);     // +1 for end marker
        memset(_utarray_eltptr(argv, curlen),
               0,
               _utarray_eltptr(argv, newlen) - _utarray_eltptr(argv, curlen));
        utarray_len(argv) = newlen;
    }

    // free old element and set new one
    char** elt = argv_eltptr(argv, idx);
    xassert(elt);
    xfree(*elt);
    *elt = xstrdup(str);
    argv_add_end_marker(argv);
}

//-----------------------------------------------------------------------------
// string pool
//-----------------------------------------------------------------------------
typedef struct spool_s {
    char* str;
    UT_hash_handle hh;
} spool_t;

static spool_t* spool = NULL;

static void spool_deinit(void);

static void spool_init()
{
    static bool inited = false;

    if (!inited) {
        inited = true;
        atexit(spool_deinit);
    }
}

static void spool_deinit(void)
{
    spool_t* elem, *tmp;
    HASH_ITER(hh, spool, elem, tmp) {
        HASH_DEL(spool, elem);
        xfree(elem);
    }
}

const char* spool_add(const char* str)
{
    spool_init();

    if (str == NULL)
        return NULL;       // special case

    spool_t* found;
    HASH_FIND_STR(spool, str, found);

    if (found)
        return found->str;       // found

    found = xnew(spool_t);
    found->str = xstrdup(str);

    HASH_ADD_STR(spool, str, found);

    return found->str;
}

//-----------------------------------------------------------------------------
// map: set of strings mapped to int, or char* or void*
//-----------------------------------------------------------------------------
map_t * map_new()
{
	map_t* map = xnew(map_t);
	map->key = str_new();
	return map;
}

map_t * map_new_icase()
{
	map_t* map = map_new();
	map->icase = true;
	return map;
}

map_t * map_new_xt(bool icase, void(*free_ptr)(void *))
{
	map_t* map = map_new();
	map->icase = icase;
	map->free_ptr = free_ptr;
	return map;
}

void map_free(map_t * map)
{
	map_remove_all(map);
	str_free(map->key);
	xfree(map);
}

static void map_norm_key(map_t * map, const char* key)
{
	str_set(map->key, key);
	if (map->icase) {
		str_toupper(map->key);
	}
}

void map_set(map_t * map, const char * key)
{
	map_set_num(map, key, 1);
}

static map_elem_t* map_set_x(map_t * map, const char * key, void(*free_ptr)(void*))
{
	map_elem_t* elem = map_get_elem(map, key);
	if (!elem) {		// add element
		elem = xnew(map_elem_t);
		map_norm_key(map, key);
		elem->key = spool_add(str_data(map->key));	// need invariant key
		HASH_ADD_KEYPTR(hh, map->elems, elem->key, str_len(map->key), elem);
		map->count++;
	}
	else {				// free old element
		if (free_ptr)
			free_ptr(elem->ptr);
	}
	return elem;
}

void map_set_num(map_t * map, const char * key, int num)
{
	map_elem_t* elem = map_set_x(map, key, NULL);
	elem->num = num;	// update/set value
}

void map_set_ptr(map_t * map, const char * key, void * ptr)
{
	map_elem_t* elem = map_set_x(map, key, map->free_ptr);
	elem->ptr = ptr;	// update/set value
}

void map_remove_elem(map_t * map, map_elem_t * elem)
{
	if (!elem)
		return;

	HASH_DEL(map->elems, elem);
	map->count--;

	if (map->free_ptr)
		map->free_ptr(elem->ptr);

	xfree(elem);
}

void map_remove(map_t * map, const char * key)
{
	map_elem_t* elem = map_get_elem(map, key);
	map_remove_elem(map, elem);
}

void map_remove_all(map_t * map)
{
	map_elem_t * elem, *tmp;
	HASH_ITER(hh, map->elems , elem, tmp) {
		map_remove_elem(map, elem);
	}
}

bool map_exists(map_t * map, const char * key)
{
	map_elem_t* elem = map_get_elem(map, key);
	if (elem)
		return true;
	else
		return false;
}

map_elem_t * map_get_elem(map_t * map, const char * key)
{
	map_elem_t* elem;
	map_norm_key(map, key);
	HASH_FIND(hh, map->elems, str_data(map->key), str_len(map->key), elem);
	return elem;
}

int map_get_num(map_t * map, const char * key)
{
	map_elem_t* elem = map_get_elem(map, key);
	if (!elem)
		return 0;
	else
		return elem->num;
}

void * map_get_ptr(map_t * map, const char * key)
{
	map_elem_t* elem = map_get_elem(map, key);
	if (!elem)
		return NULL;
	else
		return elem->ptr;
}

map_elem_t * map_first(map_t * map)
{
	return map->elems;
}

map_elem_t * map_next(map_elem_t * iter)
{
	if (!iter)
		return NULL;
	else
		return iter->hh.next;
}

void map_sort(map_t * map, map_compare_func compare)
{
	HASH_SORT(map->elems, compare);
}
