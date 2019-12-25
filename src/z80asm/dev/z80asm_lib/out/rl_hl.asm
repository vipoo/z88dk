;------------------------------------------------------------------------------
; z80asm library
; Emulate 'rl hl' instruction, only carry is affected
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__rl_hl

__z80asm__rl_hl:

IF __CPU_INTEL__
      push  af

      ld    a, l
      rla   
      ld    l, a

      ld    a, h
      rla   
      ld    h, a

      jr    nc, carry0
      pop   af
      scf   
      ret   
carry0:
      pop   af
      and   a
      ret   
ELSE  
      rl    l
      rl    h
      ret   
ENDIF 

