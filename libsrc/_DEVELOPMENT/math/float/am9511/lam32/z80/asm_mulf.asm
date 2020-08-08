
; float _mulf (float left, float right) __z88dk_callee

SECTION code_clib
SECTION code_fp_am9511

PUBLIC asm_mulf

EXTERN asm_am9511_mul_callee

    ; multiply two sccz80 floats
    ;
    ; enter : stack = sccz80_float left, ret
    ;          DEHL = sccz80_float right
    ;
    ; exit  :  DEHL = sccz80_float(left*right)
    ;
    ; uses  : af, bc, de, hl, af', bc', de', hl'

DEFC  asm_mulf = asm_am9511_mul_callee          ; enter stack = am32_float left
                                                ;        DEHL = am32_float right
                                                ; return DEHL = am32_float
