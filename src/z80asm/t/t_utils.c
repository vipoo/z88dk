//-----------------------------------------------------------------------------
// z80asm assembler
// Unit tests
// Copyright (C) Paulo Custodio, 2011-2019
// License: http://www.perlfoundation.org/artistic_license_2_0
// Repository: https://github.com/z88dk/z88dk
//-----------------------------------------------------------------------------

#include "test.h"
#include "../utils.h"

#include <assert.h>
#include <string.h>

#define FILE1 "test.1"
#define DIR1 "test_dir.1"

//---------- MACROS ----------//

void test_MIN(void)
{
	IS(MIN(1, 0), 0);
	IS(MIN(1, 1), 1);
	IS(MIN(1, 2), 1);
}

void test_MAX(void)
{
	IS(MAX(1, 0), 1);
	IS(MAX(1, 1), 1);
	IS(MAX(1, 2), 2);
}

void test_ABS(void)
{
	IS(ABS(-1),	1);
	IS(ABS(0),	0);
	IS(ABS(1),	1);
}

void test_CLAMP(void)
{
	IS(CLAMP(1, 2, 4), 2);
	IS(CLAMP(2, 2, 4), 2);
	IS(CLAMP(3, 2, 4), 3);
	IS(CLAMP(4, 2, 4), 4);
	IS(CLAMP(5, 2, 4), 4);
}

void test_NUM_ELEMS(void)
{
	int nums[10];

	IS(NUM_ELEMS(nums), 10);
}


//---------- FATAL ERRORS ----------//

void test_die(void)
{
	EXEC_NOK("exec_die", 0, "", "hello world 42!\n");
}

int exec_die(void)
{
	die("hello %s %d!", "world", 42);
	return EXIT_SUCCESS;	// not reached
}

//---------- STRING POOL ----------//

void test_str_pool(void)
{
#define NUM_STRINGS 10
#define STRING_SIZE	5

	struct {
		char source[STRING_SIZE];
		const char* pool;
	} strings[NUM_STRINGS];

	const char* pool;
	int i;

	// first run - create pool for all strings
	for (i = 0; i < NUM_STRINGS; i++) {
		sprintf(strings[i].source, "%d", i);		// number i

		pool = str_pool_add(strings[i].source);
		OK(pool);
		OK(pool != strings[i].source);
		STR_IS(strings[i].source, pool);

		strings[i].pool = pool;
	}

	// second run - check that pool did not move
	for (i = 0; i < NUM_STRINGS; i++) {
		pool = str_pool_add(strings[i].source);
		OK(pool);
		OK(pool != strings[i].source);
		STR_IS(strings[i].source, pool);
		OK(strings[i].pool == pool);
	}

	// check NULL case
	pool = str_pool_add(NULL);
	NOK(pool);
}

void test_str_pool_n(void)
{
	const char* hello1 = str_pool_add_n("hello world", 5);
	const char* hello2 = str_pool_add_n("hello", 5);
	const char* hello3 = str_pool_add("hello");

	const char* hell1 = str_pool_add_n("hello", 4);
	const char* hell2 = str_pool_add_n("hell", 5);
	const char* hell3 = str_pool_add("hell");

	STR_IS(hello1, "hello");
	OK(hello1 == hello2);
	OK(hello1 == hello3);

	STR_IS(hell1, "hell");
	OK(hell1 == hell2);
	OK(hell1 == hell3);
}

//---------- MEMORY ALLOCATION ----------//

void test_xmalloc(void)
{
	void* ptr = xmalloc(10);
	OK(ptr);
	memset(ptr, 0, 10);
	OK(memcmp(ptr, "\0\0\0\0\0\0\0\0\0\0", 10) == 0);
	xfree(ptr);
	NOK(ptr);
}

void test_xcalloc(void)
{
	void* ptr = xcalloc(1, 10);
	OK(ptr);
	OK(memcmp(ptr, "\0\0\0\0\0\0\0\0\0\0", 10) == 0);
	xfree(ptr);
	NOK(ptr);
}

void test_xrealloc(void)
{
	void* ptr = xrealloc(NULL, 10);
	OK(ptr);
	memset(ptr, 0, 10);
	OK(memcmp(ptr, "\0\0\0\0\0\0\0\0\0\0", 10) == 0);
	ptr = xrealloc(NULL, 20);
	OK(ptr);
	memset(ptr, 0, 20);
	OK(memcmp(ptr, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 20) == 0);
	xfree(ptr);
	NOK(ptr);
}

void test_xstrdup(void)
{
	char* ptr = xstrdup("hello");
	STR_IS(ptr, "hello");
	xfree(ptr);
	NOK(ptr);
}

void test_xstrndup(void)
{
	char* ptr = xstrndup("hello world", 5);
	STR_IS(ptr, "hello");
	xfree(ptr);
	NOK(ptr);
}

void test_xnew_xfree(void)
{
	long* ptr = xnew(long);
	OK(ptr);
	IS(*ptr, 0L);
	xfree(ptr);
	NOK(ptr);
}

//---------- CHECK SYSTEM CALLS ----------//

void test_xatexit(void)
{
	EXEC_OK("exec_xatexit", 0, "init\ndeinit\n", "");
}

static void exec_xatexit_fini(void)
{
	puts("deinit");
}

int exec_xatexit(void)
{
	xatexit(exec_xatexit_fini);
	puts("init");
	return EXIT_SUCCESS;
}

void test_xsystem(void)
{
	EXEC_OK("exec_xsystem", 1, "", "");
	EXEC_NOK("exec_xsystem", 2, "", "Command 'false' failed\n");
	EXEC_OK("exec_xsystem", 3, "hello\n", "");
}

int exec_xsystem(int test)
{
	switch (test) {
	case 1:
		xsystem("true");
		return EXIT_SUCCESS;

	case 2:
		xsystem("false");
		return EXIT_SUCCESS;

	case 3:
		xsystem("echo hello");
		return EXIT_SUCCESS;

	default:
		return EXIT_FAILURE;
	}
}

void test_xremove(void)
{
	remove(FILE1);
	NOK(file_exists(FILE1));
	xremove(FILE1);			// remove when file does not exist

	test_spew(FILE1, "");
	OK(file_exists(FILE1));
	xremove(FILE1);			// remove when file exists
	NOK(file_exists(FILE1));

#ifdef _WIN32
	// test fails in Linux
	EXEC_NOK("exec_xremove", 0, "", FILE1 ": Permission denied\n");
#endif
}

int exec_xremove(void)
{
	FILE* fp = fopen(FILE1, "w");
	assert(fp);
	xremove(FILE1);
	return EXIT_SUCCESS;	// not reached - cannot remove open file
}

void test_xmkdir_xrmdir(void)
{
	xrmdir(DIR1);
	NOK(dir_exists(DIR1));

	xmkdir(DIR1);
	OK(dir_exists(DIR1));

	xrmdir(DIR1);
	NOK(dir_exists(DIR1));

	xremove(FILE1);
	EXEC_NOK("exec_xmkdir_xrmdir", 1, "", FILE1 ": File exists\n");
	xremove(FILE1);

	xrmdir(DIR1);
	EXEC_NOK("exec_xmkdir_xrmdir", 2, "", DIR1 ": Directory not empty\n");
	xremove(DIR1 "/" FILE1);
	xrmdir(DIR1);
}

int exec_xmkdir_xrmdir(int test)
{
	switch (test) {
	case 1:
		test_spew(FILE1, "");
		xmkdir(FILE1);
		return EXIT_SUCCESS;	// not reached

	case 2:
		xmkdir(DIR1);
		test_spew(DIR1 "/" FILE1, "");
		xrmdir(DIR1);
		return EXIT_SUCCESS;	// not reached

	default:
		return EXIT_SUCCESS;
	}
}

