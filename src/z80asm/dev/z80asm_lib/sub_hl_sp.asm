;------------------------------------------------------------------------------
; z80asm library
; Substitute for 'sbc hl, sp' instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__sub_hl_sp

__z80asm__sub_hl_sp:
      push  bc
      ld    b, a
      push  de
      ex    de, hl            ; subtrahed to de

IF __CPU_GBZ80__
      ld    hl, sp+6          ; minuend to hl, compensate for return address, DE and BC in stack
ELSE  
      push  af
      ld    hl, 8             ; minuend to hl, compensate for return address, DE, BC and AF in stack
      add   hl, sp
      pop   af
ENDIF 
      ld    a, e
      sub   a, l
      ld    e, a

      ld    a, d
      sbc   a, h
      ld    d, a

      ex    de, hl
      pop   de
      ld    a, b
      pop   bc
      ret   
