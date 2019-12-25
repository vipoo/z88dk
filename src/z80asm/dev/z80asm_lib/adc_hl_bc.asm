;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80 adc hl,bc instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__adc_hl_bc

__z80asm__adc_hl_bc:
      jr    nc, carry0
      inc   hl
carry0:
      add   hl, bc
      ret   
