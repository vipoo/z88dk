 adc (ix)                       ; Error
 adc (ix+-128)                  ; Error
 adc (ix+127)                   ; Error
 adc (iy)                       ; Error
 adc (iy+-128)                  ; Error
 adc (iy+127)                   ; Error
 adc a, (ix)                    ; Error
 adc a, (ix+-128)               ; Error
 adc a, (ix+127)                ; Error
 adc a, (iy)                    ; Error
 adc a, (iy+-128)               ; Error
 adc a, (iy+127)                ; Error
 add (ix)                       ; Error
 add (ix+-128)                  ; Error
 add (ix+127)                   ; Error
 add (iy)                       ; Error
 add (iy+-128)                  ; Error
 add (iy+127)                   ; Error
 add a, (ix)                    ; Error
 add a, (ix+-128)               ; Error
 add a, (ix+127)                ; Error
 add a, (iy)                    ; Error
 add a, (iy+-128)               ; Error
 add a, (iy+127)                ; Error
 add ix, bc                     ; Error
 add ix, de                     ; Error
 add ix, ix                     ; Error
 add ix, sp                     ; Error
 add iy, bc                     ; Error
 add iy, de                     ; Error
 add iy, iy                     ; Error
 add iy, sp                     ; Error
 add sp, -128                   ; Error
 add sp, 127                    ; Error
 and (ix)                       ; Error
 and (ix+-128)                  ; Error
 and (ix+127)                   ; Error
 and (iy)                       ; Error
 and (iy+-128)                  ; Error
 and (iy+127)                   ; Error
 and a, (ix)                    ; Error
 and a, (ix+-128)               ; Error
 and a, (ix+127)                ; Error
 and a, (iy)                    ; Error
 and a, (iy+-128)               ; Error
 and a, (iy+127)                ; Error
 bit %c, (hl)                   ; Error
 bit %c, (ix)                   ; Error
 bit %c, (ix+-128)              ; Error
 bit %c, (ix+127)               ; Error
 bit %c, (iy)                   ; Error
 bit %c, (iy+-128)              ; Error
 bit %c, (iy+127)               ; Error
 bit %c, a                      ; Error
 bit %c, b                      ; Error
 bit %c, c                      ; Error
 bit %c, d                      ; Error
 bit %c, e                      ; Error
 bit %c, h                      ; Error
 bit %c, l                      ; Error
 cmp (ix)                       ; Error
 cmp (ix+-128)                  ; Error
 cmp (ix+127)                   ; Error
 cmp (iy)                       ; Error
 cmp (iy+-128)                  ; Error
 cmp (iy+127)                   ; Error
 cmp a, (ix)                    ; Error
 cmp a, (ix+-128)               ; Error
 cmp a, (ix+127)                ; Error
 cmp a, (iy)                    ; Error
 cmp a, (iy+-128)               ; Error
 cmp a, (iy+127)                ; Error
 cp (ix)                        ; Error
 cp (ix+-128)                   ; Error
 cp (ix+127)                    ; Error
 cp (iy)                        ; Error
 cp (iy+-128)                   ; Error
 cp (iy+127)                    ; Error
 cp a, (ix)                     ; Error
 cp a, (ix+-128)                ; Error
 cp a, (ix+127)                 ; Error
 cp a, (iy)                     ; Error
 cp a, (iy+-128)                ; Error
 cp a, (iy+127)                 ; Error
 dec (ix)                       ; Error
 dec (ix+-128)                  ; Error
 dec (ix+127)                   ; Error
 dec (iy)                       ; Error
 dec (iy+-128)                  ; Error
 dec (iy+127)                   ; Error
 dec ix                         ; Error
 dec iy                         ; Error
 djnz %j                        ; Error
 djnz b, %j                     ; Error
 ex (sp), ix                    ; Error
 ex (sp), iy                    ; Error
 ex af, af                      ; Error
 ex af, af'                     ; Error
 exx                            ; Error
 im %c                          ; Error
 in (c)                         ; Error
 in a, (c)                      ; Error
 in b, (c)                      ; Error
 in c, (c)                      ; Error
 in d, (c)                      ; Error
 in e, (c)                      ; Error
 in f, (c)                      ; Error
 in h, (c)                      ; Error
 in l, (c)                      ; Error
 inc (ix)                       ; Error
 inc (ix+-128)                  ; Error
 inc (ix+127)                   ; Error
 inc (iy)                       ; Error
 inc (iy+-128)                  ; Error
 inc (iy+127)                   ; Error
 inc ix                         ; Error
 inc iy                         ; Error
 ind                            ; Error
 indr                           ; Error
 ini                            ; Error
 inir                           ; Error
 jp (c)                         ; Error
 jp (ix)                        ; Error
 jp (iy)                        ; Error
 jr %j                          ; Error
 jr c, %j                       ; Error
 jr nc, %j                      ; Error
 jr nz, %j                      ; Error
 jr z, %j                       ; Error
 ld (-32768), bc                ; Error
 ld (-32768), de                ; Error
 ld (-32768), ix                ; Error
 ld (-32768), iy                ; Error
 ld (-32768), sp                ; Error
 ld (32767), bc                 ; Error
 ld (32767), de                 ; Error
 ld (32767), ix                 ; Error
 ld (32767), iy                 ; Error
 ld (32767), sp                 ; Error
 ld (65535), bc                 ; Error
 ld (65535), de                 ; Error
 ld (65535), ix                 ; Error
 ld (65535), iy                 ; Error
 ld (65535), sp                 ; Error
 ld (c), a                      ; Error
 ld (hld), a                    ; Error
 ld (hli), a                    ; Error
 ld (ix), -128                  ; Error
 ld (ix), 127                   ; Error
 ld (ix), 255                   ; Error
 ld (ix), a                     ; Error
 ld (ix), b                     ; Error
 ld (ix), c                     ; Error
 ld (ix), d                     ; Error
 ld (ix), e                     ; Error
 ld (ix), h                     ; Error
 ld (ix), l                     ; Error
 ld (ix+-128), -128             ; Error
 ld (ix+-128), 127              ; Error
 ld (ix+-128), 255              ; Error
 ld (ix+-128), a                ; Error
 ld (ix+-128), b                ; Error
 ld (ix+-128), c                ; Error
 ld (ix+-128), d                ; Error
 ld (ix+-128), e                ; Error
 ld (ix+-128), h                ; Error
 ld (ix+-128), l                ; Error
 ld (ix+127), -128              ; Error
 ld (ix+127), 127               ; Error
 ld (ix+127), 255               ; Error
 ld (ix+127), a                 ; Error
 ld (ix+127), b                 ; Error
 ld (ix+127), c                 ; Error
 ld (ix+127), d                 ; Error
 ld (ix+127), e                 ; Error
 ld (ix+127), h                 ; Error
 ld (ix+127), l                 ; Error
 ld (iy), -128                  ; Error
 ld (iy), 127                   ; Error
 ld (iy), 255                   ; Error
 ld (iy), a                     ; Error
 ld (iy), b                     ; Error
 ld (iy), c                     ; Error
 ld (iy), d                     ; Error
 ld (iy), e                     ; Error
 ld (iy), h                     ; Error
 ld (iy), l                     ; Error
 ld (iy+-128), -128             ; Error
 ld (iy+-128), 127              ; Error
 ld (iy+-128), 255              ; Error
 ld (iy+-128), a                ; Error
 ld (iy+-128), b                ; Error
 ld (iy+-128), c                ; Error
 ld (iy+-128), d                ; Error
 ld (iy+-128), e                ; Error
 ld (iy+-128), h                ; Error
 ld (iy+-128), l                ; Error
 ld (iy+127), -128              ; Error
 ld (iy+127), 127               ; Error
 ld (iy+127), 255               ; Error
 ld (iy+127), a                 ; Error
 ld (iy+127), b                 ; Error
 ld (iy+127), c                 ; Error
 ld (iy+127), d                 ; Error
 ld (iy+127), e                 ; Error
 ld (iy+127), h                 ; Error
 ld (iy+127), l                 ; Error
 ld a, (c)                      ; Error
 ld a, (hld)                    ; Error
 ld a, (hli)                    ; Error
 ld a, (ix)                     ; Error
 ld a, (ix+-128)                ; Error
 ld a, (ix+127)                 ; Error
 ld a, (iy)                     ; Error
 ld a, (iy+-128)                ; Error
 ld a, (iy+127)                 ; Error
 ld a, i                        ; Error
 ld a, ixh                      ; Error
 ld a, ixl                      ; Error
 ld a, iyh                      ; Error
 ld a, iyl                      ; Error
 ld a, r                        ; Error
 ld b, (ix)                     ; Error
 ld b, (ix+-128)                ; Error
 ld b, (ix+127)                 ; Error
 ld b, (iy)                     ; Error
 ld b, (iy+-128)                ; Error
 ld b, (iy+127)                 ; Error
 ld b, ixh                      ; Error
 ld b, ixl                      ; Error
 ld b, iyh                      ; Error
 ld b, iyl                      ; Error
 ld bc, (-32768)                ; Error
 ld bc, (32767)                 ; Error
 ld bc, (65535)                 ; Error
 ld bc, ix                      ; Error
 ld bc, iy                      ; Error
 ld c, (ix)                     ; Error
 ld c, (ix+-128)                ; Error
 ld c, (ix+127)                 ; Error
 ld c, (iy)                     ; Error
 ld c, (iy+-128)                ; Error
 ld c, (iy+127)                 ; Error
 ld c, ixh                      ; Error
 ld c, ixl                      ; Error
 ld c, iyh                      ; Error
 ld c, iyl                      ; Error
 ld d, (ix)                     ; Error
 ld d, (ix+-128)                ; Error
 ld d, (ix+127)                 ; Error
 ld d, (iy)                     ; Error
 ld d, (iy+-128)                ; Error
 ld d, (iy+127)                 ; Error
 ld d, ixh                      ; Error
 ld d, ixl                      ; Error
 ld d, iyh                      ; Error
 ld d, iyl                      ; Error
 ld de, (-32768)                ; Error
 ld de, (32767)                 ; Error
 ld de, (65535)                 ; Error
 ld de, hl                      ; Error
 ld de, ix                      ; Error
 ld de, iy                      ; Error
 ld e, (ix)                     ; Error
 ld e, (ix+-128)                ; Error
 ld e, (ix+127)                 ; Error
 ld e, (iy)                     ; Error
 ld e, (iy+-128)                ; Error
 ld e, (iy+127)                 ; Error
 ld e, ixh                      ; Error
 ld e, ixl                      ; Error
 ld e, iyh                      ; Error
 ld e, iyl                      ; Error
 ld h, (ix)                     ; Error
 ld h, (ix+-128)                ; Error
 ld h, (ix+127)                 ; Error
 ld h, (iy)                     ; Error
 ld h, (iy+-128)                ; Error
 ld h, (iy+127)                 ; Error
 ld hl, ix                      ; Error
 ld hl, iy                      ; Error
 ld i, a                        ; Error
 ld ix, (-32768)                ; Error
 ld ix, (32767)                 ; Error
 ld ix, (65535)                 ; Error
 ld ix, -32768                  ; Error
 ld ix, 32767                   ; Error
 ld ix, 65535                   ; Error
 ld ix, bc                      ; Error
 ld ix, de                      ; Error
 ld ix, hl                      ; Error
 ld ix, iy                      ; Error
 ld ixh, -128                   ; Error
 ld ixh, 127                    ; Error
 ld ixh, 255                    ; Error
 ld ixh, a                      ; Error
 ld ixh, b                      ; Error
 ld ixh, c                      ; Error
 ld ixh, d                      ; Error
 ld ixh, e                      ; Error
 ld ixh, ixh                    ; Error
 ld ixh, ixl                    ; Error
 ld ixl, -128                   ; Error
 ld ixl, 127                    ; Error
 ld ixl, 255                    ; Error
 ld ixl, a                      ; Error
 ld ixl, b                      ; Error
 ld ixl, c                      ; Error
 ld ixl, d                      ; Error
 ld ixl, e                      ; Error
 ld ixl, ixh                    ; Error
 ld ixl, ixl                    ; Error
 ld iy, (-32768)                ; Error
 ld iy, (32767)                 ; Error
 ld iy, (65535)                 ; Error
 ld iy, -32768                  ; Error
 ld iy, 32767                   ; Error
 ld iy, 65535                   ; Error
 ld iy, bc                      ; Error
 ld iy, de                      ; Error
 ld iy, hl                      ; Error
 ld iy, ix                      ; Error
 ld iyh, -128                   ; Error
 ld iyh, 127                    ; Error
 ld iyh, 255                    ; Error
 ld iyh, a                      ; Error
 ld iyh, b                      ; Error
 ld iyh, c                      ; Error
 ld iyh, d                      ; Error
 ld iyh, e                      ; Error
 ld iyh, iyh                    ; Error
 ld iyh, iyl                    ; Error
 ld iyl, -128                   ; Error
 ld iyl, 127                    ; Error
 ld iyl, 255                    ; Error
 ld iyl, a                      ; Error
 ld iyl, b                      ; Error
 ld iyl, c                      ; Error
 ld iyl, d                      ; Error
 ld iyl, e                      ; Error
 ld iyl, iyh                    ; Error
 ld iyl, iyl                    ; Error
 ld l, (ix)                     ; Error
 ld l, (ix+-128)                ; Error
 ld l, (ix+127)                 ; Error
 ld l, (iy)                     ; Error
 ld l, (iy+-128)                ; Error
 ld l, (iy+127)                 ; Error
 ld r, a                        ; Error
 ld sp, (-32768)                ; Error
 ld sp, (32767)                 ; Error
 ld sp, (65535)                 ; Error
 ld sp, ix                      ; Error
 ld sp, iy                      ; Error
 lddrx                          ; Error
 lddx                           ; Error
 ldh (-128), a                  ; Error
 ldh (127), a                   ; Error
 ldh (255), a                   ; Error
 ldh (c), a                     ; Error
 ldh a, (-128)                  ; Error
 ldh a, (127)                   ; Error
 ldh a, (255)                   ; Error
 ldh a, (c)                     ; Error
 ldhl sp, -128                  ; Error
 ldhl sp, 127                   ; Error
 ldirx                          ; Error
 ldix                           ; Error
 ldpirx                         ; Error
 ldws                           ; Error
 mirror a                       ; Error
 mlt de                         ; Error
 mul de                         ; Error
 nextreg -128, %N               ; Error
 nextreg -128, a                ; Error
 nextreg 127, %N                ; Error
 nextreg 127, a                 ; Error
 nextreg 255, %N                ; Error
 nextreg 255, a                 ; Error
 or (ix)                        ; Error
 or (ix+-128)                   ; Error
 or (ix+127)                    ; Error
 or (iy)                        ; Error
 or (iy+-128)                   ; Error
 or (iy+127)                    ; Error
 or a, (ix)                     ; Error
 or a, (ix+-128)                ; Error
 or a, (ix+127)                 ; Error
 or a, (iy)                     ; Error
 or a, (iy+-128)                ; Error
 or a, (iy+127)                 ; Error
 otdr                           ; Error
 otir                           ; Error
 out (c), %c                    ; Error
 out (c), a                     ; Error
 out (c), b                     ; Error
 out (c), c                     ; Error
 out (c), d                     ; Error
 out (c), e                     ; Error
 out (c), h                     ; Error
 out (c), l                     ; Error
 outd                           ; Error
 outi                           ; Error
 outinb                         ; Error
 pixelad                        ; Error
 pixeldn                        ; Error
 pop ix                         ; Error
 pop iy                         ; Error
 push %M                        ; Error
 push ix                        ; Error
 push iy                        ; Error
 res %c, (hl)                   ; Error
 res %c, (ix)                   ; Error
 res %c, (ix), a                ; Error
 res %c, (ix), b                ; Error
 res %c, (ix), c                ; Error
 res %c, (ix), d                ; Error
 res %c, (ix), e                ; Error
 res %c, (ix), h                ; Error
 res %c, (ix), l                ; Error
 res %c, (ix+-128)              ; Error
 res %c, (ix+-128), a           ; Error
 res %c, (ix+-128), b           ; Error
 res %c, (ix+-128), c           ; Error
 res %c, (ix+-128), d           ; Error
 res %c, (ix+-128), e           ; Error
 res %c, (ix+-128), h           ; Error
 res %c, (ix+-128), l           ; Error
 res %c, (ix+127)               ; Error
 res %c, (ix+127), a            ; Error
 res %c, (ix+127), b            ; Error
 res %c, (ix+127), c            ; Error
 res %c, (ix+127), d            ; Error
 res %c, (ix+127), e            ; Error
 res %c, (ix+127), h            ; Error
 res %c, (ix+127), l            ; Error
 res %c, (iy)                   ; Error
 res %c, (iy), a                ; Error
 res %c, (iy), b                ; Error
 res %c, (iy), c                ; Error
 res %c, (iy), d                ; Error
 res %c, (iy), e                ; Error
 res %c, (iy), h                ; Error
 res %c, (iy), l                ; Error
 res %c, (iy+-128)              ; Error
 res %c, (iy+-128), a           ; Error
 res %c, (iy+-128), b           ; Error
 res %c, (iy+-128), c           ; Error
 res %c, (iy+-128), d           ; Error
 res %c, (iy+-128), e           ; Error
 res %c, (iy+-128), h           ; Error
 res %c, (iy+-128), l           ; Error
 res %c, (iy+127)               ; Error
 res %c, (iy+127), a            ; Error
 res %c, (iy+127), b            ; Error
 res %c, (iy+127), c            ; Error
 res %c, (iy+127), d            ; Error
 res %c, (iy+127), e            ; Error
 res %c, (iy+127), h            ; Error
 res %c, (iy+127), l            ; Error
 res %c, a                      ; Error
 res %c, b                      ; Error
 res %c, c                      ; Error
 res %c, d                      ; Error
 res %c, e                      ; Error
 res %c, h                      ; Error
 res %c, l                      ; Error
 res a, %c, (ix)                ; Error
 res a, %c, (ix+-128)           ; Error
 res a, %c, (ix+127)            ; Error
 res a, %c, (iy)                ; Error
 res a, %c, (iy+-128)           ; Error
 res a, %c, (iy+127)            ; Error
 res b, %c, (ix)                ; Error
 res b, %c, (ix+-128)           ; Error
 res b, %c, (ix+127)            ; Error
 res b, %c, (iy)                ; Error
 res b, %c, (iy+-128)           ; Error
 res b, %c, (iy+127)            ; Error
 res c, %c, (ix)                ; Error
 res c, %c, (ix+-128)           ; Error
 res c, %c, (ix+127)            ; Error
 res c, %c, (iy)                ; Error
 res c, %c, (iy+-128)           ; Error
 res c, %c, (iy+127)            ; Error
 res d, %c, (ix)                ; Error
 res d, %c, (ix+-128)           ; Error
 res d, %c, (ix+127)            ; Error
 res d, %c, (iy)                ; Error
 res d, %c, (iy+-128)           ; Error
 res d, %c, (iy+127)            ; Error
 res e, %c, (ix)                ; Error
 res e, %c, (ix+-128)           ; Error
 res e, %c, (ix+127)            ; Error
 res e, %c, (iy)                ; Error
 res e, %c, (iy+-128)           ; Error
 res e, %c, (iy+127)            ; Error
 res h, %c, (ix)                ; Error
 res h, %c, (ix+-128)           ; Error
 res h, %c, (ix+127)            ; Error
 res h, %c, (iy)                ; Error
 res h, %c, (iy+-128)           ; Error
 res h, %c, (iy+127)            ; Error
 res l, %c, (ix)                ; Error
 res l, %c, (ix+-128)           ; Error
 res l, %c, (ix+127)            ; Error
 res l, %c, (iy)                ; Error
 res l, %c, (iy+-128)           ; Error
 res l, %c, (iy+127)            ; Error
 reti                           ; Error
 retn                           ; Error
 rl (hl)                        ; Error
 rl (ix)                        ; Error
 rl (ix), a                     ; Error
 rl (ix), b                     ; Error
 rl (ix), c                     ; Error
 rl (ix), d                     ; Error
 rl (ix), e                     ; Error
 rl (ix), h                     ; Error
 rl (ix), l                     ; Error
 rl (ix+-128)                   ; Error
 rl (ix+-128), a                ; Error
 rl (ix+-128), b                ; Error
 rl (ix+-128), c                ; Error
 rl (ix+-128), d                ; Error
 rl (ix+-128), e                ; Error
 rl (ix+-128), h                ; Error
 rl (ix+-128), l                ; Error
 rl (ix+127)                    ; Error
 rl (ix+127), a                 ; Error
 rl (ix+127), b                 ; Error
 rl (ix+127), c                 ; Error
 rl (ix+127), d                 ; Error
 rl (ix+127), e                 ; Error
 rl (ix+127), h                 ; Error
 rl (ix+127), l                 ; Error
 rl (iy)                        ; Error
 rl (iy), a                     ; Error
 rl (iy), b                     ; Error
 rl (iy), c                     ; Error
 rl (iy), d                     ; Error
 rl (iy), e                     ; Error
 rl (iy), h                     ; Error
 rl (iy), l                     ; Error
 rl (iy+-128)                   ; Error
 rl (iy+-128), a                ; Error
 rl (iy+-128), b                ; Error
 rl (iy+-128), c                ; Error
 rl (iy+-128), d                ; Error
 rl (iy+-128), e                ; Error
 rl (iy+-128), h                ; Error
 rl (iy+-128), l                ; Error
 rl (iy+127)                    ; Error
 rl (iy+127), a                 ; Error
 rl (iy+127), b                 ; Error
 rl (iy+127), c                 ; Error
 rl (iy+127), d                 ; Error
 rl (iy+127), e                 ; Error
 rl (iy+127), h                 ; Error
 rl (iy+127), l                 ; Error
 rl a                           ; Error
 rl a, (ix)                     ; Error
 rl a, (ix+-128)                ; Error
 rl a, (ix+127)                 ; Error
 rl a, (iy)                     ; Error
 rl a, (iy+-128)                ; Error
 rl a, (iy+127)                 ; Error
 rl b                           ; Error
 rl b, (ix)                     ; Error
 rl b, (ix+-128)                ; Error
 rl b, (ix+127)                 ; Error
 rl b, (iy)                     ; Error
 rl b, (iy+-128)                ; Error
 rl b, (iy+127)                 ; Error
 rl c                           ; Error
 rl c, (ix)                     ; Error
 rl c, (ix+-128)                ; Error
 rl c, (ix+127)                 ; Error
 rl c, (iy)                     ; Error
 rl c, (iy+-128)                ; Error
 rl c, (iy+127)                 ; Error
 rl d                           ; Error
 rl d, (ix)                     ; Error
 rl d, (ix+-128)                ; Error
 rl d, (ix+127)                 ; Error
 rl d, (iy)                     ; Error
 rl d, (iy+-128)                ; Error
 rl d, (iy+127)                 ; Error
 rl e                           ; Error
 rl e, (ix)                     ; Error
 rl e, (ix+-128)                ; Error
 rl e, (ix+127)                 ; Error
 rl e, (iy)                     ; Error
 rl e, (iy+-128)                ; Error
 rl e, (iy+127)                 ; Error
 rl h                           ; Error
 rl h, (ix)                     ; Error
 rl h, (ix+-128)                ; Error
 rl h, (ix+127)                 ; Error
 rl h, (iy)                     ; Error
 rl h, (iy+-128)                ; Error
 rl h, (iy+127)                 ; Error
 rl l                           ; Error
 rl l, (ix)                     ; Error
 rl l, (ix+-128)                ; Error
 rl l, (ix+127)                 ; Error
 rl l, (iy)                     ; Error
 rl l, (iy+-128)                ; Error
 rl l, (iy+127)                 ; Error
 rlc (hl)                       ; Error
 rlc (ix)                       ; Error
 rlc (ix), a                    ; Error
 rlc (ix), b                    ; Error
 rlc (ix), c                    ; Error
 rlc (ix), d                    ; Error
 rlc (ix), e                    ; Error
 rlc (ix), h                    ; Error
 rlc (ix), l                    ; Error
 rlc (ix+-128)                  ; Error
 rlc (ix+-128), a               ; Error
 rlc (ix+-128), b               ; Error
 rlc (ix+-128), c               ; Error
 rlc (ix+-128), d               ; Error
 rlc (ix+-128), e               ; Error
 rlc (ix+-128), h               ; Error
 rlc (ix+-128), l               ; Error
 rlc (ix+127)                   ; Error
 rlc (ix+127), a                ; Error
 rlc (ix+127), b                ; Error
 rlc (ix+127), c                ; Error
 rlc (ix+127), d                ; Error
 rlc (ix+127), e                ; Error
 rlc (ix+127), h                ; Error
 rlc (ix+127), l                ; Error
 rlc (iy)                       ; Error
 rlc (iy), a                    ; Error
 rlc (iy), b                    ; Error
 rlc (iy), c                    ; Error
 rlc (iy), d                    ; Error
 rlc (iy), e                    ; Error
 rlc (iy), h                    ; Error
 rlc (iy), l                    ; Error
 rlc (iy+-128)                  ; Error
 rlc (iy+-128), a               ; Error
 rlc (iy+-128), b               ; Error
 rlc (iy+-128), c               ; Error
 rlc (iy+-128), d               ; Error
 rlc (iy+-128), e               ; Error
 rlc (iy+-128), h               ; Error
 rlc (iy+-128), l               ; Error
 rlc (iy+127)                   ; Error
 rlc (iy+127), a                ; Error
 rlc (iy+127), b                ; Error
 rlc (iy+127), c                ; Error
 rlc (iy+127), d                ; Error
 rlc (iy+127), e                ; Error
 rlc (iy+127), h                ; Error
 rlc (iy+127), l                ; Error
 rlc a                          ; Error
 rlc a, (ix)                    ; Error
 rlc a, (ix+-128)               ; Error
 rlc a, (ix+127)                ; Error
 rlc a, (iy)                    ; Error
 rlc a, (iy+-128)               ; Error
 rlc a, (iy+127)                ; Error
 rlc b                          ; Error
 rlc b, (ix)                    ; Error
 rlc b, (ix+-128)               ; Error
 rlc b, (ix+127)                ; Error
 rlc b, (iy)                    ; Error
 rlc b, (iy+-128)               ; Error
 rlc b, (iy+127)                ; Error
 rlc c                          ; Error
 rlc c, (ix)                    ; Error
 rlc c, (ix+-128)               ; Error
 rlc c, (ix+127)                ; Error
 rlc c, (iy)                    ; Error
 rlc c, (iy+-128)               ; Error
 rlc c, (iy+127)                ; Error
 rlc d                          ; Error
 rlc d, (ix)                    ; Error
 rlc d, (ix+-128)               ; Error
 rlc d, (ix+127)                ; Error
 rlc d, (iy)                    ; Error
 rlc d, (iy+-128)               ; Error
 rlc d, (iy+127)                ; Error
 rlc e                          ; Error
 rlc e, (ix)                    ; Error
 rlc e, (ix+-128)               ; Error
 rlc e, (ix+127)                ; Error
 rlc e, (iy)                    ; Error
 rlc e, (iy+-128)               ; Error
 rlc e, (iy+127)                ; Error
 rlc h                          ; Error
 rlc h, (ix)                    ; Error
 rlc h, (ix+-128)               ; Error
 rlc h, (ix+127)                ; Error
 rlc h, (iy)                    ; Error
 rlc h, (iy+-128)               ; Error
 rlc h, (iy+127)                ; Error
 rlc l                          ; Error
 rlc l, (ix)                    ; Error
 rlc l, (ix+-128)               ; Error
 rlc l, (ix+127)                ; Error
 rlc l, (iy)                    ; Error
 rlc l, (iy+-128)               ; Error
 rlc l, (iy+127)                ; Error
 rr (hl)                        ; Error
 rr (ix)                        ; Error
 rr (ix), a                     ; Error
 rr (ix), b                     ; Error
 rr (ix), c                     ; Error
 rr (ix), d                     ; Error
 rr (ix), e                     ; Error
 rr (ix), h                     ; Error
 rr (ix), l                     ; Error
 rr (ix+-128)                   ; Error
 rr (ix+-128), a                ; Error
 rr (ix+-128), b                ; Error
 rr (ix+-128), c                ; Error
 rr (ix+-128), d                ; Error
 rr (ix+-128), e                ; Error
 rr (ix+-128), h                ; Error
 rr (ix+-128), l                ; Error
 rr (ix+127)                    ; Error
 rr (ix+127), a                 ; Error
 rr (ix+127), b                 ; Error
 rr (ix+127), c                 ; Error
 rr (ix+127), d                 ; Error
 rr (ix+127), e                 ; Error
 rr (ix+127), h                 ; Error
 rr (ix+127), l                 ; Error
 rr (iy)                        ; Error
 rr (iy), a                     ; Error
 rr (iy), b                     ; Error
 rr (iy), c                     ; Error
 rr (iy), d                     ; Error
 rr (iy), e                     ; Error
 rr (iy), h                     ; Error
 rr (iy), l                     ; Error
 rr (iy+-128)                   ; Error
 rr (iy+-128), a                ; Error
 rr (iy+-128), b                ; Error
 rr (iy+-128), c                ; Error
 rr (iy+-128), d                ; Error
 rr (iy+-128), e                ; Error
 rr (iy+-128), h                ; Error
 rr (iy+-128), l                ; Error
 rr (iy+127)                    ; Error
 rr (iy+127), a                 ; Error
 rr (iy+127), b                 ; Error
 rr (iy+127), c                 ; Error
 rr (iy+127), d                 ; Error
 rr (iy+127), e                 ; Error
 rr (iy+127), h                 ; Error
 rr (iy+127), l                 ; Error
 rr a                           ; Error
 rr a, (ix)                     ; Error
 rr a, (ix+-128)                ; Error
 rr a, (ix+127)                 ; Error
 rr a, (iy)                     ; Error
 rr a, (iy+-128)                ; Error
 rr a, (iy+127)                 ; Error
 rr b                           ; Error
 rr b, (ix)                     ; Error
 rr b, (ix+-128)                ; Error
 rr b, (ix+127)                 ; Error
 rr b, (iy)                     ; Error
 rr b, (iy+-128)                ; Error
 rr b, (iy+127)                 ; Error
 rr c                           ; Error
 rr c, (ix)                     ; Error
 rr c, (ix+-128)                ; Error
 rr c, (ix+127)                 ; Error
 rr c, (iy)                     ; Error
 rr c, (iy+-128)                ; Error
 rr c, (iy+127)                 ; Error
 rr d                           ; Error
 rr d, (ix)                     ; Error
 rr d, (ix+-128)                ; Error
 rr d, (ix+127)                 ; Error
 rr d, (iy)                     ; Error
 rr d, (iy+-128)                ; Error
 rr d, (iy+127)                 ; Error
 rr e                           ; Error
 rr e, (ix)                     ; Error
 rr e, (ix+-128)                ; Error
 rr e, (ix+127)                 ; Error
 rr e, (iy)                     ; Error
 rr e, (iy+-128)                ; Error
 rr e, (iy+127)                 ; Error
 rr h                           ; Error
 rr h, (ix)                     ; Error
 rr h, (ix+-128)                ; Error
 rr h, (ix+127)                 ; Error
 rr h, (iy)                     ; Error
 rr h, (iy+-128)                ; Error
 rr h, (iy+127)                 ; Error
 rr l                           ; Error
 rr l, (ix)                     ; Error
 rr l, (ix+-128)                ; Error
 rr l, (ix+127)                 ; Error
 rr l, (iy)                     ; Error
 rr l, (iy+-128)                ; Error
 rr l, (iy+127)                 ; Error
 rrc (hl)                       ; Error
 rrc (ix)                       ; Error
 rrc (ix), a                    ; Error
 rrc (ix), b                    ; Error
 rrc (ix), c                    ; Error
 rrc (ix), d                    ; Error
 rrc (ix), e                    ; Error
 rrc (ix), h                    ; Error
 rrc (ix), l                    ; Error
 rrc (ix+-128)                  ; Error
 rrc (ix+-128), a               ; Error
 rrc (ix+-128), b               ; Error
 rrc (ix+-128), c               ; Error
 rrc (ix+-128), d               ; Error
 rrc (ix+-128), e               ; Error
 rrc (ix+-128), h               ; Error
 rrc (ix+-128), l               ; Error
 rrc (ix+127)                   ; Error
 rrc (ix+127), a                ; Error
 rrc (ix+127), b                ; Error
 rrc (ix+127), c                ; Error
 rrc (ix+127), d                ; Error
 rrc (ix+127), e                ; Error
 rrc (ix+127), h                ; Error
 rrc (ix+127), l                ; Error
 rrc (iy)                       ; Error
 rrc (iy), a                    ; Error
 rrc (iy), b                    ; Error
 rrc (iy), c                    ; Error
 rrc (iy), d                    ; Error
 rrc (iy), e                    ; Error
 rrc (iy), h                    ; Error
 rrc (iy), l                    ; Error
 rrc (iy+-128)                  ; Error
 rrc (iy+-128), a               ; Error
 rrc (iy+-128), b               ; Error
 rrc (iy+-128), c               ; Error
 rrc (iy+-128), d               ; Error
 rrc (iy+-128), e               ; Error
 rrc (iy+-128), h               ; Error
 rrc (iy+-128), l               ; Error
 rrc (iy+127)                   ; Error
 rrc (iy+127), a                ; Error
 rrc (iy+127), b                ; Error
 rrc (iy+127), c                ; Error
 rrc (iy+127), d                ; Error
 rrc (iy+127), e                ; Error
 rrc (iy+127), h                ; Error
 rrc (iy+127), l                ; Error
 rrc a                          ; Error
 rrc a, (ix)                    ; Error
 rrc a, (ix+-128)               ; Error
 rrc a, (ix+127)                ; Error
 rrc a, (iy)                    ; Error
 rrc a, (iy+-128)               ; Error
 rrc a, (iy+127)                ; Error
 rrc b                          ; Error
 rrc b, (ix)                    ; Error
 rrc b, (ix+-128)               ; Error
 rrc b, (ix+127)                ; Error
 rrc b, (iy)                    ; Error
 rrc b, (iy+-128)               ; Error
 rrc b, (iy+127)                ; Error
 rrc c                          ; Error
 rrc c, (ix)                    ; Error
 rrc c, (ix+-128)               ; Error
 rrc c, (ix+127)                ; Error
 rrc c, (iy)                    ; Error
 rrc c, (iy+-128)               ; Error
 rrc c, (iy+127)                ; Error
 rrc d                          ; Error
 rrc d, (ix)                    ; Error
 rrc d, (ix+-128)               ; Error
 rrc d, (ix+127)                ; Error
 rrc d, (iy)                    ; Error
 rrc d, (iy+-128)               ; Error
 rrc d, (iy+127)                ; Error
 rrc e                          ; Error
 rrc e, (ix)                    ; Error
 rrc e, (ix+-128)               ; Error
 rrc e, (ix+127)                ; Error
 rrc e, (iy)                    ; Error
 rrc e, (iy+-128)               ; Error
 rrc e, (iy+127)                ; Error
 rrc h                          ; Error
 rrc h, (ix)                    ; Error
 rrc h, (ix+-128)               ; Error
 rrc h, (ix+127)                ; Error
 rrc h, (iy)                    ; Error
 rrc h, (iy+-128)               ; Error
 rrc h, (iy+127)                ; Error
 rrc l                          ; Error
 rrc l, (ix)                    ; Error
 rrc l, (ix+-128)               ; Error
 rrc l, (ix+127)                ; Error
 rrc l, (iy)                    ; Error
 rrc l, (iy+-128)               ; Error
 rrc l, (iy+127)                ; Error
 sbc (ix)                       ; Error
 sbc (ix+-128)                  ; Error
 sbc (ix+127)                   ; Error
 sbc (iy)                       ; Error
 sbc (iy+-128)                  ; Error
 sbc (iy+127)                   ; Error
 sbc a, (ix)                    ; Error
 sbc a, (ix+-128)               ; Error
 sbc a, (ix+127)                ; Error
 sbc a, (iy)                    ; Error
 sbc a, (iy+-128)               ; Error
 sbc a, (iy+127)                ; Error
 set %c, (hl)                   ; Error
 set %c, (ix)                   ; Error
 set %c, (ix), a                ; Error
 set %c, (ix), b                ; Error
 set %c, (ix), c                ; Error
 set %c, (ix), d                ; Error
 set %c, (ix), e                ; Error
 set %c, (ix), h                ; Error
 set %c, (ix), l                ; Error
 set %c, (ix+-128)              ; Error
 set %c, (ix+-128), a           ; Error
 set %c, (ix+-128), b           ; Error
 set %c, (ix+-128), c           ; Error
 set %c, (ix+-128), d           ; Error
 set %c, (ix+-128), e           ; Error
 set %c, (ix+-128), h           ; Error
 set %c, (ix+-128), l           ; Error
 set %c, (ix+127)               ; Error
 set %c, (ix+127), a            ; Error
 set %c, (ix+127), b            ; Error
 set %c, (ix+127), c            ; Error
 set %c, (ix+127), d            ; Error
 set %c, (ix+127), e            ; Error
 set %c, (ix+127), h            ; Error
 set %c, (ix+127), l            ; Error
 set %c, (iy)                   ; Error
 set %c, (iy), a                ; Error
 set %c, (iy), b                ; Error
 set %c, (iy), c                ; Error
 set %c, (iy), d                ; Error
 set %c, (iy), e                ; Error
 set %c, (iy), h                ; Error
 set %c, (iy), l                ; Error
 set %c, (iy+-128)              ; Error
 set %c, (iy+-128), a           ; Error
 set %c, (iy+-128), b           ; Error
 set %c, (iy+-128), c           ; Error
 set %c, (iy+-128), d           ; Error
 set %c, (iy+-128), e           ; Error
 set %c, (iy+-128), h           ; Error
 set %c, (iy+-128), l           ; Error
 set %c, (iy+127)               ; Error
 set %c, (iy+127), a            ; Error
 set %c, (iy+127), b            ; Error
 set %c, (iy+127), c            ; Error
 set %c, (iy+127), d            ; Error
 set %c, (iy+127), e            ; Error
 set %c, (iy+127), h            ; Error
 set %c, (iy+127), l            ; Error
 set %c, a                      ; Error
 set %c, b                      ; Error
 set %c, c                      ; Error
 set %c, d                      ; Error
 set %c, e                      ; Error
 set %c, h                      ; Error
 set %c, l                      ; Error
 set a, %c, (ix)                ; Error
 set a, %c, (ix+-128)           ; Error
 set a, %c, (ix+127)            ; Error
 set a, %c, (iy)                ; Error
 set a, %c, (iy+-128)           ; Error
 set a, %c, (iy+127)            ; Error
 set b, %c, (ix)                ; Error
 set b, %c, (ix+-128)           ; Error
 set b, %c, (ix+127)            ; Error
 set b, %c, (iy)                ; Error
 set b, %c, (iy+-128)           ; Error
 set b, %c, (iy+127)            ; Error
 set c, %c, (ix)                ; Error
 set c, %c, (ix+-128)           ; Error
 set c, %c, (ix+127)            ; Error
 set c, %c, (iy)                ; Error
 set c, %c, (iy+-128)           ; Error
 set c, %c, (iy+127)            ; Error
 set d, %c, (ix)                ; Error
 set d, %c, (ix+-128)           ; Error
 set d, %c, (ix+127)            ; Error
 set d, %c, (iy)                ; Error
 set d, %c, (iy+-128)           ; Error
 set d, %c, (iy+127)            ; Error
 set e, %c, (ix)                ; Error
 set e, %c, (ix+-128)           ; Error
 set e, %c, (ix+127)            ; Error
 set e, %c, (iy)                ; Error
 set e, %c, (iy+-128)           ; Error
 set e, %c, (iy+127)            ; Error
 set h, %c, (ix)                ; Error
 set h, %c, (ix+-128)           ; Error
 set h, %c, (ix+127)            ; Error
 set h, %c, (iy)                ; Error
 set h, %c, (iy+-128)           ; Error
 set h, %c, (iy+127)            ; Error
 set l, %c, (ix)                ; Error
 set l, %c, (ix+-128)           ; Error
 set l, %c, (ix+127)            ; Error
 set l, %c, (iy)                ; Error
 set l, %c, (iy+-128)           ; Error
 set l, %c, (iy+127)            ; Error
 setae                          ; Error
 sl1 (hl)                       ; Error
 sl1 (ix)                       ; Error
 sl1 (ix), a                    ; Error
 sl1 (ix), b                    ; Error
 sl1 (ix), c                    ; Error
 sl1 (ix), d                    ; Error
 sl1 (ix), e                    ; Error
 sl1 (ix), h                    ; Error
 sl1 (ix), l                    ; Error
 sl1 (ix+-128)                  ; Error
 sl1 (ix+-128), a               ; Error
 sl1 (ix+-128), b               ; Error
 sl1 (ix+-128), c               ; Error
 sl1 (ix+-128), d               ; Error
 sl1 (ix+-128), e               ; Error
 sl1 (ix+-128), h               ; Error
 sl1 (ix+-128), l               ; Error
 sl1 (ix+127)                   ; Error
 sl1 (ix+127), a                ; Error
 sl1 (ix+127), b                ; Error
 sl1 (ix+127), c                ; Error
 sl1 (ix+127), d                ; Error
 sl1 (ix+127), e                ; Error
 sl1 (ix+127), h                ; Error
 sl1 (ix+127), l                ; Error
 sl1 (iy)                       ; Error
 sl1 (iy), a                    ; Error
 sl1 (iy), b                    ; Error
 sl1 (iy), c                    ; Error
 sl1 (iy), d                    ; Error
 sl1 (iy), e                    ; Error
 sl1 (iy), h                    ; Error
 sl1 (iy), l                    ; Error
 sl1 (iy+-128)                  ; Error
 sl1 (iy+-128), a               ; Error
 sl1 (iy+-128), b               ; Error
 sl1 (iy+-128), c               ; Error
 sl1 (iy+-128), d               ; Error
 sl1 (iy+-128), e               ; Error
 sl1 (iy+-128), h               ; Error
 sl1 (iy+-128), l               ; Error
 sl1 (iy+127)                   ; Error
 sl1 (iy+127), a                ; Error
 sl1 (iy+127), b                ; Error
 sl1 (iy+127), c                ; Error
 sl1 (iy+127), d                ; Error
 sl1 (iy+127), e                ; Error
 sl1 (iy+127), h                ; Error
 sl1 (iy+127), l                ; Error
 sl1 a                          ; Error
 sl1 a, (ix)                    ; Error
 sl1 a, (ix+-128)               ; Error
 sl1 a, (ix+127)                ; Error
 sl1 a, (iy)                    ; Error
 sl1 a, (iy+-128)               ; Error
 sl1 a, (iy+127)                ; Error
 sl1 b                          ; Error
 sl1 b, (ix)                    ; Error
 sl1 b, (ix+-128)               ; Error
 sl1 b, (ix+127)                ; Error
 sl1 b, (iy)                    ; Error
 sl1 b, (iy+-128)               ; Error
 sl1 b, (iy+127)                ; Error
 sl1 c                          ; Error
 sl1 c, (ix)                    ; Error
 sl1 c, (ix+-128)               ; Error
 sl1 c, (ix+127)                ; Error
 sl1 c, (iy)                    ; Error
 sl1 c, (iy+-128)               ; Error
 sl1 c, (iy+127)                ; Error
 sl1 d                          ; Error
 sl1 d, (ix)                    ; Error
 sl1 d, (ix+-128)               ; Error
 sl1 d, (ix+127)                ; Error
 sl1 d, (iy)                    ; Error
 sl1 d, (iy+-128)               ; Error
 sl1 d, (iy+127)                ; Error
 sl1 e                          ; Error
 sl1 e, (ix)                    ; Error
 sl1 e, (ix+-128)               ; Error
 sl1 e, (ix+127)                ; Error
 sl1 e, (iy)                    ; Error
 sl1 e, (iy+-128)               ; Error
 sl1 e, (iy+127)                ; Error
 sl1 h                          ; Error
 sl1 h, (ix)                    ; Error
 sl1 h, (ix+-128)               ; Error
 sl1 h, (ix+127)                ; Error
 sl1 h, (iy)                    ; Error
 sl1 h, (iy+-128)               ; Error
 sl1 h, (iy+127)                ; Error
 sl1 l                          ; Error
 sl1 l, (ix)                    ; Error
 sl1 l, (ix+-128)               ; Error
 sl1 l, (ix+127)                ; Error
 sl1 l, (iy)                    ; Error
 sl1 l, (iy+-128)               ; Error
 sl1 l, (iy+127)                ; Error
 sla (hl)                       ; Error
 sla (ix)                       ; Error
 sla (ix), a                    ; Error
 sla (ix), b                    ; Error
 sla (ix), c                    ; Error
 sla (ix), d                    ; Error
 sla (ix), e                    ; Error
 sla (ix), h                    ; Error
 sla (ix), l                    ; Error
 sla (ix+-128)                  ; Error
 sla (ix+-128), a               ; Error
 sla (ix+-128), b               ; Error
 sla (ix+-128), c               ; Error
 sla (ix+-128), d               ; Error
 sla (ix+-128), e               ; Error
 sla (ix+-128), h               ; Error
 sla (ix+-128), l               ; Error
 sla (ix+127)                   ; Error
 sla (ix+127), a                ; Error
 sla (ix+127), b                ; Error
 sla (ix+127), c                ; Error
 sla (ix+127), d                ; Error
 sla (ix+127), e                ; Error
 sla (ix+127), h                ; Error
 sla (ix+127), l                ; Error
 sla (iy)                       ; Error
 sla (iy), a                    ; Error
 sla (iy), b                    ; Error
 sla (iy), c                    ; Error
 sla (iy), d                    ; Error
 sla (iy), e                    ; Error
 sla (iy), h                    ; Error
 sla (iy), l                    ; Error
 sla (iy+-128)                  ; Error
 sla (iy+-128), a               ; Error
 sla (iy+-128), b               ; Error
 sla (iy+-128), c               ; Error
 sla (iy+-128), d               ; Error
 sla (iy+-128), e               ; Error
 sla (iy+-128), h               ; Error
 sla (iy+-128), l               ; Error
 sla (iy+127)                   ; Error
 sla (iy+127), a                ; Error
 sla (iy+127), b                ; Error
 sla (iy+127), c                ; Error
 sla (iy+127), d                ; Error
 sla (iy+127), e                ; Error
 sla (iy+127), h                ; Error
 sla (iy+127), l                ; Error
 sla a                          ; Error
 sla a, (ix)                    ; Error
 sla a, (ix+-128)               ; Error
 sla a, (ix+127)                ; Error
 sla a, (iy)                    ; Error
 sla a, (iy+-128)               ; Error
 sla a, (iy+127)                ; Error
 sla b                          ; Error
 sla b, (ix)                    ; Error
 sla b, (ix+-128)               ; Error
 sla b, (ix+127)                ; Error
 sla b, (iy)                    ; Error
 sla b, (iy+-128)               ; Error
 sla b, (iy+127)                ; Error
 sla c                          ; Error
 sla c, (ix)                    ; Error
 sla c, (ix+-128)               ; Error
 sla c, (ix+127)                ; Error
 sla c, (iy)                    ; Error
 sla c, (iy+-128)               ; Error
 sla c, (iy+127)                ; Error
 sla d                          ; Error
 sla d, (ix)                    ; Error
 sla d, (ix+-128)               ; Error
 sla d, (ix+127)                ; Error
 sla d, (iy)                    ; Error
 sla d, (iy+-128)               ; Error
 sla d, (iy+127)                ; Error
 sla e                          ; Error
 sla e, (ix)                    ; Error
 sla e, (ix+-128)               ; Error
 sla e, (ix+127)                ; Error
 sla e, (iy)                    ; Error
 sla e, (iy+-128)               ; Error
 sla e, (iy+127)                ; Error
 sla h                          ; Error
 sla h, (ix)                    ; Error
 sla h, (ix+-128)               ; Error
 sla h, (ix+127)                ; Error
 sla h, (iy)                    ; Error
 sla h, (iy+-128)               ; Error
 sla h, (iy+127)                ; Error
 sla l                          ; Error
 sla l, (ix)                    ; Error
 sla l, (ix+-128)               ; Error
 sla l, (ix+127)                ; Error
 sla l, (iy)                    ; Error
 sla l, (iy+-128)               ; Error
 sla l, (iy+127)                ; Error
 sli (hl)                       ; Error
 sli (ix)                       ; Error
 sli (ix), a                    ; Error
 sli (ix), b                    ; Error
 sli (ix), c                    ; Error
 sli (ix), d                    ; Error
 sli (ix), e                    ; Error
 sli (ix), h                    ; Error
 sli (ix), l                    ; Error
 sli (ix+-128)                  ; Error
 sli (ix+-128), a               ; Error
 sli (ix+-128), b               ; Error
 sli (ix+-128), c               ; Error
 sli (ix+-128), d               ; Error
 sli (ix+-128), e               ; Error
 sli (ix+-128), h               ; Error
 sli (ix+-128), l               ; Error
 sli (ix+127)                   ; Error
 sli (ix+127), a                ; Error
 sli (ix+127), b                ; Error
 sli (ix+127), c                ; Error
 sli (ix+127), d                ; Error
 sli (ix+127), e                ; Error
 sli (ix+127), h                ; Error
 sli (ix+127), l                ; Error
 sli (iy)                       ; Error
 sli (iy), a                    ; Error
 sli (iy), b                    ; Error
 sli (iy), c                    ; Error
 sli (iy), d                    ; Error
 sli (iy), e                    ; Error
 sli (iy), h                    ; Error
 sli (iy), l                    ; Error
 sli (iy+-128)                  ; Error
 sli (iy+-128), a               ; Error
 sli (iy+-128), b               ; Error
 sli (iy+-128), c               ; Error
 sli (iy+-128), d               ; Error
 sli (iy+-128), e               ; Error
 sli (iy+-128), h               ; Error
 sli (iy+-128), l               ; Error
 sli (iy+127)                   ; Error
 sli (iy+127), a                ; Error
 sli (iy+127), b                ; Error
 sli (iy+127), c                ; Error
 sli (iy+127), d                ; Error
 sli (iy+127), e                ; Error
 sli (iy+127), h                ; Error
 sli (iy+127), l                ; Error
 sli a                          ; Error
 sli a, (ix)                    ; Error
 sli a, (ix+-128)               ; Error
 sli a, (ix+127)                ; Error
 sli a, (iy)                    ; Error
 sli a, (iy+-128)               ; Error
 sli a, (iy+127)                ; Error
 sli b                          ; Error
 sli b, (ix)                    ; Error
 sli b, (ix+-128)               ; Error
 sli b, (ix+127)                ; Error
 sli b, (iy)                    ; Error
 sli b, (iy+-128)               ; Error
 sli b, (iy+127)                ; Error
 sli c                          ; Error
 sli c, (ix)                    ; Error
 sli c, (ix+-128)               ; Error
 sli c, (ix+127)                ; Error
 sli c, (iy)                    ; Error
 sli c, (iy+-128)               ; Error
 sli c, (iy+127)                ; Error
 sli d                          ; Error
 sli d, (ix)                    ; Error
 sli d, (ix+-128)               ; Error
 sli d, (ix+127)                ; Error
 sli d, (iy)                    ; Error
 sli d, (iy+-128)               ; Error
 sli d, (iy+127)                ; Error
 sli e                          ; Error
 sli e, (ix)                    ; Error
 sli e, (ix+-128)               ; Error
 sli e, (ix+127)                ; Error
 sli e, (iy)                    ; Error
 sli e, (iy+-128)               ; Error
 sli e, (iy+127)                ; Error
 sli h                          ; Error
 sli h, (ix)                    ; Error
 sli h, (ix+-128)               ; Error
 sli h, (ix+127)                ; Error
 sli h, (iy)                    ; Error
 sli h, (iy+-128)               ; Error
 sli h, (iy+127)                ; Error
 sli l                          ; Error
 sli l, (ix)                    ; Error
 sli l, (ix+-128)               ; Error
 sli l, (ix+127)                ; Error
 sli l, (iy)                    ; Error
 sli l, (iy+-128)               ; Error
 sli l, (iy+127)                ; Error
 sll (hl)                       ; Error
 sll (ix)                       ; Error
 sll (ix), a                    ; Error
 sll (ix), b                    ; Error
 sll (ix), c                    ; Error
 sll (ix), d                    ; Error
 sll (ix), e                    ; Error
 sll (ix), h                    ; Error
 sll (ix), l                    ; Error
 sll (ix+-128)                  ; Error
 sll (ix+-128), a               ; Error
 sll (ix+-128), b               ; Error
 sll (ix+-128), c               ; Error
 sll (ix+-128), d               ; Error
 sll (ix+-128), e               ; Error
 sll (ix+-128), h               ; Error
 sll (ix+-128), l               ; Error
 sll (ix+127)                   ; Error
 sll (ix+127), a                ; Error
 sll (ix+127), b                ; Error
 sll (ix+127), c                ; Error
 sll (ix+127), d                ; Error
 sll (ix+127), e                ; Error
 sll (ix+127), h                ; Error
 sll (ix+127), l                ; Error
 sll (iy)                       ; Error
 sll (iy), a                    ; Error
 sll (iy), b                    ; Error
 sll (iy), c                    ; Error
 sll (iy), d                    ; Error
 sll (iy), e                    ; Error
 sll (iy), h                    ; Error
 sll (iy), l                    ; Error
 sll (iy+-128)                  ; Error
 sll (iy+-128), a               ; Error
 sll (iy+-128), b               ; Error
 sll (iy+-128), c               ; Error
 sll (iy+-128), d               ; Error
 sll (iy+-128), e               ; Error
 sll (iy+-128), h               ; Error
 sll (iy+-128), l               ; Error
 sll (iy+127)                   ; Error
 sll (iy+127), a                ; Error
 sll (iy+127), b                ; Error
 sll (iy+127), c                ; Error
 sll (iy+127), d                ; Error
 sll (iy+127), e                ; Error
 sll (iy+127), h                ; Error
 sll (iy+127), l                ; Error
 sll a                          ; Error
 sll a, (ix)                    ; Error
 sll a, (ix+-128)               ; Error
 sll a, (ix+127)                ; Error
 sll a, (iy)                    ; Error
 sll a, (iy+-128)               ; Error
 sll a, (iy+127)                ; Error
 sll b                          ; Error
 sll b, (ix)                    ; Error
 sll b, (ix+-128)               ; Error
 sll b, (ix+127)                ; Error
 sll b, (iy)                    ; Error
 sll b, (iy+-128)               ; Error
 sll b, (iy+127)                ; Error
 sll c                          ; Error
 sll c, (ix)                    ; Error
 sll c, (ix+-128)               ; Error
 sll c, (ix+127)                ; Error
 sll c, (iy)                    ; Error
 sll c, (iy+-128)               ; Error
 sll c, (iy+127)                ; Error
 sll d                          ; Error
 sll d, (ix)                    ; Error
 sll d, (ix+-128)               ; Error
 sll d, (ix+127)                ; Error
 sll d, (iy)                    ; Error
 sll d, (iy+-128)               ; Error
 sll d, (iy+127)                ; Error
 sll e                          ; Error
 sll e, (ix)                    ; Error
 sll e, (ix+-128)               ; Error
 sll e, (ix+127)                ; Error
 sll e, (iy)                    ; Error
 sll e, (iy+-128)               ; Error
 sll e, (iy+127)                ; Error
 sll h                          ; Error
 sll h, (ix)                    ; Error
 sll h, (ix+-128)               ; Error
 sll h, (ix+127)                ; Error
 sll h, (iy)                    ; Error
 sll h, (iy+-128)               ; Error
 sll h, (iy+127)                ; Error
 sll l                          ; Error
 sll l, (ix)                    ; Error
 sll l, (ix+-128)               ; Error
 sll l, (ix+127)                ; Error
 sll l, (iy)                    ; Error
 sll l, (iy+-128)               ; Error
 sll l, (iy+127)                ; Error
 sra (hl)                       ; Error
 sra (ix)                       ; Error
 sra (ix), a                    ; Error
 sra (ix), b                    ; Error
 sra (ix), c                    ; Error
 sra (ix), d                    ; Error
 sra (ix), e                    ; Error
 sra (ix), h                    ; Error
 sra (ix), l                    ; Error
 sra (ix+-128)                  ; Error
 sra (ix+-128), a               ; Error
 sra (ix+-128), b               ; Error
 sra (ix+-128), c               ; Error
 sra (ix+-128), d               ; Error
 sra (ix+-128), e               ; Error
 sra (ix+-128), h               ; Error
 sra (ix+-128), l               ; Error
 sra (ix+127)                   ; Error
 sra (ix+127), a                ; Error
 sra (ix+127), b                ; Error
 sra (ix+127), c                ; Error
 sra (ix+127), d                ; Error
 sra (ix+127), e                ; Error
 sra (ix+127), h                ; Error
 sra (ix+127), l                ; Error
 sra (iy)                       ; Error
 sra (iy), a                    ; Error
 sra (iy), b                    ; Error
 sra (iy), c                    ; Error
 sra (iy), d                    ; Error
 sra (iy), e                    ; Error
 sra (iy), h                    ; Error
 sra (iy), l                    ; Error
 sra (iy+-128)                  ; Error
 sra (iy+-128), a               ; Error
 sra (iy+-128), b               ; Error
 sra (iy+-128), c               ; Error
 sra (iy+-128), d               ; Error
 sra (iy+-128), e               ; Error
 sra (iy+-128), h               ; Error
 sra (iy+-128), l               ; Error
 sra (iy+127)                   ; Error
 sra (iy+127), a                ; Error
 sra (iy+127), b                ; Error
 sra (iy+127), c                ; Error
 sra (iy+127), d                ; Error
 sra (iy+127), e                ; Error
 sra (iy+127), h                ; Error
 sra (iy+127), l                ; Error
 sra a                          ; Error
 sra a, (ix)                    ; Error
 sra a, (ix+-128)               ; Error
 sra a, (ix+127)                ; Error
 sra a, (iy)                    ; Error
 sra a, (iy+-128)               ; Error
 sra a, (iy+127)                ; Error
 sra b                          ; Error
 sra b, (ix)                    ; Error
 sra b, (ix+-128)               ; Error
 sra b, (ix+127)                ; Error
 sra b, (iy)                    ; Error
 sra b, (iy+-128)               ; Error
 sra b, (iy+127)                ; Error
 sra c                          ; Error
 sra c, (ix)                    ; Error
 sra c, (ix+-128)               ; Error
 sra c, (ix+127)                ; Error
 sra c, (iy)                    ; Error
 sra c, (iy+-128)               ; Error
 sra c, (iy+127)                ; Error
 sra d                          ; Error
 sra d, (ix)                    ; Error
 sra d, (ix+-128)               ; Error
 sra d, (ix+127)                ; Error
 sra d, (iy)                    ; Error
 sra d, (iy+-128)               ; Error
 sra d, (iy+127)                ; Error
 sra e                          ; Error
 sra e, (ix)                    ; Error
 sra e, (ix+-128)               ; Error
 sra e, (ix+127)                ; Error
 sra e, (iy)                    ; Error
 sra e, (iy+-128)               ; Error
 sra e, (iy+127)                ; Error
 sra h                          ; Error
 sra h, (ix)                    ; Error
 sra h, (ix+-128)               ; Error
 sra h, (ix+127)                ; Error
 sra h, (iy)                    ; Error
 sra h, (iy+-128)               ; Error
 sra h, (iy+127)                ; Error
 sra l                          ; Error
 sra l, (ix)                    ; Error
 sra l, (ix+-128)               ; Error
 sra l, (ix+127)                ; Error
 sra l, (iy)                    ; Error
 sra l, (iy+-128)               ; Error
 sra l, (iy+127)                ; Error
 srl (hl)                       ; Error
 srl (ix)                       ; Error
 srl (ix), a                    ; Error
 srl (ix), b                    ; Error
 srl (ix), c                    ; Error
 srl (ix), d                    ; Error
 srl (ix), e                    ; Error
 srl (ix), h                    ; Error
 srl (ix), l                    ; Error
 srl (ix+-128)                  ; Error
 srl (ix+-128), a               ; Error
 srl (ix+-128), b               ; Error
 srl (ix+-128), c               ; Error
 srl (ix+-128), d               ; Error
 srl (ix+-128), e               ; Error
 srl (ix+-128), h               ; Error
 srl (ix+-128), l               ; Error
 srl (ix+127)                   ; Error
 srl (ix+127), a                ; Error
 srl (ix+127), b                ; Error
 srl (ix+127), c                ; Error
 srl (ix+127), d                ; Error
 srl (ix+127), e                ; Error
 srl (ix+127), h                ; Error
 srl (ix+127), l                ; Error
 srl (iy)                       ; Error
 srl (iy), a                    ; Error
 srl (iy), b                    ; Error
 srl (iy), c                    ; Error
 srl (iy), d                    ; Error
 srl (iy), e                    ; Error
 srl (iy), h                    ; Error
 srl (iy), l                    ; Error
 srl (iy+-128)                  ; Error
 srl (iy+-128), a               ; Error
 srl (iy+-128), b               ; Error
 srl (iy+-128), c               ; Error
 srl (iy+-128), d               ; Error
 srl (iy+-128), e               ; Error
 srl (iy+-128), h               ; Error
 srl (iy+-128), l               ; Error
 srl (iy+127)                   ; Error
 srl (iy+127), a                ; Error
 srl (iy+127), b                ; Error
 srl (iy+127), c                ; Error
 srl (iy+127), d                ; Error
 srl (iy+127), e                ; Error
 srl (iy+127), h                ; Error
 srl (iy+127), l                ; Error
 srl a                          ; Error
 srl a, (ix)                    ; Error
 srl a, (ix+-128)               ; Error
 srl a, (ix+127)                ; Error
 srl a, (iy)                    ; Error
 srl a, (iy+-128)               ; Error
 srl a, (iy+127)                ; Error
 srl b                          ; Error
 srl b, (ix)                    ; Error
 srl b, (ix+-128)               ; Error
 srl b, (ix+127)                ; Error
 srl b, (iy)                    ; Error
 srl b, (iy+-128)               ; Error
 srl b, (iy+127)                ; Error
 srl c                          ; Error
 srl c, (ix)                    ; Error
 srl c, (ix+-128)               ; Error
 srl c, (ix+127)                ; Error
 srl c, (iy)                    ; Error
 srl c, (iy+-128)               ; Error
 srl c, (iy+127)                ; Error
 srl d                          ; Error
 srl d, (ix)                    ; Error
 srl d, (ix+-128)               ; Error
 srl d, (ix+127)                ; Error
 srl d, (iy)                    ; Error
 srl d, (iy+-128)               ; Error
 srl d, (iy+127)                ; Error
 srl e                          ; Error
 srl e, (ix)                    ; Error
 srl e, (ix+-128)               ; Error
 srl e, (ix+127)                ; Error
 srl e, (iy)                    ; Error
 srl e, (iy+-128)               ; Error
 srl e, (iy+127)                ; Error
 srl h                          ; Error
 srl h, (ix)                    ; Error
 srl h, (ix+-128)               ; Error
 srl h, (ix+127)                ; Error
 srl h, (iy)                    ; Error
 srl h, (iy+-128)               ; Error
 srl h, (iy+127)                ; Error
 srl l                          ; Error
 srl l, (ix)                    ; Error
 srl l, (ix+-128)               ; Error
 srl l, (ix+127)                ; Error
 srl l, (iy)                    ; Error
 srl l, (iy+-128)               ; Error
 srl l, (iy+127)                ; Error
 stop                           ; Error
 sub (ix)                       ; Error
 sub (ix+-128)                  ; Error
 sub (ix+127)                   ; Error
 sub (iy)                       ; Error
 sub (iy+-128)                  ; Error
 sub (iy+127)                   ; Error
 sub a, (ix)                    ; Error
 sub a, (ix+-128)               ; Error
 sub a, (ix+127)                ; Error
 sub a, (iy)                    ; Error
 sub a, (iy+-128)               ; Error
 sub a, (iy+127)                ; Error
 swap (hl)                      ; Error
 swap a                         ; Error
 swap b                         ; Error
 swap c                         ; Error
 swap d                         ; Error
 swap e                         ; Error
 swap h                         ; Error
 swap l                         ; Error
 swapnib                        ; Error
 test -128                      ; Error
 test 127                       ; Error
 test 255                       ; Error
 test a, -128                   ; Error
 test a, 127                    ; Error
 test a, 255                    ; Error
 tst -128                       ; Error
 tst 127                        ; Error
 tst 255                        ; Error
 tst a, -128                    ; Error
 tst a, 127                     ; Error
 tst a, 255                     ; Error
 xor (ix)                       ; Error
 xor (ix+-128)                  ; Error
 xor (ix+127)                   ; Error
 xor (iy)                       ; Error
 xor (iy+-128)                  ; Error
 xor (iy+127)                   ; Error
 xor a, (ix)                    ; Error
 xor a, (ix+-128)               ; Error
 xor a, (ix+127)                ; Error
 xor a, (iy)                    ; Error
 xor a, (iy+-128)               ; Error
 xor a, (iy+127)                ; Error
