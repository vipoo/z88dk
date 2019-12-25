;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80 add de,a instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__add_de_a

__z80asm__add_de_a:
      push  af

      add   a, e
      ld    e, a

      ld    a, d
      adc   a, 0
      ld    d, a

      pop   af
      ret   
