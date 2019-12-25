;------------------------------------------------------------------------------
; z80asm library
; Emulate 'srl de' instruction, only carry is affected
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__srl_de

__z80asm__srl_de:

IF __CPU_INTEL__
      push  af

      ld    a, d
      and   a
      rra   
      ld    d, a

      ld    a, e
      rra   
      ld    e, a

      jr    nc, carry0
      pop   af
      scf   
      ret   
carry0:
      pop   af
      and   a
      ret   
ELSE  
      srl   d
      rr    e
      ret   
ENDIF 

