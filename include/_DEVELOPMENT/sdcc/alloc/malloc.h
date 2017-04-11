
// automatically generated by m4 from headers in proto subdir


#ifndef _ALLOC_MALLOC_H
#define _ALLOC_MALLOC_H

#include <stddef.h>

// DATA STRUCTURES

typedef struct heap_info_s
{

   int     type;     // 0 = HEADER, 1 = ALLOCATED, 2 = FREE
   void   *address;
   size_t  size;

} heap_info_t;

// expose pointer to malloc heap
extern unsigned char *_malloc_heap;

extern void *_falloc_(void *p,size_t size);
extern void *_falloc__callee(void *p,size_t size) __z88dk_callee;
#define _falloc_(a,b) _falloc__callee(a,b)


extern void *heap_alloc(void *heap,size_t size);
extern void *heap_alloc_callee(void *heap,size_t size) __z88dk_callee;
#define heap_alloc(a,b) heap_alloc_callee(a,b)


extern void *heap_alloc_aligned(void *heap,size_t alignment,size_t size);
extern void *heap_alloc_aligned_callee(void *heap,size_t alignment,size_t size) __z88dk_callee;
#define heap_alloc_aligned(a,b,c) heap_alloc_aligned_callee(a,b,c)


extern void *heap_alloc_fixed(void *heap,void *p,size_t size);
extern void *heap_alloc_fixed_callee(void *heap,void *p,size_t size) __z88dk_callee;
#define heap_alloc_fixed(a,b,c) heap_alloc_fixed_callee(a,b,c)


extern void *heap_calloc(void *heap,size_t nmemb,size_t size);
extern void *heap_calloc_callee(void *heap,size_t nmemb,size_t size) __z88dk_callee;
#define heap_calloc(a,b,c) heap_calloc_callee(a,b,c)


extern void *heap_destroy(void *heap);
extern void *heap_destroy_fastcall(void *heap) __z88dk_fastcall;
#define heap_destroy(a) heap_destroy_fastcall(a)


extern void heap_free(void *heap,void *p) __preserves_regs(b,c);
extern void heap_free_callee(void *heap,void *p) __preserves_regs(b,c) __z88dk_callee;
#define heap_free(a,b) heap_free_callee(a,b)


extern void heap_info(void *heap,void *callback);
extern void heap_info_callee(void *heap,void *callback) __z88dk_callee;
#define heap_info(a,b) heap_info_callee(a,b)


extern void *heap_init(void *heap,size_t size);
extern void *heap_init_callee(void *heap,size_t size) __z88dk_callee;
#define heap_init(a,b) heap_init_callee(a,b)


extern void *heap_realloc(void *heap,void *p,size_t size);
extern void *heap_realloc_callee(void *heap,void *p,size_t size) __z88dk_callee;
#define heap_realloc(a,b,c) heap_realloc_callee(a,b,c)


extern void *memalign(size_t alignment,size_t size);
extern void *memalign_callee(size_t alignment,size_t size) __z88dk_callee;
#define memalign(a,b) memalign_callee(a,b)


extern int posix_memalign(void **memptr,size_t alignment,size_t size);
extern int posix_memalign_callee(void **memptr,size_t alignment,size_t size) __z88dk_callee;
#define posix_memalign(a,b,c) posix_memalign_callee(a,b,c)



extern void *_falloc__unlocked(void *p,size_t size);
extern void *_falloc__unlocked_callee(void *p,size_t size) __z88dk_callee;
#define _falloc__unlocked(a,b) _falloc__unlocked_callee(a,b)


extern void *heap_alloc_unlocked(void *heap,size_t size);
extern void *heap_alloc_unlocked_callee(void *heap,size_t size) __z88dk_callee;
#define heap_alloc_unlocked(a,b) heap_alloc_unlocked_callee(a,b)


extern void *heap_alloc_aligned_unlocked(void *heap,size_t alignment,size_t size);
extern void *heap_alloc_aligned_unlocked_callee(void *heap,size_t alignment,size_t size) __z88dk_callee;
#define heap_alloc_aligned_unlocked(a,b,c) heap_alloc_aligned_unlocked_callee(a,b,c)


