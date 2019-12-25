;------------------------------------------------------------------------------
; z80asm library
; Substitute for 'sub hl, de' instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__sub_hl_hl

__z80asm__sub_hl_hl:
      push  de
      ld    d, a

      ld    a, l
      sub   a, l
      ld    l, a

      ld    a, h
      sbc   a, h
      ld    h, a

      ld    a, d
      pop   de
      ret   
