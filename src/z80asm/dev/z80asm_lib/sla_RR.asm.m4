;------------------------------------------------------------------------------
; z80asm library
; Emulate 'sla _RR' instruction, only carry is affected
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
dnl                                 input: _RR: register pair bc/de/hl
define(`_H', substr(_RR, 0, 1))dnl  extract high...
define(`_L', substr(_RR, 1, 1))dnl  ... and low registers
dnl
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__sla_`'_RR

__z80asm__sla_`'_RR:

IF __CPU_INTEL__
      push  af

      ld    a, _L
      and   a
      rla   
      ld    _L, a

      ld    a, _H
      rla   
      ld    _H, a

      jr    nc, carry0
      pop   af
      scf   
      ret   
carry0:
      pop   af
      and   a
      ret   
ELSE  
      sla   _L
      rl    _H
      ret   
ENDIF 

