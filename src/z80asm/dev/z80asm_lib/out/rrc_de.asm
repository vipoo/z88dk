;------------------------------------------------------------------------------
; z80asm library
; Emulate 'rrc de' instruction, only carry is affected
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__rrc_de

__z80asm__rrc_de:

IF __CPU_INTEL__
      push  af
      ld    a, e
      rra                  ; bit 0 of C into carry
      
      ld    a, d
      rra   
      ld    d, a

      ld    a, e
      rra   
      ld    e, a

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
      bit   0, e          ; bit 0 of C into carry
      jr    z, in_carry_0
      scf
in_carry_0:                    
      rr    d             ; rotate B, bit 0 of C into bit 7 of B
      rr    e             ; rotate C
      ret   
ENDIF 