//---------- CHECK FILE IO ----------//

void test_xfopen_xfwrite_xfread(void)
{
	char buffer[6];

	FILE* fp = xfopen(FILE1, "wb");
	OK(fp);

	xfwrite("hello", sizeof(char), 5, fp);
	xfclose(fp);
	NOK(fp);

	fp = xfopen(FILE1, "rb");
	OK(fp);

	xfread(buffer, sizeof(char), 5, fp);
	buffer[5] = '\0';
	STR_IS("hello", buffer);

	xfclose(fp);
	OK(0 == remove(FILE1));
}

void test_xfopen_error(void)
{
	EXEC_NOK("exec_xfopen_error", 0,
		"", "/x/x/x/x/x/x/x/x/x: No such file or directory\n");
}

int exec_xfopen_error(void)
{
	FILE* fp = xfopen("/x/x/x/x/x/x/x/x/x", "rb");
	if (fp) return EXIT_SUCCESS;	// silece warning
	return EXIT_SUCCESS;			// not reached
}

void test_xfwrite_error(void)
{
	EXEC_NOK("exec_xfwrite_error", 0, "", "Failed to write 5 bytes to '" FILE1 "'\n");
	xremove(FILE1);
}

int exec_xfwrite_error(void)
{
	test_spew(FILE1, "");
	FILE* fp = xfopen(FILE1, "r");		// open for READ, try to WRITE
	OK(fp);
	xfwrite("hello", sizeof(char), 5, fp);	// fails

	// not reached
	xfclose(fp);
	NOK(fp);
	return EXIT_SUCCESS;
}

void test_xfread_error(void)
{
	EXEC_NOK("exec_xfread_error", 0, "", "Failed to read 5 bytes from '" FILE1 "'\n");
	xremove(FILE1);
}

int exec_xfread_error(void)
{
	test_spew(FILE1, "");
	FILE* fp = xfopen(FILE1, "r");
	OK(fp);

	char buffer[5];
	xfread(buffer, sizeof(char), 5, fp);	// fails

	// not reached
	xfclose(fp);
	NOK(fp);
	return EXIT_SUCCESS;
}

void test_xfwrite_xfread_bytes(void)
{
	FILE* fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	xfwrite_bytes("hello", 5, fp);
	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	char buffer[6];
	xfread_bytes(buffer, 5, fp);
	buffer[5] = '\0';
	STR_IS(buffer, "hello");

	xfclose(fp);
	xremove(FILE1);
}

void test_xfwrite_str(void)
{
	FILE* fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	xfwrite_str("hello", fp);
	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	char buffer[6];
	xfread(buffer, sizeof(char), 5, fp);
	buffer[5] = '\0';
	STR_IS(buffer, "hello");

	xfclose(fp);
	xremove(FILE1);
}

void test_xfwrite_xfread_utstring(void)
{
	UT_string* str;
	utstring_new(str);
	utstring_printf(str, "hello");

	FILE* fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	xfwrite_utstring(str, fp);
	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	char buffer[6];
	xfread(buffer, sizeof(char), 5, fp);
	buffer[5] = '\0';
	STR_IS(buffer, "hello");

	utstring_clear(str);
	utstring_printf(str, "DUMMY");

	xfseek(fp, 0, SEEK_SET);
	xfread_utstring(str, 5, fp);

	STR_IS(utstring_body(str), "hello");
	IS(utstring_len(str), 5);

	xfclose(fp);
	xremove(FILE1);

	utstring_free(str);
}

void test_xfwrite_xfread_int_uint(void)
{
	FILE* fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	xfwrite_int8(-1, fp);		// 1
	xfwrite_int8(-128, fp);		// 2
	xfwrite_int8(127, fp);		// 3
	xfwrite_int8(255, fp);		// 4
	xfwrite_int8(256, fp);		// 5

	xfwrite_uint8(-1, fp);		// 6
	xfwrite_uint8(-128, fp);	// 7
	xfwrite_uint8(127, fp);		// 8
	xfwrite_uint8(255, fp);		// 9
	xfwrite_uint8(256, fp);		// 10

	xfwrite_int16(-1, fp);		// 11
	xfwrite_int16(-32768, fp);	// 12
	xfwrite_int16(32767, fp);	// 13
	xfwrite_int16(65535, fp);	// 14
	xfwrite_int16(65536, fp);	// 15

	xfwrite_uint16(-1, fp);		// 16
	xfwrite_uint16(-32768, fp);	// 17
	xfwrite_uint16(32767, fp);	// 18
	xfwrite_uint16(65535, fp);	// 19
	xfwrite_uint16(65536, fp);	// 20

	xfwrite_int32(-1, fp);			// 21
	xfwrite_int32(0, fp);			// 22
	xfwrite_int32(2147483648, fp);	// 23
	xfwrite_int32(2147483647, fp);	// 24

	xfwrite_uint32(-1, fp);			// 25
	xfwrite_uint32(0, fp);			// 26
	xfwrite_uint32(2147483648, fp);	// 27
	xfwrite_uint32(2147483647, fp);	// 28

	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	IS(fgetc(fp), 0xFF);		// 1
	IS(fgetc(fp), 0x80);		// 2
	IS(fgetc(fp), 0x7F);		// 3
	IS(fgetc(fp), 0xFF);		// 4
	IS(fgetc(fp), 0x00);		// 5

	IS(fgetc(fp), 0xFF);		// 6
	IS(fgetc(fp), 0x80);		// 7
	IS(fgetc(fp), 0x7F);		// 8
	IS(fgetc(fp), 0xFF);		// 9
	IS(fgetc(fp), 0x00);		// 10

	IS(fgetc(fp), 0xFF);		// 11
	IS(fgetc(fp), 0xFF);
	
	IS(fgetc(fp), 0x00);		// 12
	IS(fgetc(fp), 0x80);

	IS(fgetc(fp), 0xFF);		// 13
	IS(fgetc(fp), 0x7F);

	IS(fgetc(fp), 0xFF);		// 14
	IS(fgetc(fp), 0xFF);

	IS(fgetc(fp), 0x00);		// 15
	IS(fgetc(fp), 0x00);

	IS(fgetc(fp), 0xFF);		// 16
	IS(fgetc(fp), 0xFF);

	IS(fgetc(fp), 0x00);		// 17
	IS(fgetc(fp), 0x80);

	IS(fgetc(fp), 0xFF);		// 18
	IS(fgetc(fp), 0x7F);

	IS(fgetc(fp), 0xFF);		// 19
	IS(fgetc(fp), 0xFF);

	IS(fgetc(fp), 0x00);		// 20
	IS(fgetc(fp), 0x00);

	IS(fgetc(fp), 0xFF);		// 21
	IS(fgetc(fp), 0xFF);
	IS(fgetc(fp), 0xFF);
	IS(fgetc(fp), 0xFF);

	IS(fgetc(fp), 0x00);		// 22
	IS(fgetc(fp), 0x00);
	IS(fgetc(fp), 0x00);
	IS(fgetc(fp), 0x00);

	IS(fgetc(fp), 0x00);		// 23
	IS(fgetc(fp), 0x00);
	IS(fgetc(fp), 0x00);
	IS(fgetc(fp), 0x80);

	IS(fgetc(fp), 0xFF);		// 24
	IS(fgetc(fp), 0xFF);
	IS(fgetc(fp), 0xFF);
	IS(fgetc(fp), 0x7F);

	IS(fgetc(fp), 0xFF);		// 25
	IS(fgetc(fp), 0xFF);
	IS(fgetc(fp), 0xFF);
	IS(fgetc(fp), 0xFF);

	IS(fgetc(fp), 0x00);		// 26
	IS(fgetc(fp), 0x00);
	IS(fgetc(fp), 0x00);
	IS(fgetc(fp), 0x00);

	IS(fgetc(fp), 0x00);		// 27
	IS(fgetc(fp), 0x00);
	IS(fgetc(fp), 0x00);
	IS(fgetc(fp), 0x80);

	IS(fgetc(fp), 0xFF);		// 28
	IS(fgetc(fp), 0xFF);
	IS(fgetc(fp), 0xFF);
	IS(fgetc(fp), 0x7F);

	xfseek(fp, 0, SEEK_SET);

	IS(xfread_int8(fp), -1);		// 1
	IS(xfread_int8(fp), -128);		// 2
	IS(xfread_int8(fp), 127);		// 3
	IS(xfread_int8(fp), -1);		// 4
	IS(xfread_int8(fp), 0);			// 5

	IS(xfread_uint8(fp), 255);		// 6
	IS(xfread_uint8(fp), 128);		// 7
	IS(xfread_uint8(fp), 127);		// 8
	IS(xfread_uint8(fp), 255);		// 9
	IS(xfread_uint8(fp), 0);		// 10

	IS(xfread_int16(fp), -1);		// 11
	IS(xfread_int16(fp), -32768);	// 12
	IS(xfread_int16(fp), 32767);	// 13
	IS(xfread_int16(fp), -1);		// 14
	IS(xfread_int16(fp), 0);		// 15

	IS(xfread_uint16(fp), 65535);	// 16
	IS(xfread_uint16(fp), 32768);	// 17
	IS(xfread_uint16(fp), 32767);	// 18
	IS(xfread_uint16(fp), 65535);	// 19
	IS(xfread_uint16(fp), 0);		// 20

	IS(xfread_int32(fp), -1);			// 21
	IS(xfread_int32(fp), 0);			// 22
	IS(xfread_int32(fp), 2147483648);	// 23
	IS(xfread_int32(fp), 2147483647);	// 24

	IS(xfread_uint32(fp), -1);			// 25
	IS(xfread_uint32(fp), 0);			// 26
	IS(xfread_uint32(fp), 2147483648);	// 27
	IS(xfread_uint32(fp), 2147483647);	// 28

	IS(fgetc(fp), EOF);

	xfclose(fp);

	xremove(FILE1);
}

