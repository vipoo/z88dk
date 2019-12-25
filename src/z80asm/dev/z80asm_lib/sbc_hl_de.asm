;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80 sbc hl,de instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__sbc_hl_de

__z80asm__sbc_hl_de:
      push  bc
      ld    b, a

      ld    a, l
      sbc   a, e
      ld    l, a

      ld    a, h
      sbc   a, d
      ld    h, a

      ld    a, b
      pop   bc
      ret   
