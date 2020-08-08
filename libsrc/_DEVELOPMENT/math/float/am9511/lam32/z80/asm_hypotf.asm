
; float _hypotf (float left, float right) __z88dk_callee

SECTION code_clib
SECTION code_fp_am9511

PUBLIC asm_hypotf

EXTERN asm_am9511_hypot_callee

    ; find the hypotenuse of two sccz80 floats
    ;
    ; enter : stack = sccz80_float left, ret
    ;          DEHL = sccz80_float right
    ;
    ; exit  :  DEHL = sccz80_float(left+right)
    ;
    ; uses  : af, bc, de, hl, af', bc', de', hl'

DEFC  asm_hypotf = asm_am9511_hypot_callee  ; enter stack = am32_float left
                                            ;        DEHL = am32_float right
                                            ; return DEHL = am32_float
