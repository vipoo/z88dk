//-----------------------------------------------------------------------------
// z80asm assembler
// Utilities
// Copyright (C) Paulo Custodio, 2011-2019
// License: http://www.perlfoundation.org/artistic_license_2_0
// Repository: https://github.com/z88dk/z88dk
//-----------------------------------------------------------------------------

#include "utils.h"

#include "utarray.h"
#include "uthash.h"

#include <assert.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <string.h>
#include <sys/stat.h>

#ifdef _WIN32
#include <direct.h>
#include <unixem/glob.h>
#endif

#include <glob.h>
#include <dirent.h>

#define isslash(x)	((x) == '/' || (x) == '\\')

//---------- LOCAL TYPES ----------//

// string pool
typedef struct {
    char* str;
    UT_hash_handle hh;
} StrPool;

//---------- STATIC DATA ----------//

// string pool
static StrPool* g_str_pool = NULL;

// file names of files opened by xfopen
static UT_array* g_open_files = NULL;
static UT_icd g_str_pool_strings_icd = { sizeof(const char*), NULL, NULL, NULL };

//---------- INIT ----------//

static void str_pool_fini(void);
static void open_files_init(void);
static void open_files_fini(void);

static void fini(void) {
    str_pool_fini();
    open_files_fini();
}

static void init(void) {
    static bool inited = false;
    if (!inited) {
        inited = true;

        open_files_init();

        xatexit(fini);
    }
}

//---------- STRING POOL ----------//

static void str_pool_fini(void) {
    StrPool* elem, * tmp;
    HASH_ITER(hh, g_str_pool, elem, tmp) {
        HASH_DEL(g_str_pool, elem);
        xfree(elem->str);
        xfree(elem);
    }
}

const char* str_pool_add(const char* str) {
    init();

    if (str == NULL) return NULL;		// special case

    StrPool* found;
    HASH_FIND_STR(g_str_pool, str, found);
    if (found) return found->str;		// found

    found = xnew(StrPool);
    found->str = xstrdup(str);

    HASH_ADD_STR(g_str_pool, str, found);

    return found->str;
}

const char* str_pool_add_n(const char* str, size_t size) {
    init();

    char* temp_copy = xstrndup(str, size);
    const char* ret = str_pool_add(temp_copy);
    xfree(temp_copy);
    return ret;
}

//---------- MEMORY ALLOCATION ----------//

void die(char* msg, ...) {
    va_list argptr;

    va_start(argptr, msg);
    vfprintf(stderr, msg, argptr);
    fprintf(stderr, "\n");
    va_end(argptr);

    exit(EXIT_FAILURE);
}

static void check_mem(void* p) {
    if (!p)
        die("Out of memory");
}

void* xmalloc(size_t size) {
    void* ptr = malloc(size);
    check_mem(ptr);
    return ptr;
}

void* xcalloc(size_t num, size_t size) {
    void* ptr = calloc(num, size);
    check_mem(ptr);
    return ptr;
}

void* xrealloc(void* ptr, size_t size) {
    void* new_ptr = realloc(ptr, size);
    check_mem(new_ptr);
    return new_ptr;

}

char* xstrdup(const char* str) {
    char* ptr = strdup(str);
    check_mem(ptr);
    return ptr;
}

char* xstrndup(const char* str, size_t size) {
    char* ptr = xmalloc(size + 1);
    strncpy(ptr, str, size);
    ptr[size] = '\0';
    return ptr;
}

//---------- CHECK SYSTEM CALLS ----------//

void xatexit(void(*func)(void)) {
    if (atexit(func) != 0)
        die("atexit failed");
}

void xsystem(const char* command) {
    if (system(command) != 0)
        die("Command '%s' failed", command);
}

void xremove(const char* filename) {
    if (file_exists(filename)) {
        if (0 != remove(filename)) {
            perror(filename);
            exit(EXIT_FAILURE);
        }
    }
}

