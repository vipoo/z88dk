;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80 add bc,a instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__add_bc_a

__z80asm__add_bc_a:
      push  af

      add   a, c
      ld    c, a

      ld    a, b
      adc   a, 0
      ld    b, a

      pop   af
      ret   
