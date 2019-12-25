;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80n 'bsrl de, b' instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__bsrl_de_b
      EXTERN   __z80asm__srl_de

__z80asm__bsrl_de_b:
      push  af

      ld    a, b
      and   0x1f
      jr    z, end_shift

shift:
IF __CPU_INTEL__
      call  __z80asm__srl_de
ELSE  
      srl   d
      rr    e
ENDIF 
      dec   a
      jr    nz, shift

end_shift:
      pop   af
      ret   