void xmkdir(const char* dirname) {
    if (dir_exists(dirname))
        return;

#ifdef _WIN32
    int rv = _mkdir(dirname);
#else
    int rv = mkdir(dirname, 0777);
#endif

    if (rv != 0) {
        perror(dirname);
        exit(EXIT_FAILURE);
    }
}

void xrmdir(const char* dirname) {
    if (!dir_exists(dirname))
        return;

#ifdef _WIN32
    int rv = _rmdir(dirname);
#else
    int rv = rmdir(dirname);
#endif

    if (rv != 0) {
        perror(dirname);
        exit(EXIT_FAILURE);
    }
}

//---------- CHECK FILE IO ----------//

// maintain list of filenames by fileno; file names stored in str_pool
static void add_open_file(FILE* fp, const char* filename) {
    if (fp) {
        int file_no = fileno(fp);
        assert(file_no >= 0);
        const char** elem =
            (const char**)utarray_safe_eltptr(g_open_files, (size_t)file_no);
        assert(elem);
        *elem = str_pool_add(filename);
    }
}

static const char* open_filename(FILE* fp) {
    if (!fp)
        return "?";
    else {
        // elem may be null if fileno was not opened by xfopen()
        const char** elem = (const char**)utarray_eltptr(g_open_files, (size_t)fileno(fp));
        return elem ? *elem : "?";
    }
}

static void open_files_init(void) {
    utarray_new(g_open_files, &g_str_pool_strings_icd);
    add_open_file(stdin, "<stdin>");
    add_open_file(stdout, "<stdout>");
    add_open_file(stderr, "<stderr>");
}

static void open_files_fini(void) {
    utarray_free(g_open_files);
}

FILE* xfopen(const char* filename, const char* mode) {
    init();

    FILE* fp = fopen(filename, mode);
    if (fp)
        add_open_file(fp, filename);
    else {
        perror(filename);
        exit(EXIT_FAILURE);
    }
    return fp;
}

void xfclose_(FILE** fp) {
    init();

    if (fclose(*fp) != 0)
        die("Failed to close '%s'", open_filename(*fp));
    *fp = NULL;
}

void xfwrite(const void* ptr, size_t size, size_t count, FILE* fp) {
    init();

    size_t num = fwrite(ptr, size, count, fp);
    if (num != count)
        die("Failed to write %u bytes to '%s'", size * count, open_filename(fp));
}

void xfread(void* ptr, size_t size, size_t count, FILE* fp) {
    init();

    size_t num = fread(ptr, size, count, fp);
    if (num != count)
        die("Failed to read %u bytes from '%s'", size * count, open_filename(fp));
}

void xfwrite_bytes(const void* ptr, size_t size, FILE* fp) {
    xfwrite(ptr, sizeof(char), size, fp);
}

void xfwrite_str(const char* str, FILE* fp) {
    xfwrite(str, sizeof(char), strlen(str), fp);
}

void xfwrite_utstring(const UT_string* str, FILE* fp) {
    xfwrite(utstring_body(str), sizeof(char), utstring_len(str), fp);
}

void xfread_bytes(void* ptr, size_t size, FILE* fp) {
    xfread(ptr, sizeof(byte_t), size, fp);
}

void xfread_utstring(UT_string* str, size_t size, FILE* fp) {
    utstring_clear(str);
    utstring_reserve(str, size);
    xfread_bytes(utstring_body(str), size, fp);
    utstring_len(str) = size;
    utstring_body(str)[size] = '\0';
}

void xfwrite_int8(int value, FILE* fp) {
    xfwrite_uint8((unsigned)value, fp);
}

void xfwrite_uint8(unsigned value, FILE* fp) {
    byte_t byte = value & 0xFF;
    xfwrite_bytes(&byte, 1, fp);
}

void xfwrite_int16(int value, FILE* fp) {
    xfwrite_uint16((unsigned)value, fp);
}

