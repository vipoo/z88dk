;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80 sbc hl,hl instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__sbc_hl_hl

__z80asm__sbc_hl_hl:
      ld    hl, 0
      ret   nc
      dec   hl
      ret   
