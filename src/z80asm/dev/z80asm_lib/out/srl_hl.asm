;------------------------------------------------------------------------------
; z80asm library
; Emulate 'srl hl' instruction, only carry is affected
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__srl_hl

__z80asm__srl_hl:

IF __CPU_INTEL__
      push  af

      ld    a, h
      and   a
      rra   
      ld    h, a

      ld    a, l
      rra   
      ld    l, a

      jr    nc, carry0
      pop   af
      scf   
      ret   
carry0:
      pop   af
      and   a
      ret   
ELSE  
      srl   h
      rr    l
      ret   
ENDIF 