void xfwrite_uint16(unsigned value, FILE* fp) {
    byte_t word[2];
    word[0] = value & 0xFF; value >>= 8;
    word[1] = value & 0xFF; value >>= 8;
    xfwrite_bytes(word, sizeof(word), fp);
}

void xfwrite_int32(int value, FILE* fp) {
    xfwrite_uint32((unsigned)value, fp);
}

void xfwrite_uint32(unsigned value, FILE* fp) {
    byte_t dword[4];
    dword[0] = value & 0xFF; value >>= 8;
    dword[1] = value & 0xFF; value >>= 8;
    dword[2] = value & 0xFF; value >>= 8;
    dword[3] = value & 0xFF; value >>= 8;
    xfwrite_bytes(dword, sizeof(dword), fp);
}

int xfread_int8(FILE* fp) {
    int value = xfread_uint8(fp);
    if (value & 0x80)
        value |= ~0xFF;				// sign-extend above bit 7
    return value;
}

unsigned xfread_uint8(FILE* fp) {
    byte_t value;
    xfread_bytes(&value, 1, fp);
    return value;
}

int xfread_int16(FILE* fp) {
    int value = xfread_uint16(fp);
    if (value & 0x8000)
        value |= ~0xFFFF;			// sign-extend above bit 15
    return value;
}

unsigned xfread_uint16(FILE* fp) {
    byte_t word[2];
    xfread_bytes(word, sizeof(word), fp);
    unsigned value =
        ((word[0] << 0) & 0x00FF) |
        ((word[1] << 8) & 0xFF00);
    return value;
}

int xfread_int32(FILE* fp) {
    int value = xfread_uint32(fp);
    if (value & 0x80000000L)
        value |= ~0xFFFFFFFFL;		// sign-extend above bit 31
    return value;
}

unsigned xfread_uint32(FILE* fp) {
    byte_t dword[4];
    xfread_bytes(dword, sizeof(dword), fp);
    unsigned value =
        ((dword[0] << 0) & 0x000000FFL) |
        ((dword[1] << 8) & 0x0000FF00L) |
        ((dword[2] << 16) & 0x00FF0000L) |
        ((dword[3] << 24) & 0xFF000000L);
    return value;
}

void xfwrite_count8str_bytes(const char* str, size_t size, FILE* fp) {
    if (size > 255)
        die("String '%.40s...' too long for 8-bit counted string", str);
    xfwrite_uint8(size & 0xFF, fp);
    xfwrite_bytes(str, size, fp);
}

void xfwrite_count16str_bytes(const char* str, size_t size, FILE* fp) {
    if (size > 0xFFFF)
        die("String '%.40s...' too long for 16-bit counted string", str);
    xfwrite_uint16(size, fp);
    xfwrite_bytes(str, size, fp);
}

void xfwrite_count8str_str(const char* str, FILE* fp) {
    xfwrite_count8str_bytes(str, strlen(str), fp);
}

void xfwrite_count16str_str(const char* str, FILE* fp) {
    xfwrite_count16str_bytes(str, strlen(str), fp);
}

void xfwrite_count8str_utstring(const UT_string* str, FILE* fp) {
    xfwrite_count8str_bytes(utstring_body(str), utstring_len(str), fp);
}

void xfwrite_count16str_utstring(const UT_string* str, FILE* fp) {
    xfwrite_count16str_bytes(utstring_body(str), utstring_len(str), fp);
}

void xfread_count8str_utstring(UT_string* str, FILE* fp) {
    size_t size = xfread_uint8(fp);
    xfread_utstring(str, size, fp);
}

void xfread_count16str_utstring(UT_string* str, FILE* fp) {
    size_t size = xfread_uint16(fp);
    xfread_utstring(str, size, fp);
}

long xftell(FILE* fp) {
    long ret = ftell(fp);
    if (ret < 0)
        die("ftell in '%s' failed", open_filename(fp));
    return ret;
}

