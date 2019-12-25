;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80 ldir instruction
; Doesn't emulate the flags correctly
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__ldir

__z80asm__ldir:
      push  af
loop:
IF __CPU_GBZ80__
      ld    a, (hl+)
ELSE  
      ld    a, (hl)
      inc   hl
ENDIF 
      ld    (de), a
      inc   de
      dec   bc
      ld    a, b
      or    c
      jr    nz, loop
      pop   af
      ret   