void test_xfwrite_xfread_count8str_utstring(void)
{
	UT_string* s;
	utstring_new(s);

	FILE *fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	utstring_clear(s);
	xfwrite_count8str_utstring(s, fp);		// 1

	utstring_clear(s);
	utstring_printf(s, "h");
	xfwrite_count8str_utstring(s, fp);		// 2

	utstring_clear(s);
	utstring_printf(s, "hello");
	xfwrite_count8str_utstring(s, fp);		// 3

	utstring_clear(s);
	for (int i = 0; i < 255; i++)
		utstring_printf(s, "x");
	IS(utstring_len(s), 255);
	xfwrite_count8str_utstring(s, fp);		// 4

	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	IS(fgetc(fp), 0);						// 1

	IS(fgetc(fp), 1);						// 2
	IS(fgetc(fp), 'h');

	IS(fgetc(fp), 5);						// 3
	IS(fgetc(fp), 'h');
	IS(fgetc(fp), 'e');
	IS(fgetc(fp), 'l');
	IS(fgetc(fp), 'l');
	IS(fgetc(fp), 'o');

	IS(fgetc(fp), 255);						// 4
	for (int i = 0; i < 255; i++)
		IS(fgetc(fp), 'x');

	IS(fgetc(fp), EOF);

	xfseek(fp, 0, SEEK_SET);

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count8str_utstring(s, fp);
	STR_IS(utstring_body(s), "");			// 1

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count8str_utstring(s, fp);
	STR_IS(utstring_body(s), "h");			// 2

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count8str_utstring(s, fp);
	STR_IS(utstring_body(s), "hello");		// 3

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count8str_utstring(s, fp);
	IS(utstring_len(s), 255);				// 4
	for (int i = 0; i < 255; i++)
		IS(utstring_body(s)[i], 'x');

	IS(fgetc(fp), EOF);

	xfclose(fp);
	xremove(FILE1);
	utstring_free(s);

	EXEC_NOK("exec_xfwrite_xfread_count8str_utstring", 0, 
		"", "String 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx...' too long for 8-bit counted string\n");
	IS(file_size(FILE1), 0);
	xremove(FILE1);
}

int exec_xfwrite_xfread_count8str_utstring(void)
{
	UT_string* s;
	utstring_new(s);

	FILE *fp = xfopen(FILE1, "wb");
	OK(fp);

	for (int i = 0; i < 256; i++)
		utstring_printf(s, "x");
	IS(utstring_len(s), 256);
	xfwrite_count8str_utstring(s, fp);		// fails

	// not reached
	xfclose(fp);
	utstring_free(s);

	return EXIT_SUCCESS;
}

void test_xfwrite_xfread_count16str_utstring(void)
{
	UT_string* s;
	utstring_new(s);

	FILE *fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	utstring_clear(s);
	xfwrite_count16str_utstring(s, fp);		// 1

	utstring_clear(s);
	utstring_printf(s, "h");
	xfwrite_count16str_utstring(s, fp);		// 2

	utstring_clear(s);
	utstring_printf(s, "hello");
	xfwrite_count16str_utstring(s, fp);		// 3

	utstring_clear(s);
	for (int i = 0; i < 255; i++)
		utstring_printf(s, "x");
	IS(utstring_len(s), 255);
	xfwrite_count16str_utstring(s, fp);		// 4

	utstring_clear(s);
	for (int i = 0; i < 256; i++)
		utstring_printf(s, "x");
	IS(utstring_len(s), 256);
	xfwrite_count16str_utstring(s, fp);		// 5

	utstring_clear(s);
	for (int i = 0; i < 0xFFFF; i++)
		utstring_printf(s, "x");
	IS(utstring_len(s), 0xFFFF);
	xfwrite_count16str_utstring(s, fp);		// 6

	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	IS(fgetc(fp), 0);						// 1
	IS(fgetc(fp), 0);

	IS(fgetc(fp), 1);						// 2 
	IS(fgetc(fp), 0);
	IS(fgetc(fp), 'h');

	IS(fgetc(fp), 5);						// 3 
	IS(fgetc(fp), 0);
	IS(fgetc(fp), 'h');
	IS(fgetc(fp), 'e');
	IS(fgetc(fp), 'l');
	IS(fgetc(fp), 'l');
	IS(fgetc(fp), 'o');

	IS(fgetc(fp), 255);						// 4
	IS(fgetc(fp), 0);
	for (int i = 0; i < 255; i++)
		IS(fgetc(fp), 'x');

	IS(fgetc(fp), 0);						// 5
	IS(fgetc(fp), 1);
	for (int i = 0; i < 256; i++)
		IS(fgetc(fp), 'x');

	IS(fgetc(fp), 255);						// 6
	IS(fgetc(fp), 255);
	for (int i = 0; i < 0xFFFF; i++)
		IS(fgetc(fp), 'x');

	IS(fgetc(fp), EOF);

	xfseek(fp, 0, SEEK_SET);

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count16str_utstring(s, fp);
	STR_IS(utstring_body(s), "");			// 1

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count16str_utstring(s, fp);
	STR_IS(utstring_body(s), "h");			// 2

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count16str_utstring(s, fp);
	STR_IS(utstring_body(s), "hello");		// 3

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count16str_utstring(s, fp);
	IS(utstring_len(s), 255);				// 4
	for (int i = 0; i < 255; i++)
		IS(utstring_body(s)[i], 'x');

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count16str_utstring(s, fp);
	IS(utstring_len(s), 256);				// 5
	for (int i = 0; i < 256; i++)
		IS(utstring_body(s)[i], 'x');

	utstring_clear(s);
	utstring_printf(s, "DUMMY");
	xfread_count16str_utstring(s, fp);
	IS(utstring_len(s), 0xFFFF);			// 6
	for (int i = 0; i < 0xFFFF; i++)
		IS(utstring_body(s)[i], 'x');

	IS(fgetc(fp), EOF);

	xfclose(fp);
	xremove(FILE1);
	utstring_free(s);

	EXEC_NOK("exec_xfwrite_xfread_count16str_utstring", 0,
		"", "String 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx...' too long for 16-bit counted string\n");
	IS(file_size(FILE1), 0);
	xremove(FILE1);
}