void xfseek(FILE* fp, long offset, int origin) {
    if (fseek(fp, offset, origin) != 0)
        die("Failed to seek to %ld in '%s'", offset, open_filename(fp));
}

//---------- READ/WRITE FILES ----------//

void file_spew_n(const char* filename, const void* ptr, size_t size) {
    FILE* fp = xfopen(filename, "wb");
    xfwrite_bytes(ptr, size, fp);
    xfclose(fp);
}

void file_spew(const char* filename, const char* text) {
    file_spew_n(filename, text, strlen(text));
}

void file_spew_utstring(const char* filename, const UT_string* str) {
    file_spew_n(filename, utstring_body(str), utstring_len(str));
}

static void file_slurp_(const char* filename, char** ret_text, size_t* ret_size) {
    FILE* fp = xfopen(filename, "rb");

    xfseek(fp, 0, SEEK_END);
    long size = xftell(fp);
    xfseek(fp, 0, SEEK_SET);

    char* text = xmalloc(size + 1);

    xfread_bytes(text, size, fp);
    text[size] = '\0';

    xfclose(fp);

    // return data
    *ret_text = text;		// user must free
    *ret_size = size;
}

char* file_slurp_alloc(const char* filename) {
    char* text;
    size_t size;
    file_slurp_(filename, &text, &size);
    return text;		// user must free
}

void file_slurp_utstring(const char* filename, UT_string* str) {
    char* text;
    size_t size;
    file_slurp_(filename, &text, &size);

    utstring_clear(str);
    utstring_reserve(str, size + 1);
    memcpy(utstring_body(str), text, size + 1);		// copy null char
    utstring_len(str) = size;
    xfree(text);
}

//---------- CREATE/REMOVE/SEARCH DIRECTORIES ----------//

static int xglob(const char* pattern, int flags,
                 int(*errfunc)(const char* epath, int eerrno), glob_t* pglob) {
    int ret = glob(pattern, flags, errfunc, pglob);
    if (ret != GLOB_NOMATCH && ret != 0)
        die("glob pattern '%s': %s",
            pattern,
            (ret == GLOB_ABORTED ? "filesystem problem" :
             ret == GLOB_NOSPACE ? "no dynamic memory" :
             "unknown problem"));
    return ret;
}

static void find_files_1(UT_array* dirs, const char* dirname,
                         bool recursive, bool find_dirs) {
    DIR* dir = opendir(dirname);
    if (!dir) {
        perror(dirname);
        exit(EXIT_FAILURE);
    }

    struct dirent* entry;
    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0)
            continue;

        const char* name = path_combine(dirname, entry->d_name);
        if (dir_exists(name)) {
            if (find_dirs)
                utarray_str_push_back(dirs, name);
            if (recursive)
                find_files_1(dirs, name, recursive, find_dirs);
        }
        else if (file_exists(name))
            utarray_str_push_back(dirs, name);
    }

    if (closedir(dir)) {
        perror(dirname);
        exit(EXIT_FAILURE);
    }
}

UT_array* path_find_all(const char* dirname, bool recursive) {
    UT_array* dirs = utarray_str_alloc();
    find_files_1(dirs, dirname, recursive, true);
    return dirs;
}

UT_array* path_find_files(const char* dirname, bool recursive) {
    UT_array* dirs = utarray_str_alloc();
    find_files_1(dirs, dirname, recursive, false);
    return dirs;
}

