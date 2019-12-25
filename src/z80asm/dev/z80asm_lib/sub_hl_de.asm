;------------------------------------------------------------------------------
; z80asm library
; Substitute for 'sub hl, de' instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__sub_hl_de

__z80asm__sub_hl_de:
      push  bc
      ld    b, a

      ld    a, l
      sub   a, e
      ld    l, a

      ld    a, h
      sbc   a, d
      ld    h, a

      ld    a, b
      pop   bc
      ret   
