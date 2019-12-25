;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80n 'bsla de, b' instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__bsla_de_b

__z80asm__bsla_de_b:
      push  af

      ld    a, b
      and   0x1f
      jr    z, end_shift

      ex    de, hl            ; value to shift to hl
shift:
      add   hl, hl
      dec   a
      jr    nz, shift
      ex    de, hl            ; value to shift back to de

end_shift:
      pop   af
      ret   