void test_xfwrite_count8str_bytes(void)
{
	UT_string* s;
	utstring_new(s);

	FILE *fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	xfwrite_count8str_bytes("hello", 5, fp);
	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	xfread_count8str_utstring(s, fp);
	STR_IS(utstring_body(s), "hello");

	IS(fgetc(fp), EOF);

	xfclose(fp);
	xremove(FILE1);
	utstring_free(s);
}

void test_xfwrite_count16str_bytes(void)
{
	UT_string* s;
	utstring_new(s);

	FILE *fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	xfwrite_count16str_bytes("hello", 5, fp);
	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	xfread_count16str_utstring(s, fp);
	STR_IS(utstring_body(s), "hello");

	IS(fgetc(fp), EOF);

	xfclose(fp);
	xremove(FILE1);
	utstring_free(s);
}

void test_xfwrite_count8str_str(void)
{
	UT_string* s;
	utstring_new(s);

	FILE *fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	xfwrite_count8str_str("hello", fp);
	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	xfread_count8str_utstring(s, fp);
	STR_IS(utstring_body(s), "hello");

	IS(fgetc(fp), EOF);

	xfclose(fp);
	xremove(FILE1);
	utstring_free(s);
}

void test_xfwrite_count16str_str(void)
{
	UT_string* s;
	utstring_new(s);

	FILE *fp = xfopen(FILE1, "wb");
	ASSERT(fp);

	xfwrite_count16str_str("hello", fp);
	xfclose(fp);

	fp = xfopen(FILE1, "rb");
	ASSERT(fp);

	xfread_count16str_utstring(s, fp);
	STR_IS(utstring_body(s), "hello");

	IS(fgetc(fp), EOF);

	xfclose(fp);
	xremove(FILE1);
	utstring_free(s);
}

int exec_xfwrite_xfread_count16str_utstring(void)
{
	UT_string* s;
	utstring_new(s);

	FILE *fp = xfopen(FILE1, "wb");
	OK(fp);

	for (int i = 0; i < 0x10000; i++)
		utstring_printf(s, "x");
	IS(utstring_len(s), 0x10000);
	xfwrite_count16str_utstring(s, fp);		// fails

	// not reached
	xfclose(fp);
	utstring_free(s);

	return EXIT_SUCCESS;
}

void test_xftell_xfseek(void)
{
	test_spew(FILE1, "1234");
	FILE* fp = fopen(FILE1, "rb");
	ASSERT(fp);

	IS(xftell(fp), 0);
	IS(fgetc(fp), '1');
	IS(xftell(fp), 1);
	IS(fgetc(fp), '2');
	IS(xftell(fp), 2);

	xfseek(fp, 0, SEEK_SET);
	IS(fgetc(fp), '1');

	xfseek(fp, 0, SEEK_END);
	IS(fgetc(fp), EOF);

	xfseek(fp, -3, SEEK_CUR);
	IS(fgetc(fp), '2');

	xfclose(fp);

	xremove(FILE1);
}

//---------- READ/WRITE FILES ----------//