static void path_find_glob_1(UT_array* files, const char* pattern) {
    UT_string* pad = utstring_alloc();

    pattern = path_canon(pattern);					// so we can search for '/'
    const char* wildcard = strpbrk(pattern, "*?");
    if (!wildcard) {								// no wildcard
        if (file_exists(pattern))
            utarray_str_push_back(files, pattern);
    }
    else if (strncmp(wildcard, "**", 2) == 0) {		// '**' - recursively find all subdirs
        char* child = strchr(wildcard, '/');		// point to '/' after '**'

        if (child) {								// try without star-star
            // copy all before '**' plus subdirs
            utstring_clear(pad);
            utstring_bincpy(pad, pattern, wildcard - pattern);
            utstring_printf(pad, "%s", child);

            path_find_glob_1(files, utstring_body(pad));	// recurse
        }

        // copy up to first star ...
        utstring_clear(pad);
        utstring_bincpy(pad, pattern, wildcard - pattern + 1);

        if (child)
            // ... and after second star up to child
            utstring_bincpy(pad, wildcard + 2, child - (wildcard + 2));
        else
            // ... and after second star
            utstring_printf(pad, "%s", wildcard + 2);

        // expand the pattern
        glob_t glob_files;
        int ret = xglob(utstring_body(pad), GLOB_NOESCAPE, NULL, &glob_files);
        if (ret == GLOB_NOMATCH) 				// no match - ignore
            ;
        else if (ret == 0) {
            for (int i = 0; i < glob_files.gl_pathc; i++) {
                char* found = glob_files.gl_pathv[i];
                if (dir_exists(found)) {
                    // is a directory
                    utstring_clear(pad);
                    utstring_printf(pad, "%s/**", found);
                    if (child)
                        utstring_printf(pad, "%s", child);

                    path_find_glob_1(files, utstring_body(pad));	// recurse
                }
                else {
                    // is a file
                    utstring_clear(pad);
                    utstring_printf(pad, "%s", found);
                    if (child)
                        utstring_printf(pad, "%s", child);

                    path_find_glob_1(files, utstring_body(pad));	// recurse
                }
            }
        }
        else
            assert(0);
        globfree(&glob_files);
    }
    else {											// find one level of subdirs
        char* child = strchr(wildcard, '/');		// point to slash wild card

        utstring_clear(pad);
        if (child)
            // copy up to '/'
            utstring_bincpy(pad, pattern, child - pattern);
        else
            // copy all
            utstring_printf(pad, "%s", pattern);

        glob_t glob_files;
        int ret = xglob(utstring_body(pad), GLOB_NOESCAPE, NULL, &glob_files);
        if (ret == GLOB_NOMATCH) 				// no match - ignore
            ;
        else if (ret == 0) {
            for (int i = 0; i < glob_files.gl_pathc; i++) {
                char* found = glob_files.gl_pathv[i];

                utstring_clear(pad);
                utstring_printf(pad, "%s", found);
                if (child)
                    utstring_printf(pad, "%s", child);

                path_find_glob_1(files, utstring_body(pad));	// recurse
            }
        }
        else
            assert(0);
        globfree(&glob_files);
    }

    utstring_free(pad);
}

UT_array* path_find_glob(const char* pattern) {
    UT_array* files = utarray_str_alloc();
    path_find_glob_1(files, pattern);
    return files;
}

const char* path_search(const char* filename, UT_array* dir_list) {
    // if no directory list or file exists, return filename
    if (!dir_list || utarray_len(dir_list) == 0 || file_exists(filename))
        return path_canon(filename);

    // search in dir list
    char** p = NULL;
    while ((p = (char**)utarray_next(dir_list, p)) != NULL) {
        const char* f = path_combine(*p, filename);
        if (file_exists(f))
            return f;
    }

    // not found, return original file name
    return path_canon(filename);
}

void path_mkdir(const char* dirname) {
    dirname = path_canon(dirname);
    if (!dir_exists(dirname)) {
        const char* parent = path_dir(dirname);
        path_mkdir(parent);
        xmkdir(dirname);
    }
}

void path_rmdir(const char* dirname) {
    dirname = path_canon(dirname);
    if (dir_exists(dirname)) {
        // delete all children
        UT_array* files = path_find_all(dirname, false);
        {
            char** p = NULL;
            while ((p = (char**)utarray_next(files, p)) != NULL) {
                if (file_exists(*p))
                    xremove(*p);
                else if (dir_exists(*p))
                    path_rmdir(*p);
            }
        }
        utarray_free(files);

        xrmdir(dirname);
    }
}

