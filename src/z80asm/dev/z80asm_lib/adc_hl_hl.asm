;------------------------------------------------------------------------------
; z80asm library
; Substitute for the z80 adc hl,hl instruction
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__adc_hl_hl

__z80asm__adc_hl_hl:
      push  de

IF __CPU_INTEL__
      push  af
      ld    a, 0
      ld    d, a
      rla   
      ld    e, a
      pop   af
ELSE  
      ld    de, 0
      rl    e                 ; de = carry
ENDIF 
      add   hl, hl
      add   hl, de

      pop   de
      ret   