extern void *heap_alloc_fixed_unlocked(void *heap,void *p,size_t size);
extern void *heap_alloc_fixed_unlocked_callee(void *heap,void *p,size_t size) __z88dk_callee;
#define heap_alloc_fixed_unlocked(a,b,c) heap_alloc_fixed_unlocked_callee(a,b,c)


extern void *heap_calloc_unlocked(void *heap,size_t nmemb,size_t size);
extern void *heap_calloc_unlocked_callee(void *heap,size_t nmemb,size_t size) __z88dk_callee;
#define heap_calloc_unlocked(a,b,c) heap_calloc_unlocked_callee(a,b,c)


extern void heap_free_unlocked(void *heap,void *p) __preserves_regs(b,c);
extern void heap_free_unlocked_callee(void *heap,void *p) __preserves_regs(b,c) __z88dk_callee;
#define heap_free_unlocked(a,b) heap_free_unlocked_callee(a,b)


extern void heap_info_unlocked(void *heap,void *callback);
extern void heap_info_unlocked_callee(void *heap,void *callback) __z88dk_callee;
#define heap_info_unlocked(a,b) heap_info_unlocked_callee(a,b)


extern void *heap_realloc_unlocked(void *heap,void *p,size_t size);
extern void *heap_realloc_unlocked_callee(void *heap,void *p,size_t size) __z88dk_callee;
#define heap_realloc_unlocked(a,b,c) heap_realloc_unlocked_callee(a,b,c)


extern void *memalign_unlocked(size_t alignment,size_t size);
extern void *memalign_unlocked_callee(size_t alignment,size_t size) __z88dk_callee;
#define memalign_unlocked(a,b) memalign_unlocked_callee(a,b)


extern int posix_memalign_unlocked(void **memptr,size_t alignment,size_t size);
extern int posix_memalign_unlocked_callee(void **memptr,size_t alignment,size_t size) __z88dk_callee;
#define posix_memalign_unlocked(a,b,c) posix_memalign_unlocked_callee(a,b,c)



#ifndef _STDLIB_H

extern void *aligned_alloc(size_t alignment,size_t size);
extern void *aligned_alloc_callee(size_t alignment,size_t size) __z88dk_callee;
#define aligned_alloc(a,b) aligned_alloc_callee(a,b)


extern void *calloc(size_t nmemb,size_t size);
extern void *calloc_callee(size_t nmemb,size_t size) __z88dk_callee;
#define calloc(a,b) calloc_callee(a,b)


extern void free(void *p) __preserves_regs(b,c);
extern void free_fastcall(void *p) __preserves_regs(b,c) __z88dk_fastcall;
#define free(a) free_fastcall(a)


extern void *malloc(size_t size);
extern void *malloc_fastcall(size_t size) __z88dk_fastcall;
#define malloc(a) malloc_fastcall(a)


extern void *realloc(void *p,size_t size);
extern void *realloc_callee(void *p,size_t size) __z88dk_callee;
#define realloc(a,b) realloc_callee(a,b)



extern void *aligned_alloc_unlocked(size_t alignment,size_t size);
extern void *aligned_alloc_unlocked_callee(size_t alignment,size_t size) __z88dk_callee;
#define aligned_alloc_unlocked(a,b) aligned_alloc_unlocked_callee(a,b)


extern void *calloc_unlocked(size_t nmemb,size_t size);
extern void *calloc_unlocked_callee(size_t nmemb,size_t size) __z88dk_callee;
#define calloc_unlocked(a,b) calloc_unlocked_callee(a,b)


extern void free_unlocked(void *p) __preserves_regs(b,c);
extern void free_unlocked_fastcall(void *p) __preserves_regs(b,c) __z88dk_fastcall;
#define free_unlocked(a) free_unlocked_fastcall(a)


extern void *malloc_unlocked(size_t size);
extern void *malloc_unlocked_fastcall(size_t size) __z88dk_fastcall;
#define malloc_unlocked(a) malloc_unlocked_fastcall(a)


extern void *realloc_unlocked(void *p,size_t size);
extern void *realloc_unlocked_callee(void *p,size_t size) __z88dk_callee;
#define realloc_unlocked(a,b) realloc_unlocked_callee(a,b)



#endif

#endif
