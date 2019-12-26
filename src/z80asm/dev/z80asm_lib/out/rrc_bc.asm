;------------------------------------------------------------------------------
; z80asm library
; Emulate 'rrc bc' instruction, only carry is affected
; Copyright (C) Paulo Custodio, 2011-2020
; License: http://www.perlfoundation.org/artistic_license_2_0
; Repository: https://github.com/z88dk/z88dk
;------------------------------------------------------------------------------
      SECTION  code_crt0_sccz80
      PUBLIC   __z80asm__rrc_bc

__z80asm__rrc_bc:

IF __CPU_INTEL__
      push  af
      ld    a, c
      rra                     ; bit 0 of C into carry

      ld    a, b
      rra   
      ld    b, a

      ld    a, c
      rra   
      ld    c, a

      jr    nc, out_carry_0
      pop   af
      scf   
      ret   
out_carry_0:
      pop   af
      and   a
      ret   
ELSE  
      and   a                 ; clear carry
      bit   0, c              ; bit 0 of C into carry
      jr    z, in_carry_0
      scf   
in_carry_0:
      rr    b                 ; rotate B, bit 0 of C into bit 7 of B
      rr    c                 ; rotate C
      ret   
ENDIF 