//---------- PATHNAME MANIPULATION ----------//

static void utstring_path_canon(UT_string* path) {
    // remove double slashes and normalize forward slashes
    char* s = utstring_body(path);
    char* d = utstring_body(path);
    while (*s) {
        if (isslash(*s)) {
            *d++ = '/';
            while (*s && isslash(*s))
                s++;
        }
        else {
            while (*s && !isslash(*s))
                *d++ = *s++;
        }
    }
    *d = '\0';

    // skip initial volume, root dir, or parent dir
    char* p = utstring_body(path);
    if (isalpha(p[0]) && p[1] == ':') p += 2;			// win32 volume
    if (*p == '/')
        p++;											// root dir
    else
        while (strncmp(p, "../", 3) == 0)				// ../ at start cannot be removed
            p += 3;
    char* root = p;

    // remove "./" and "xxx/.."
    while (*p) {
        if (*p == '/')
            p++;
        else if (strncmp(p, "./", 2) == 0) {			// remove ./
            memmove(p, p + 2, strlen(p + 2) + 1);		// copy also null
        }
        else if (strcmp(p, ".") == 0) 					// remove final .
            *p = '\0';
        else {
            char* p1 = p;
            while (*p && *p != '/')
                p++;
            if (strncmp(p, "/../", 4) == 0) {
                memmove(p1, p + 4, strlen(p + 4) + 1);	// copy also null
                p = p1;
            }
            else if (strcmp(p, "/..") == 0) {
                p = p1;
                *p = '\0';
            }
            else {
                ;	// p points to the '/' or '\0'
            }
        }
    }

    // remove trailing slashes
    while (p - 1 > root && p[-1] == '/') {
        p--;
        *p = '\0';
    }
    utstring_len(path) = p - utstring_body(path);

    if (utstring_len(path) == 0)		// dir is now empty
        utstring_printf(path, ".");
}

static const char* path_canon_sep(const char* path, char wi32_sep) {
    UT_string* canon;
    utstring_new(canon);
    utstring_printf(canon, "%s", path);
    utstring_path_canon(canon);

#ifdef _WIN32
    char* p = utstring_body(canon);
    while ((p = strchr(p, '/')) != NULL)
        * p++ = wi32_sep;
#endif

    const char* ret = str_pool_add(utstring_body(canon));
    utstring_free(canon);
    return ret;
}

const char* path_canon(const char* path) {
    return path_canon_sep(path, '/');
}

const char* path_os(const char* path) {
    return path_canon_sep(path, '\\');
}

const char* path_combine(const char* path1, const char* path2) {
    UT_string* path;
    utstring_new(path);

    utstring_printf(path, "%s/", path1);

    if (isalpha(path2[0]) && path2[1] == ':') 					// remove ':'
        utstring_printf(path, "%c/%s", path2[0], path2 + 2);	// drive-letter/rest-of-path
    else
        utstring_printf(path, path2);

    utstring_path_canon(path);

    const char* ret = str_pool_add(utstring_body(path));
    utstring_free(path);
    return ret;
}

static char* path_dir_slash(UT_string* path) {
    utstring_path_canon(path);

    char* p = utstring_body(path);
    if (isalpha(p[0]) && p[1] == ':')
        p += 2;											// win32 volume
    if (*p == '/')
        p++;											// root dir
    char* root = p;

    p = utstring_body(path) + utstring_len(path) - 1;
    while (p > root && *p != '/')
        p--;

    return p;
}

const char* path_dir(const char* path1) {
    UT_string* path;
    utstring_new(path);
    utstring_printf(path, "%s", path1);

    char* p = path_dir_slash(path);
    *p = '\0';
    utstring_len(path) = p - utstring_body(path);

    if (utstring_len(path) == 0)						// dir is now empty
        utstring_printf(path, ".");

    const char* ret = str_pool_add(utstring_body(path));
    utstring_free(path);
    return ret;
}