void test_file_spew_slurp(void)
{
	xremove(FILE1);

	const char *text =
		"In the beginning God created the heaven and the earth. \n"
		"\n"
		"And the earth was without form, and void; and darkness was upon the face \n"
		"of the deep. And the Spirit of God moved upon the face of the waters. \n"
		"\n"
		"And God said, Let there be light: and there was light. \n"
		"\n"
		"And God saw the light, that it was good: and God divided the light from \n"
		"the darkness. \n"
		"\n"
		"And God called the light Day, and the darkness he called Night. And the \n"
		"evening and the morning were the first day. \n"
		"\n"
		"And God said, Let there be a firmament in the midst of the waters, and \n"
		"let it divide the waters from the waters. \n"
		"\n"
		"And God made the firmament, and divided the waters which were under the \n"
		"firmament from the waters which were above the firmament: and it was so. \n"
		"\n"
		"And God called the firmament Heaven. And the evening and the morning \n"
		"were the second day. \n"
		"\n"
		"And God said, Let the waters under the heaven be gathered together unto \n"
		"one place, and let the dry land appear: and it was so. \n"
		"\n"
		"And God called the dry land Earth; and the gathering together of the \n"
		"waters called he Seas: and God saw that it was good. \n"
		"\n"
		"And God said, Let the earth bring forth grass, the herb yielding seed, \n"
		"and the fruit tree yielding fruit after his kind, whose seed is in \n"
		"itself, upon the earth: and it was so. \n"
		"\n"
		"And the earth brought forth grass, and herb yielding seed after his \n"
		"kind, and the tree yielding fruit, whose seed was in itself, after his \n"
		"kind: and God saw that it was good. \n"
		"\n"
		"And the evening and the morning were the third day. \n"
		"\n"
		"And God said, Let there be lights in the firmament of the heaven to \n"
		"divide the day from the night; and let them be for signs, and for \n"
		"seasons, and for days, and years: \n"
		"\n"
		"And let them be for lights in the firmament of the heaven to give light \n"
		"upon the earth: and it was so. \n"
		"\n"
		"And God made two great lights; the greater light to rule the day, and \n"
		"the lesser light to rule the night: he made the stars also. \n"
		"\n"
		"And God set them in the firmament of the heaven to give light upon the \n"
		"earth, \n"
		"\n"
		"And to rule over the day and over the night, and to divide the light \n"
		"from the darkness: and God saw that it was good. \n"
		"\n"
		"And the evening and the morning were the fourth day. \n"
		"\n"
		"And God said, Let the waters bring forth abundantly the moving creature \n"
		"that hath life, and fowl that may fly above the earth in the open \n"
		"firmament of heaven. \n"
		"\n"
		"And God created great whales, and every living creature that moveth, \n"
		"which the waters brought forth abundantly, after their kind, and every \n"
		"winged fowl after his kind: and God saw that it was good. \n"
		"\n"
		"And God blessed them, saying, Be fruitful, and multiply, and fill the \n"
		"waters in the seas, and let fowl multiply in the earth. \n"
		"\n"
		"And the evening and the morning were the fifth day. \n"
		"\n"
		"And God said, Let the earth bring forth the living creature after his \n"
		"kind, cattle, and creeping thing, and beast of the earth after his kind: \n"
		"and it was so. \n"
		"\n"
		"And God made the beast of the earth after his kind, and cattle after \n"
		"their kind, and every thing that creepeth upon the earth after his kind: \n"
		"and God saw that it was good. \n"
		"\n"
		"And God said, Let us make man in our image, after our likeness: and let \n"
		"them have dominion over the fish of the sea, and over the fowl of the \n"
		"air, and over the cattle, and over all the earth, and over every \n"
		"creeping thing that creepeth upon the earth. \n"
		"\n"
		"So God created man in his own image, in the image of God created he him; \n"
		"male and female created he them. \n"
		"\n"
		"And God blessed them, and God said unto them, Be fruitful, and multiply, \n"
		"and replenish the earth, and subdue it: and have dominion over the fish \n"
		"of the sea, and over the fowl of the air, and over every living thing \n"
		"that moveth upon the earth. \n"
		"\n"
		"And God said, Behold, I have given you every herb bearing seed, which is \n"
		"upon the face of all the earth, and every tree, in the which is the \n"
		"fruit of a tree yielding seed; to you it shall be for meat. \n"
		"\n"
		"And to every beast of the earth, and to every fowl of the air, and to \n"
		"every thing that creepeth upon the earth, wherein there is life, I have \n"
		"given every green herb for meat: and it was so. \n"
		"\n"
		"And God saw every thing that he had made, and, behold, it was very good. \n"
		"And the evening and the morning were the sixth day. \n";
	size_t text_len = strlen(text);

	const byte_t data[] = { 0,1,2,3,4 };
	size_t data_len = NUM_ELEMS(data);

	UT_string* s;
	utstring_new(s);

	// file_spew_n
	xremove(FILE1);
	file_spew_n(FILE1, data, data_len);
	IS(file_size(FILE1), data_len);

	byte_t* tmp_data = xcalloc(1, data_len);
	FILE* fp = xfopen(FILE1, "rb");
	xfread_bytes(tmp_data, data_len, fp);
	xfclose(fp);

	IS(memcmp(data, tmp_data, data_len), 0);
	xfree(tmp_data);

	// file_spew
	xremove(FILE1);
	file_spew(FILE1, text);
	IS(file_size(FILE1), text_len);

	char* tmp_text = xcalloc(1, text_len + 1);
	fp = xfopen(FILE1, "rb");
	xfread_bytes(tmp_text, text_len, fp);
	xfclose(fp);
	tmp_text[text_len] = '\0';

	IS(strcmp(text, tmp_text), 0);
	xfree(tmp_text);

	// file_spew_utstring
	xremove(FILE1);
	utstring_clear(s);
	utstring_printf(s, "%s", text);
	file_spew_utstring(FILE1, s);

	tmp_text = xcalloc(1, text_len + 1);
	fp = xfopen(FILE1, "rb");
	xfread_bytes(tmp_text, text_len, fp);
	xfclose(fp);
	tmp_text[text_len] = '\0';

	IS(strcmp(text, tmp_text), 0);
	xfree(tmp_text);

	// file_slurp_alloc
	xremove(FILE1);
	file_spew(FILE1, text);
	IS(file_size(FILE1), text_len);

	tmp_text = file_slurp_alloc(FILE1);
	IS(strcmp(text, tmp_text), 0);
	xfree(tmp_text);

	// file_slurp_utstring
	xremove(FILE1);
	file_spew_n(FILE1, data, data_len);
	IS(file_size(FILE1), data_len);

	utstring_clear(s);
	file_slurp_utstring(FILE1, s);

	IS(utstring_len(s), data_len);
	IS(memcmp(data, utstring_body(s), data_len), 0);

	xremove(FILE1);
	utstring_free(s);
}

//---------- CREATE/REMOVE/SEARCH DIRECTORIES ----------//

void test_path_find_all(void)
{
	path_rmdir(DIR1);
	ASSERT(!dir_exists(DIR1));

	path_mkdir(DIR1 "/x1");
	path_mkdir(DIR1 "/x2");
	path_mkdir(DIR1 "/x3");

	file_spew(DIR1 "/test.f0", "");
	file_spew(DIR1 "/x1/test.f0", "");
	file_spew(DIR1 "/x1/test.f1", "");
	file_spew(DIR1 "/x2/test.f1", "");
	file_spew(DIR1 "/x2/test.f2", "");
	file_spew(DIR1 "/x3/test.f2", "");
	file_spew(DIR1 "/x3/test.f3", "");
	ASSERT(dir_exists(DIR1));

	UT_array* f = path_find_all(DIR1, false);
	utarray_str_sort(f);

	char **p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/test.f0");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x1");				p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x2");				p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x3");				p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	f = path_find_files(DIR1, false);
	utarray_str_sort(f);

	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/test.f0");		p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	f = path_find_all(DIR1, true);
	utarray_str_sort(f);

	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/test.f0");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x1");				p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x1/test.f0");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x1/test.f1");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x2");				p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x2/test.f1");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x2/test.f2");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x3");				p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x3/test.f2");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x3/test.f3");		p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	f = path_find_files(DIR1, true);
	utarray_str_sort(f);

	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/test.f0");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x1/test.f0");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x1/test.f1");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x2/test.f1");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x2/test.f2");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x3/test.f2");		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/x3/test.f3");		p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	path_rmdir(DIR1);
	ASSERT(!dir_exists(DIR1));
}

void test_path_find_glob(void)
{
	path_rmdir(DIR1);
	ASSERT(!dir_exists(DIR1));

	int file = 0;
	UT_string* pad = utstring_alloc();
	for (int d1 = 'a'; d1 <= 'b'; d1++) {
		for (int d2 = '1'; d2 <= '2'; d2++) {
			utstring_clear(pad);
			utstring_printf(pad, DIR1 "/%c/%c", d1, d2); 
			path_mkdir(utstring_body(pad));

			utstring_clear(pad);
			utstring_printf(pad, DIR1 "/%c/%c/d", d1, d2);
			path_mkdir(utstring_body(pad));

			utstring_clear(pad);
			utstring_printf(pad, DIR1 "/%c/%c/f%d.c", d1, d2, ++file);
			file_spew(utstring_body(pad), "");

			utstring_clear(pad);
			utstring_printf(pad, DIR1 "/%c/%c/f%d.c", d1, d2, ++file);
			file_spew(utstring_body(pad), "");

			utstring_clear(pad);
			utstring_printf(pad, DIR1 "/%c/%c/f%d.c", d1, d2, ++file);
			file_spew(utstring_body(pad), "");
		}
	}
	utstring_free(pad);

	// no wild card - file exists
	UT_array* f = path_find_glob(DIR1 "/a/1/f1.c");
	utarray_str_sort(f);
	char **p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/a/1/f1.c");  			p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	// no wild card - file does not exist
	f = path_find_glob(DIR1 "/a/1/g1.c");
	utarray_str_sort(f);
	p = (char**)utarray_next(f, NULL);
	ASSERT(p == NULL);
	utarray_free(f);

	// wildcard in file component
	f = path_find_glob(DIR1 "/a/1/f?.c");
	utarray_str_sort(f);
	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/a/1/f1.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f2.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f3.c");  			p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	f = path_find_glob(DIR1 "/a/1/*.c");
	utarray_str_sort(f);
	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/a/1/f1.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f2.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f3.c");  			p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	f = path_find_glob(DIR1 "/a/1/**");
	utarray_str_sort(f);
	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/a/1/f1.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f2.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f3.c");  			p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	// wildcard in path
	f = path_find_glob(DIR1 "/*/*/f?.c");
	utarray_str_sort(f);
	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/a/1/f1.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f2.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f3.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f4.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f5.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f6.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f7.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f8.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f9.c");  			p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	// recursive glob
	f = path_find_glob(DIR1 "/**/f?.c");
	utarray_str_sort(f);
	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/a/1/f1.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f2.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f3.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f4.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f5.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f6.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f7.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f8.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f9.c");  			p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);			
	utarray_free(f);

	f = path_find_glob(DIR1 "/**");
	utarray_str_sort(f);
	p = (char**)utarray_next(f, NULL);
	STR_IS(*p, DIR1 "/a/1/f1.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f2.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/1/f3.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f4.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f5.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/a/2/f6.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f7.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f8.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/1/f9.c");  			p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/2/f10.c");  		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/2/f11.c");  		p = (char**)utarray_next(f, p);
	STR_IS(*p, DIR1 "/b/2/f12.c");  		p = (char**)utarray_next(f, p);
	ASSERT(p == NULL);
	utarray_free(f);

	path_rmdir(DIR1);
	ASSERT(!dir_exists(DIR1));
}

