;------------------------------------------------------------------------------
; z80asm library
; Emulate 'rlc hl' instruction, only carry is affected
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__rlc_hl

__z80asm__rlc_hl:

IF __CPU_INTEL__
      push  af
      ld    a, h
      rla                  ; bit 7 of B into carry
      
      ld    a, l
      rla   
      ld    l, a

      ld    a, h
      rla   
      ld    h, a

      jr    nc, out_carry_0
      pop   af
      scf   
      ret   
out_carry_0:
      pop   af
      and   a
      ret   
ELSE  
      and   a              ; clear carry
      bit   7, h          ; bit 7 of B into carry
      jr    z, in_carry_0
      scf
in_carry_0:                    
      rl    l             ; rotate C, bit 7 of B into bit 0 of C
      rl    h             ; rotate B
      ret   
ENDIF 