const char* path_file(const char* path1) {
    UT_string* path;
    utstring_new(path);
    utstring_printf(path, "%s", path1);

    char* p = path_dir_slash(path);
    if (*p == '/')
        p++;

    const char* ret = str_pool_add(p);
    utstring_free(path);
    return ret;
}

const char* path_ext(const char* path) {
    if (isalpha(path[0]) && path[1] == ':') path += 2;	// win32 volume
    if (isslash(*path)) path++;							// root dir

    const char* p = path + strlen(path) - 1;
    while (p > path && *p != '.' && !isslash(p[-1]))
        p--;
    if (*p == '.' && p > path && !isslash(p[-1]))
        return str_pool_add(p);
    else
        return str_pool_add("");
}

const char* path_remove_ext(const char* path1) {
    return path_replace_ext(path1, "");
}

const char* path_replace_ext(const char* path1, const char* new_ext) {
    UT_string* path;
    utstring_new(path);
    utstring_printf(path, "%s", path1);
    utstring_path_canon(path);

    // remove extension
    const char* old_ext = path_ext(path1);
    utstring_len(path) -= strlen(old_ext);
    utstring_body(path)[utstring_len(path)] = '\0';

    // append new extension
    if (*new_ext && *new_ext != '.')
        utstring_printf(path, ".");
    utstring_printf(path, "%s", new_ext);

    const char* ret = str_pool_add(utstring_body(path));
    utstring_free(path);
    return ret;
}

//---------- CHECK FILESYSTEM ----------//

bool file_exists(const char* filename) {
    struct stat sb;
    if ((stat(filename, &sb) == 0) && (sb.st_mode & S_IFREG))
        return true;
    else
        return false;
}

bool dir_exists(const char* dirname) {
    struct stat sb;
    if ((stat(dirname, &sb) == 0) && (sb.st_mode & S_IFDIR))
        return true;
    else
        return false;
}

long file_size(const char* filename) {
    struct stat sb;
    if ((stat(filename, &sb) == 0) && (sb.st_mode & S_IFREG))
        return sb.st_size;
    else
        return -1;
}

//---------- C-STRINGS ----------//

int char_digit(char c) {
    if (isdigit(c)) return c - '0';
    if (isalpha(c)) return 10 + toupper(c) - 'A';
    return -1;
}

char* str_toupper(char* str) {
    for (char* p = str; *p; p++)* p = toupper(*p);
    return str;
}

char* str_tolower(char* str) {
    for (char* p = str; *p; p++)* p = tolower(*p);
    return str;
}

char* str_chomp(char* str) {
    for (char* p = str + strlen(str) - 1; p >= str && isspace(*p); p--)* p = '\0';
    return str;
}

char* str_strip(char* str) {
    char* p;
    for (p = str; *p != '\0' && isspace(*p); p++) {}// skip begining spaces
    memmove(str, p, strlen(p) + 1);					// move also '\0'
    return str_chomp(str);							// remove ending spaces
}