void test_path_mkdir(void)
{
	path_rmdir(DIR1);
	ASSERT(!dir_exists(DIR1));

	path_mkdir(DIR1 "/a/b");
	ASSERT(dir_exists(DIR1));
	ASSERT(dir_exists(DIR1 "/a"));
	ASSERT(dir_exists(DIR1 "/a/b"));

	ASSERT(!file_exists(DIR1 "/a/b/test.txt"));
	file_spew(DIR1 "/a/b/test.txt", "hello");
	ASSERT(file_exists(DIR1 "/a/b/test.txt"));

	path_rmdir(DIR1);
	ASSERT(!dir_exists(DIR1));
}

void test_path_search(void)
{
	path_rmdir(DIR1 ".x1");
	path_rmdir(DIR1 ".x2");
	path_rmdir(DIR1 ".x3");

	ASSERT(!dir_exists(DIR1 ".x1"));
	ASSERT(!dir_exists(DIR1 ".x2"));
	ASSERT(!dir_exists(DIR1 ".x3"));

	path_mkdir(DIR1 ".x1");
	path_mkdir(DIR1 ".x2");
	path_mkdir(DIR1 ".x3");

	ASSERT(dir_exists(DIR1 ".x1"));
	ASSERT(dir_exists(DIR1 ".x2"));
	ASSERT(dir_exists(DIR1 ".x3"));

	file_spew("test.f0", "");
	file_spew(DIR1 ".x1/test.f0", "");
	file_spew(DIR1 ".x1/test.f1", "");
	file_spew(DIR1 ".x2/test.f1", "");
	file_spew(DIR1 ".x2/test.f2", "");
	file_spew(DIR1 ".x3/test.f2", "");
	file_spew(DIR1 ".x3/test.f3", "");

	// NULL dir_list
	STR_IS(path_search("test.f0", NULL), "test.f0");
	STR_IS(path_search("test.f1", NULL), "test.f1");
	STR_IS(path_search("test.f2", NULL), "test.f2");
	STR_IS(path_search("test.f3", NULL), "test.f3");
	STR_IS(path_search("test.f4", NULL), "test.f4");

	// empty dir_list
	UT_array* dirs = utarray_str_alloc();
	STR_IS(path_search("test.f0", dirs), "test.f0");
	STR_IS(path_search("test.f1", dirs), "test.f1");
	STR_IS(path_search("test.f2", dirs), "test.f2");
	STR_IS(path_search("test.f3", dirs), "test.f3");
	STR_IS(path_search("test.f4", dirs), "test.f4");

	// search path
	utarray_str_push_back(dirs, DIR1 ".x1");
	utarray_str_push_back(dirs, DIR1 ".x2");
	utarray_str_push_back(dirs, DIR1 ".x3");

	STR_IS(path_search("test.f0", dirs), "test.f0");
	STR_IS(path_search("test.f1", dirs), DIR1 ".x1/test.f1");
	STR_IS(path_search("test.f2", dirs), DIR1 ".x2/test.f2");
	STR_IS(path_search("test.f3", dirs), DIR1 ".x3/test.f3");
	STR_IS(path_search("test.f4", dirs), "test.f4");

	path_rmdir(DIR1 ".x1");
	path_rmdir(DIR1 ".x2");
	path_rmdir(DIR1 ".x3");

	ASSERT(!dir_exists(DIR1 ".x1"));
	ASSERT(!dir_exists(DIR1 ".x2"));
	ASSERT(!dir_exists(DIR1 ".x3"));
}

//---------- PATHNAME MANIPULATION ----------//

void test_path_canon(void)
{
	// files
	STR_IS(path_canon(""), ".");
	STR_IS(path_canon("."), ".");
	STR_IS(path_canon(".."), "..");
	STR_IS(path_canon("abc"), "abc");

	// multiple slashes are colapsed
	STR_IS(path_canon("abc//\\//def"), "abc/def");
	STR_IS(path_canon("abc//\\//def//\\//"), "abc/def");
	STR_IS(path_canon("c:abc//\\//def//\\//"), "c:abc/def");
	STR_IS(path_canon("c://\\//abc//\\//def//\\//"), "c:/abc/def");

	// handle multiple trainling slashes
	STR_IS(path_canon("abc//"), "abc");
	STR_IS(path_canon("//"), "/");
	STR_IS(path_canon("c://"), "c:/");

	// handle dir/..
	STR_IS(path_canon("abc/.."), ".");
	STR_IS(path_canon("abc/../"), ".");
	STR_IS(path_canon("abc/../def"), "def");
	STR_IS(path_canon("abc/../../def"), "../def");

	STR_IS(path_canon("c:abc/.."), "c:");
	STR_IS(path_canon("c:abc/../"), "c:");
	STR_IS(path_canon("c:abc/../def"), "c:def");
	STR_IS(path_canon("c:abc/../../def"), "c:../def");

	STR_IS(path_canon("c:/abc/.."), "c:/");
	STR_IS(path_canon("c:/abc/../"), "c:/");
	STR_IS(path_canon("c:/abc/../def"), "c:/def");
	STR_IS(path_canon("c:/abc/../../def"), "c:/../def");

	// handle ./
	STR_IS(path_canon("./abc"), "abc");
	STR_IS(path_canon("./abc/."), "abc");
	STR_IS(path_canon("c:./abc/."), "c:abc");
	STR_IS(path_canon("c:/././abc/."), "c:/abc");

	// handle initial ../
	STR_IS(path_canon("../abc"), "../abc");
	STR_IS(path_canon("../../abc"), "../../abc");
	STR_IS(path_canon("../../../abc"), "../../../abc");
}

void test_path_os(void)
{
#ifdef _WIN32
	STR_IS(path_os("c://\\//abc//\\//def//\\//"), "c:\\abc\\def");
#else
	STR_IS(path_os("c://\\//abc//\\//def//\\//"), "c:/abc/def");
#endif
}

void test_path_combine(void)
{
	STR_IS(path_combine("a", "b"), "a/b");
	STR_IS(path_combine("a/", "b"), "a/b");
	STR_IS(path_combine("a", "/b"), "a/b");
	STR_IS(path_combine("a/", "/b"), "a/b");
	STR_IS(path_combine("a/", "c:/b"), "a/c/b");
}

void test_path_dir(void)
{
	STR_IS(path_dir("abc"), ".");
	STR_IS(path_dir("abc.xx"), ".");
	STR_IS(path_dir("./abc"), ".");

	STR_IS(path_dir("/a/b/c/abc"), "/a/b/c");
	STR_IS(path_dir("a/b/c/abc"), "a/b/c");
	STR_IS(path_dir("c:/a/b/c/abc"), "c:/a/b/c");
	STR_IS(path_dir("c:a/b/c/abc"), "c:a/b/c");

	STR_IS(path_dir("c:abc"), "c:");
	STR_IS(path_dir("c:/abc"), "c:/");
}

