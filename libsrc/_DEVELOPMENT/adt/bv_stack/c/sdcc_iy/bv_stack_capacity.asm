
; size_t bv_stack_capacity(bv_stack_t *s)

SECTION code_adt_bv_stack

PUBLIC _bv_stack_capacity

EXTERN _b_vector_capacity

defc _bv_stack_capacity = _b_vector_capacity

INCLUDE "adt/bv_stack/z80/asm_bv_stack_capacity.asm"
