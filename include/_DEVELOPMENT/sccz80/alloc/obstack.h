
// automatically generated by m4 from headers in proto subdir


#ifndef __ALLOC_OBSTACK_H__
#define __ALLOC_OBSTACK_H__

#include <stddef.h>

// DATA STRUCTURES

struct obstack
{
   void       *fence;
   void       *object;
   void       *end;
};

extern void __LIB__ *obstack_1grow(struct obstack *ob,int c) __smallc;
extern void __LIB__ __CALLEE__ *obstack_1grow_callee(struct obstack *ob,int c) __smallc;
#define obstack_1grow(a,b) obstack_1grow_callee(a,b)


extern void __LIB__ *obstack_1grow_fast(struct obstack *ob,int c) __smallc;
extern void __LIB__ __CALLEE__ *obstack_1grow_fast_callee(struct obstack *ob,int c) __smallc;
#define obstack_1grow_fast(a,b) obstack_1grow_fast_callee(a,b)


extern size_t __LIB__ obstack_align_distance(struct obstack *ob,size_t alignment) __smallc;
extern size_t __LIB__ __CALLEE__ obstack_align_distance_callee(struct obstack *ob,size_t alignment) __smallc;
#define obstack_align_distance(a,b) obstack_align_distance_callee(a,b)


extern int __LIB__ obstack_align_to(struct obstack *ob,size_t alignment) __smallc;
extern int __LIB__ __CALLEE__ obstack_align_to_callee(struct obstack *ob,size_t alignment) __smallc;
#define obstack_align_to(a,b) obstack_align_to_callee(a,b)


extern void __LIB__ *obstack_alloc(struct obstack *ob,size_t size) __smallc;
extern void __LIB__ __CALLEE__ *obstack_alloc_callee(struct obstack *ob,size_t size) __smallc;
#define obstack_alloc(a,b) obstack_alloc_callee(a,b)


extern void __LIB__ __FASTCALL__ *obstack_base(struct obstack *ob) __smallc;


extern void __LIB__ *obstack_blank(struct obstack *ob,int size) __smallc;
extern void __LIB__ __CALLEE__ *obstack_blank_callee(struct obstack *ob,int size) __smallc;
#define obstack_blank(a,b) obstack_blank_callee(a,b)


extern void __LIB__ *obstack_blank_fast(struct obstack *ob,int size) __smallc;
extern void __LIB__ __CALLEE__ *obstack_blank_fast_callee(struct obstack *ob,int size) __smallc;
#define obstack_blank_fast(a,b) obstack_blank_fast_callee(a,b)


extern void __LIB__ *obstack_copy(struct obstack *ob,void *p,size_t size) __smallc;
extern void __LIB__ __CALLEE__ *obstack_copy_callee(struct obstack *ob,void *p,size_t size) __smallc;
#define obstack_copy(a,b,c) obstack_copy_callee(a,b,c)


extern void __LIB__ *obstack_copy0(struct obstack *ob,void *p,size_t size) __smallc;
extern void __LIB__ __CALLEE__ *obstack_copy0_callee(struct obstack *ob,void *p,size_t size) __smallc;
#define obstack_copy0(a,b,c) obstack_copy0_callee(a,b,c)


extern void __LIB__ __FASTCALL__ *obstack_finish(struct obstack *ob) __smallc;


extern void __LIB__ *obstack_free(struct obstack *ob,void *object) __smallc;
extern void __LIB__ __CALLEE__ *obstack_free_callee(struct obstack *ob,void *object) __smallc;
#define obstack_free(a,b) obstack_free_callee(a,b)


extern int __LIB__ obstack_grow(struct obstack *ob,void *data,size_t size) __smallc;
extern int __LIB__ __CALLEE__ obstack_grow_callee(struct obstack *ob,void *data,size_t size) __smallc;
#define obstack_grow(a,b,c) obstack_grow_callee(a,b,c)


extern int __LIB__ obstack_grow0(struct obstack *ob,void *data,size_t size) __smallc;
extern int __LIB__ __CALLEE__ obstack_grow0_callee(struct obstack *ob,void *data,size_t size) __smallc;
#define obstack_grow0(a,b,c) obstack_grow0_callee(a,b,c)


extern void __LIB__ *obstack_init(struct obstack *ob,size_t size) __smallc;
extern void __LIB__ __CALLEE__ *obstack_init_callee(struct obstack *ob,size_t size) __smallc;
#define obstack_init(a,b) obstack_init_callee(a,b)


extern void __LIB__ *obstack_int_grow(struct obstack *ob,int data) __smallc;
extern void __LIB__ __CALLEE__ *obstack_int_grow_callee(struct obstack *ob,int data) __smallc;
#define obstack_int_grow(a,b) obstack_int_grow_callee(a,b)


extern void __LIB__ *obstack_int_grow_fast(struct obstack *ob,int data) __smallc;
extern void __LIB__ __CALLEE__ *obstack_int_grow_fast_callee(struct obstack *ob,int data) __smallc;
#define obstack_int_grow_fast(a,b) obstack_int_grow_fast_callee(a,b)


extern void __LIB__ __FASTCALL__ *obstack_next_free(struct obstack *ob) __smallc;


extern size_t __LIB__ __FASTCALL__ obstack_object_size(struct obstack *ob) __smallc;


extern size_t __LIB__ __FASTCALL__ obstack_room(struct obstack *ob) __smallc;



#endif