void test_path_file(void)
{
	STR_IS(path_file("abc"), "abc");
	STR_IS(path_file("abc.xx"), "abc.xx");
	STR_IS(path_file(".x/abc"), "abc");

	STR_IS(path_file("/a/b/c/abc"), "abc");
	STR_IS(path_file("a/b/c/abc"), "abc");
	STR_IS(path_file("c:/a/b/c/abc"), "abc");
	STR_IS(path_file("c:a/b/c/abc"), "abc");

	STR_IS(path_file("c:abc"), "abc");
	STR_IS(path_file("c:/abc"), "abc");
}

void test_path_ext(void)
{
	STR_IS(path_ext("abc"), "");
	STR_IS(path_ext("abc.xx"), ".xx");
	STR_IS(path_ext(".x/abc"), "");

	STR_IS(path_ext("c:abc"), "");
	STR_IS(path_ext("c:/abc"), "");

	STR_IS(path_ext("c:abc.c"), ".c");
	STR_IS(path_ext("c:/abc.c"), ".c");

	STR_IS(path_ext("c:.c"), "");
	STR_IS(path_ext("c:/.c"), "");
}

void test_path_remove_ext(void)
{
	STR_IS(path_remove_ext("abc"), "abc");
	STR_IS(path_remove_ext("abc."), "abc");
	STR_IS(path_remove_ext("abc.xpt"), "abc");
	STR_IS(path_remove_ext("abc.xpt."), "abc.xpt");
	STR_IS(path_remove_ext("abc.xpt.obj"), "abc.xpt");

	STR_IS(path_remove_ext(".x/abc"), ".x/abc");
	STR_IS(path_remove_ext(".x\\abc"), ".x/abc");
	STR_IS(path_remove_ext(".x/abc."), ".x/abc");
	STR_IS(path_remove_ext(".x\\abc."), ".x/abc");
	STR_IS(path_remove_ext(".x/abc.xpt"), ".x/abc");
	STR_IS(path_remove_ext(".x/abc.xpt."), ".x/abc.xpt");
	STR_IS(path_remove_ext(".x/abc.xpt.obj"), ".x/abc.xpt");

	STR_IS(path_remove_ext(".rc"), ".rc");
	STR_IS(path_remove_ext("/.rc"), "/.rc");
	STR_IS(path_remove_ext(".x/.rc"), ".x/.rc");
}

void test_path_replace_ext(void)
{
	STR_IS(path_replace_ext("abc", ""), "abc");
	STR_IS(path_replace_ext("abc.", ""), "abc");

	STR_IS(path_replace_ext("abc", "obj"), "abc.obj");
	STR_IS(path_replace_ext("abc.", "obj"), "abc.obj");
	STR_IS(path_replace_ext("abc", ".obj"), "abc.obj");
	STR_IS(path_replace_ext("abc.", ".obj"), "abc.obj");

	STR_IS(path_replace_ext("abc", "obj"), "abc.obj");
	STR_IS(path_replace_ext("abc.", "obj"), "abc.obj");
	STR_IS(path_replace_ext("abc", ".obj"), "abc.obj");
	STR_IS(path_replace_ext("abc.", ".obj"), "abc.obj");

	STR_IS(path_replace_ext("x./abc", "obj"), "x./abc.obj");
	STR_IS(path_replace_ext("x./abc.", "obj"), "x./abc.obj");
	STR_IS(path_replace_ext("x./abc", ".obj"), "x./abc.obj");
	STR_IS(path_replace_ext("x./abc.", ".obj"), "x./abc.obj");
}

//---------- CHECK FILESYSTEM ----------//

void test_file_checks(void)
{
	xremove(FILE1);
	NOK(file_exists(FILE1));
	IS(file_size(FILE1), -1);

	const char* text = "In the beginning God created the heaven and the earth.\n";
	size_t len = strlen(text);

	test_spew(FILE1, text);
	OK(file_exists(FILE1));
	IS(file_size(FILE1), len);		// no LF -> CR-LF translation took place

	char* read_text = test_slurp_alloc(FILE1);
	STR_IS(read_text, text);
	xfree(read_text);

	xremove(FILE1);
	NOK(file_exists(FILE1));
	IS(file_size(FILE1), -1);
}

//---------- C-STRINGS ----------//

void test_char_digit(void)
{
	IS(char_digit('0'), 0);
	IS(char_digit('9'), 9);
	IS(char_digit('a'), 10);
	IS(char_digit('A'), 10);
	IS(char_digit('f'), 15);
	IS(char_digit('F'), 15);
	IS(char_digit('g'), 16);
	IS(char_digit('G'), 16);
	IS(char_digit('z'), 35);
	IS(char_digit('Z'), 35);
	IS(char_digit(' '), -1);
	IS(char_digit('0' - 1), -1);
	IS(char_digit('9' + 1), -1);
	IS(char_digit('a' - 1), -1);
	IS(char_digit('z' + 1), -1);
	IS(char_digit('A' - 1), -1);
	IS(char_digit('Z' + 1), -1);
}

void test_str_toupper(void)
{
	char buff[10];
	strcpy(buff, "abc1"); STR_IS("ABC1", str_toupper(buff));
	strcpy(buff, "Abc1"); STR_IS("ABC1", str_toupper(buff));
	strcpy(buff, "ABC1"); STR_IS("ABC1", str_toupper(buff));
}

void test_str_tolower(void)
{
	char buff[10];
	strcpy(buff, "abc1"); STR_IS("abc1", str_tolower(buff));
	strcpy(buff, "Abc1"); STR_IS("abc1", str_tolower(buff));
	strcpy(buff, "ABC1"); STR_IS("abc1", str_tolower(buff));
}

void test_str_chomp(void)
{
	char buff[100];
	strcpy(buff, ""); STR_IS("", str_chomp(buff));
	strcpy(buff, "\r\n \t\f \r\n \t\f\v"); STR_IS("", str_chomp(buff));
	strcpy(buff, "\r\n \t\fx\r\n \t\f\v"); STR_IS("\r\n \t\fx", str_chomp(buff));
}

void test_str_strip(void)
{
	char buff[100];
	strcpy(buff, ""); STR_IS("", str_strip(buff));
	strcpy(buff, "\r\n \t\f \r\n \t\f\v"); STR_IS("", str_strip(buff));
	strcpy(buff, "\r\n \t\fx\r\n \t\f\v"); STR_IS("x", str_strip(buff));
}

void test_str_utstring_strip_compress_escapes(void)
{
	char cs[100];
	UT_string* str;
	utstring_new(str);

#define T(in, out_len, out_str) \
			strcpy(cs, in); \
			IS(out_len, str_compress_escapes(cs)); \
			IS(0, memcmp(cs, out_str, out_len)); \
			utstring_clear(str); \
			utstring_printf(str, "%s", in); \
			utstring_compress_escapes(str); \
			STR_IS(utstring_body(str), out_str); \
			IS(utstring_len(str), out_len); \
			IS(0, memcmp(utstring_body(str), out_str, out_len))

	// trailing backslash ignored 
	T("\\", 0, "");

	// escape any 
	T("\\" "?" "\\" "\"" "\\" "'",
		3, "?\"'");

	// escape chars 
	T("0" "\\a"
		"1" "\\b"
		"2" "\\e"
		"3" "\\f"
		"4" "\\n"
		"5" "\\r"
		"6" "\\t"
		"7" "\\v"
		"8",
		17,
		"0" "\a"
		"1" "\b"
		"2" "\x1B"
		"3" "\f"
		"4" "\n"
		"5" "\r"
		"6" "\t"
		"7" "\v"
		"8");

	// octal and hexadecimal, including '\0' 
	for (int i = 0; i < 256; i++)
	{
		sprintf(cs, "\\%o \\x%x", i, i);
		int len = str_compress_escapes(cs);
		IS(3, len);
		IS((char)i, cs[0]);
		IS(' ', cs[1]);
		IS((char)i, cs[2]);
		IS(0, cs[3]);
	}

	// octal and hexadecimal with longer digit string 
	T("\\3770\\xff0",
		4,
		"\xFF" "0" "\xFF" "0");
#undef T

	utstring_free(str);
}