// code borrowed from GLib
size_t str_compress_escapes(char* str) {
    char* p = NULL, * q = NULL, * num = NULL;
    int base = 0, max_digits, digit;

    for (p = q = str; *p; p++) {
        if (*p == '\\') {
            p++;
            base = 0;							/* decision octal/hex */
            switch (*p) {
            case '\0':	p--; break;				/* trailing backslash - ignore */
            case 'a':	*q++ = '\a'; break;
            case 'b':	*q++ = '\b'; break;
            case 'e':	*q++ = '\x1B'; break;
            case 'f':	*q++ = '\f'; break;
            case 'n':	*q++ = '\n'; break;
            case 'r':	*q++ = '\r'; break;
            case 't':	*q++ = '\t'; break;
            case 'v':	*q++ = '\v'; break;
            case '0': case '1': case '2': case '3': case '4': case '5': case '6': case '7':
                num = p;				/* start of number */
                base = 8;
                max_digits = 3;
            /* fall through */
            case 'x':
                if (base == 0) {	/* not octal */
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
            default:	*q++ = *p;		/* any other char */
            }
        }
        else
            *q++ = *p;
    }
    *q = '\0';

    return q - str;
}

int str_case_cmp(const char* s1, const char* s2) {
    if (s1 == s2)   return 0;
    if (s1 == NULL) return -1;
    if (s2 == NULL)	return 1;
    while (*s2 != '\0' && tolower(*s1) == tolower(*s2)) {
        s1++; s2++;
    }
    return (int)(tolower(*s1) - tolower(*s2));
}

int str_case_n_cmp(const char* s1, const char* s2, size_t n) {
    char c1, c2;

    if (s1 == s2)   return 0;
    if (s1 == NULL) return -1;
    if (s2 == NULL)	return 1;
    if (n == 0)		return 0;
    do {
        c1 = tolower(*s1++);
        c2 = tolower(*s2++);
        n--;
    }
    while ((c1 != '\0') && (c1 == c2) && (n > 0));

    return (int)(c1 - c2);
}

//---------- UT-STRINGS ----------//

UT_string* utstring_alloc(void) {
    UT_string* str;
    utstring_new(str);
    return str;
}

void utstring_set(UT_string* str, const char* src) {
    utstring_clear(str);
    utstring_printf(str, "%s", src);
}

void utstring_set_printf(UT_string* str, const char* fmt, ...) {
    va_list ap;
    va_start(ap, fmt);

    utstring_clear(str);
    utstring_printf_va(str, fmt, ap);

    va_end(ap);
}

void utstring_toupper(UT_string* str) {
    str_toupper(utstring_body(str));
}

void utstring_tolower(UT_string* str) {
    str_tolower(utstring_body(str));
}

void utstring_chomp(UT_string* str) {
    char* end = utstring_body(str) + utstring_len(str);
    while (end > utstring_body(str) && isspace(end[-1]))
        end--;
    *end = '\0';
    utstring_len(str) = end - utstring_body(str);
}

void utstring_strip(UT_string* str) {
    char* start = utstring_body(str);
    while (*start != '\0' && isspace(*start))
        start++;
    size_t len = utstring_len(str) - (start - utstring_body(str));
    memmove(utstring_body(str), start, len + 1);	// move also '\0'
    utstring_len(str) = len;
    utstring_chomp(str);							// remove ending spaces
}

void utstring_compress_escapes(UT_string* str) {
    utstring_len(str) = str_compress_escapes(utstring_body(str));
}

//---------- UT-ARRAYS ----------//

UT_array* utarray_alloc(const UT_icd* icd) {
    UT_array* arr;
    utarray_new(arr, icd);
    return arr;
}

UT_array* utarray_str_alloc(void) {
    return utarray_alloc(&ut_str_icd);
}

void utarray_str_push_back(UT_array* arr, const char* str) {
    utarray_push_back(arr, &str);
}

static int utarray_strcmp(const void* a_, const void* b_) {
    const char* a = *(const char**)a_;
    const char* b = *(const char**)b_;
    return strcmp(a, b);
}

void utarray_str_sort(UT_array* arr) {
    utarray_sort(arr, utarray_strcmp);
}

void* utarray_safe_eltptr(UT_array* arr, size_t idx) {
    // expand array if needed
    size_t curlen = utarray_len(arr);
    size_t newlen = idx + 1;
    if (newlen > curlen) {
        utarray_reserve(arr, newlen - curlen);
        memset(_utarray_eltptr(arr, curlen),
               0,
               _utarray_eltptr(arr, newlen) - _utarray_eltptr(arr, curlen));
        utarray_len(arr) = newlen;
    }

    // return pointer to element
    void* elem = utarray_eltptr(arr, idx);
    assert(elem);
    return elem;
}
