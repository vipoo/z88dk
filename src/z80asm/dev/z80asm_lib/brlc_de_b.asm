;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80n 'brlc de, b' instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__brlc_de_b
      EXTERN   __z80asm__rlc_de

__z80asm__brlc_de_b:
      push  af
      ld    a, b
      and   0x0f
      jr    z, end_shift
shift:
      call  __z80asm__rlc_de
      dec   a
      jr    nz, shift

end_shift:
      pop   af
      ret   