void test_str_case_cmp(void)
{
	OK(str_case_cmp("", "") == 0);
	OK(str_case_cmp("a", "") > 0);
	OK(str_case_cmp("", "a") < 0);
	OK(str_case_cmp("a", "a") == 0);
	OK(str_case_cmp("a", "A") == 0);
	OK(str_case_cmp("A", "a") == 0);
	OK(str_case_cmp("ab", "a") > 0);
	OK(str_case_cmp("a", "ab") < 0);
	OK(str_case_cmp("ab", "ab") == 0);
}

void test_str_case_ncmp(void)
{
	OK(str_case_n_cmp("", "", 0) == 0);
	OK(str_case_n_cmp("x", "y", 0) == 0);
	OK(str_case_n_cmp("a", "", 1) > 0);
	OK(str_case_n_cmp("", "a", 1) < 0);
	OK(str_case_n_cmp("ax", "ay", 1) == 0);
	OK(str_case_n_cmp("ax", "Ay", 1) == 0);
	OK(str_case_n_cmp("Ax", "ay", 1) == 0);
	OK(str_case_n_cmp("abx", "a", 2) > 0);
	OK(str_case_n_cmp("a", "aby", 2) < 0);
	OK(str_case_n_cmp("abx", "aby", 2) == 0);
}

//---------- UT-STRINGS ----------//

void test_utstring_alloc(void) 
{
	UT_string* str = utstring_alloc();
	STR_IS(utstring_body(str), "");
	IS(utstring_len(str), 0);

	utstring_printf(str, "hello");
	STR_IS(utstring_body(str), "hello");
	IS(utstring_len(str), 5);

	utstring_free(str);
}

void test_utstring_set(void) 
{
	UT_string* str = utstring_alloc();
	
	utstring_set(str, "hello");
	STR_IS(utstring_body(str), "hello");

	utstring_set(str, "world");
	STR_IS(utstring_body(str), "world");

	utstring_free(str);
}

void test_utstring_set_printf(void)
{
	UT_string* str = utstring_alloc();

	utstring_set_printf(str, "the answer is %d!", 42);
	STR_IS(utstring_body(str), "the answer is 42!");

	utstring_set_printf(str, "what was the %s?", "question");
	STR_IS(utstring_body(str), "what was the question?");

	utstring_free(str);
}

void test_utstring_toupper(void)
{
	UT_string* buff;
	utstring_new(buff);

	utstring_clear(buff);
	utstring_printf(buff, "abc1");
	utstring_toupper(buff);
	STR_IS(utstring_body(buff), "ABC1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "Abc1");
	utstring_toupper(buff);
	STR_IS(utstring_body(buff), "ABC1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "ABC1");
	utstring_toupper(buff);
	STR_IS(utstring_body(buff), "ABC1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_free(buff);
}

void test_utstring_tolower(void)
{
	UT_string* buff;
	utstring_new(buff);

	utstring_clear(buff);
	utstring_printf(buff, "abc1");
	utstring_tolower(buff);
	STR_IS(utstring_body(buff), "abc1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "Abc1");
	utstring_tolower(buff);
	STR_IS(utstring_body(buff), "abc1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "ABC1");
	utstring_tolower(buff);
	STR_IS(utstring_body(buff), "abc1");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_free(buff);
}

void test_utstring_chomp(void)
{
	UT_string* buff;
	utstring_new(buff);

	utstring_clear(buff);
	utstring_chomp(buff);
	STR_IS(utstring_body(buff), "");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "hello world");
	utstring_chomp(buff);
	STR_IS(utstring_body(buff), "hello world");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "\r\n \t\f \r\n \t\f\v");
	utstring_chomp(buff);
	STR_IS(utstring_body(buff), "");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "\r\n \t\fx\r\n \t\f\v");
	utstring_chomp(buff);
	STR_IS(utstring_body(buff), "\r\n \t\fx");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_free(buff);
}

void test_utstring_strip(void)
{
	UT_string* buff;
	utstring_new(buff);

	utstring_clear(buff);
	utstring_strip(buff);
	STR_IS(utstring_body(buff), "");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "hello world");
	utstring_strip(buff);
	STR_IS(utstring_body(buff), "hello world");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "\r\n \t\f \r\n \t\f\v");
	utstring_strip(buff);
	STR_IS(utstring_body(buff), "");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_clear(buff);
	utstring_printf(buff, "\r\n \t\fx\r\n \t\f\v");
	utstring_strip(buff);
	STR_IS(utstring_body(buff), "x");
	IS(utstring_len(buff), strlen(utstring_body(buff)));

	utstring_free(buff);
}

//---------- UT-ARRAYS ----------//

void test_utarray_alloc(void)
{
	UT_icd my_icd = { 1, NULL, NULL, NULL };

	UT_array* arr = utarray_alloc(&my_icd);
	ASSERT(arr);
	IS(utarray_len(arr), 0);
	IS(arr->icd.sz, 1);
	OK(memcmp(&arr->icd, &my_icd, sizeof(UT_icd)) == 0);
	utarray_free(arr);
}

void test_utarray_safe_eltptr(void)
{
	UT_icd my_icd = { 1, NULL, NULL, NULL };

	UT_array* arr = utarray_alloc(&my_icd);
	ASSERT(arr);
	IS(utarray_len(arr), 0);

	char* p2 = utarray_safe_eltptr(arr, 2);
	char* p1 = utarray_safe_eltptr(arr, 1);
	char* p0 = utarray_safe_eltptr(arr, 0);

	IS(utarray_len(arr), 3);
	IS(p1 - p0, 1);
	IS(p2 - p1, 1);
	OK(p0 == utarray_eltptr(arr, 0));

	utarray_free(arr);
}

void test_utarray_str_alloc(void)
{
	UT_array* arr = utarray_str_alloc();
	ASSERT(arr);
	IS(utarray_len(arr), 0);
	IS(arr->icd.sz, sizeof(char*));
	utarray_free(arr);
}

void test_utarray_str_sort(void)
{
	UT_array* arr = utarray_str_alloc();
	ASSERT(arr);

	utarray_str_push_back(arr, "one");
	utarray_str_push_back(arr, "two");
	utarray_str_push_back(arr, "three");

	IS(utarray_len(arr), 3);
	STR_IS(*(char**)utarray_eltptr(arr, 0), "one");
	STR_IS(*(char**)utarray_eltptr(arr, 1), "two");
	STR_IS(*(char**)utarray_eltptr(arr, 2), "three");

	utarray_str_sort(arr);

	STR_IS(*(char**)utarray_eltptr(arr, 0), "one");
	STR_IS(*(char**)utarray_eltptr(arr, 1), "three");
	STR_IS(*(char**)utarray_eltptr(arr, 2), "two");

	utarray_free(arr);
}
