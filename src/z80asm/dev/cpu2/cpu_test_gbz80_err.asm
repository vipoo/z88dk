 adc (ix)                       ; Error
 adc (ix+127)                   ; Error
 adc (ix-128)                   ; Error
 adc (iy)                       ; Error
 adc (iy+127)                   ; Error
 adc (iy-128)                   ; Error
 adc a, (ix)                    ; Error
 adc a, (ix+127)                ; Error
 adc a, (ix-128)                ; Error
 adc a, (iy)                    ; Error
 adc a, (iy+127)                ; Error
 adc a, (iy-128)                ; Error
 add (ix)                       ; Error
 add (ix+127)                   ; Error
 add (ix-128)                   ; Error
 add (iy)                       ; Error
 add (iy+127)                   ; Error
 add (iy-128)                   ; Error
 add a, (ix)                    ; Error
 add a, (ix+127)                ; Error
 add a, (ix-128)                ; Error
 add a, (iy)                    ; Error
 add a, (iy+127)                ; Error
 add a, (iy-128)                ; Error
 add ix, bc                     ; Error
 add ix, de                     ; Error
 add ix, ix                     ; Error
 add ix, sp                     ; Error
 add iy, bc                     ; Error
 add iy, de                     ; Error
 add iy, iy                     ; Error
 add iy, sp                     ; Error
 adi hl, -128                   ; Error
 adi hl, 127                    ; Error
 adi hl, 255                    ; Error
 adi sp, -128                   ; Error
 adi sp, 127                    ; Error
 adi sp, 255                    ; Error
 and (ix)                       ; Error
 and (ix+127)                   ; Error
 and (ix-128)                   ; Error
 and (iy)                       ; Error
 and (iy+127)                   ; Error
 and (iy-128)                   ; Error
 and a, (ix)                    ; Error
 and a, (ix+127)                ; Error
 and a, (ix-128)                ; Error
 and a, (iy)                    ; Error
 and a, (iy+127)                ; Error
 and a, (iy-128)                ; Error
 bit 0, (ix)                    ; Error
 bit 0, (ix+127)                ; Error
 bit 0, (ix-128)                ; Error
 bit 0, (iy)                    ; Error
 bit 0, (iy+127)                ; Error
 bit 0, (iy-128)                ; Error
 bit 1, (ix)                    ; Error
 bit 1, (ix+127)                ; Error
 bit 1, (ix-128)                ; Error
 bit 1, (iy)                    ; Error
 bit 1, (iy+127)                ; Error
 bit 1, (iy-128)                ; Error
 bit 2, (ix)                    ; Error
 bit 2, (ix+127)                ; Error
 bit 2, (ix-128)                ; Error
 bit 2, (iy)                    ; Error
 bit 2, (iy+127)                ; Error
 bit 2, (iy-128)                ; Error
 bit 3, (ix)                    ; Error
 bit 3, (ix+127)                ; Error
 bit 3, (ix-128)                ; Error
 bit 3, (iy)                    ; Error
 bit 3, (iy+127)                ; Error
 bit 3, (iy-128)                ; Error
 bit 4, (ix)                    ; Error
 bit 4, (ix+127)                ; Error
 bit 4, (ix-128)                ; Error
 bit 4, (iy)                    ; Error
 bit 4, (iy+127)                ; Error
 bit 4, (iy-128)                ; Error
 bit 5, (ix)                    ; Error
 bit 5, (ix+127)                ; Error
 bit 5, (ix-128)                ; Error
 bit 5, (iy)                    ; Error
 bit 5, (iy+127)                ; Error
 bit 5, (iy-128)                ; Error
 bit 6, (ix)                    ; Error
 bit 6, (ix+127)                ; Error
 bit 6, (ix-128)                ; Error
 bit 6, (iy)                    ; Error
 bit 6, (iy+127)                ; Error
 bit 6, (iy-128)                ; Error
 bit 7, (ix)                    ; Error
 bit 7, (ix+127)                ; Error
 bit 7, (ix-128)                ; Error
 bit 7, (iy)                    ; Error
 bit 7, (iy+127)                ; Error
 bit 7, (iy-128)                ; Error
 call m, -32768                 ; Error
 call m, 32767                  ; Error
 call m, 65535                  ; Error
 call nv, -32768                ; Error
 call nv, 32767                 ; Error
 call nv, 65535                 ; Error
 call p, -32768                 ; Error
 call p, 32767                  ; Error
 call p, 65535                  ; Error
 call pe, -32768                ; Error
 call pe, 32767                 ; Error
 call pe, 65535                 ; Error
 call po, -32768                ; Error
 call po, 32767                 ; Error
 call po, 65535                 ; Error
 call v, -32768                 ; Error
 call v, 32767                  ; Error
 call v, 65535                  ; Error
 cm -32768                      ; Error
 cm 32767                       ; Error
 cm 65535                       ; Error
 cmp (ix)                       ; Error
 cmp (ix+127)                   ; Error
 cmp (ix-128)                   ; Error
 cmp (iy)                       ; Error
 cmp (iy+127)                   ; Error
 cmp (iy-128)                   ; Error
 cmp a, (ix)                    ; Error
 cmp a, (ix+127)                ; Error
 cmp a, (ix-128)                ; Error
 cmp a, (iy)                    ; Error
 cmp a, (iy+127)                ; Error
 cmp a, (iy-128)                ; Error
 cnv -32768                     ; Error
 cnv 32767                      ; Error
 cnv 65535                      ; Error
 cp (ix)                        ; Error
 cp (ix+127)                    ; Error
 cp (ix-128)                    ; Error
 cp (iy)                        ; Error
 cp (iy+127)                    ; Error
 cp (iy-128)                    ; Error
 cp a, (ix)                     ; Error
 cp a, (ix+127)                 ; Error
 cp a, (ix-128)                 ; Error
 cp a, (iy)                     ; Error
 cp a, (iy+127)                 ; Error
 cp a, (iy-128)                 ; Error
 cpe -32768                     ; Error
 cpe 32767                      ; Error
 cpe 65535                      ; Error
 cpo -32768                     ; Error
 cpo 32767                      ; Error
 cpo 65535                      ; Error
 cv -32768                      ; Error
 cv 32767                       ; Error
 cv 65535                       ; Error
 dec (ix)                       ; Error
 dec (ix+127)                   ; Error
 dec (ix-128)                   ; Error
 dec (iy)                       ; Error
 dec (iy+127)                   ; Error
 dec (iy-128)                   ; Error
 dec ix                         ; Error
 dec iy                         ; Error
 djnz -32768                    ; Error
 djnz 32767                     ; Error
 djnz 65535                     ; Error
 djnz b, -32768                 ; Error
 djnz b, 32767                  ; Error
 djnz b, 65535                  ; Error
 ex (sp), ix                    ; Error
 ex (sp), iy                    ; Error
 ex af, af                      ; Error
 ex af, af'                     ; Error
 exx                            ; Error
 im 0                           ; Error
 im 1                           ; Error
 im 2                           ; Error
 in (c)                         ; Error
 in -128                        ; Error
 in 127                         ; Error
 in 255                         ; Error
 in a, (-128)                   ; Error
 in a, (127)                    ; Error
 in a, (255)                    ; Error
 in a, (c)                      ; Error
 in b, (c)                      ; Error
 in c, (c)                      ; Error
 in d, (c)                      ; Error
 in e, (c)                      ; Error
 in f, (c)                      ; Error
 in h, (c)                      ; Error
 in l, (c)                      ; Error
 in0 (-128)                     ; Error
 in0 (127)                      ; Error
 in0 (255)                      ; Error
 in0 a, (-128)                  ; Error
 in0 a, (127)                   ; Error
 in0 a, (255)                   ; Error
 in0 b, (-128)                  ; Error
 in0 b, (127)                   ; Error
 in0 b, (255)                   ; Error
 in0 c, (-128)                  ; Error
 in0 c, (127)                   ; Error
 in0 c, (255)                   ; Error
 in0 d, (-128)                  ; Error
 in0 d, (127)                   ; Error
 in0 d, (255)                   ; Error
 in0 e, (-128)                  ; Error
 in0 e, (127)                   ; Error
 in0 e, (255)                   ; Error
 in0 f, (-128)                  ; Error
 in0 f, (127)                   ; Error
 in0 f, (255)                   ; Error
 in0 h, (-128)                  ; Error
 in0 h, (127)                   ; Error
 in0 h, (255)                   ; Error
 in0 l, (-128)                  ; Error
 in0 l, (127)                   ; Error
 in0 l, (255)                   ; Error
 inc (ix)                       ; Error
 inc (ix+127)                   ; Error
 inc (ix-128)                   ; Error
 inc (iy)                       ; Error
 inc (iy+127)                   ; Error
 inc (iy-128)                   ; Error
 inc ix                         ; Error
 inc iy                         ; Error
 ind                            ; Error
 indr                           ; Error
 ini                            ; Error
 inir                           ; Error
 jk -32768                      ; Error
 jk 32767                       ; Error
 jk 65535                       ; Error
 jm -32768                      ; Error
 jm 32767                       ; Error
 jm 65535                       ; Error
 jnk -32768                     ; Error
 jnk 32767                      ; Error
 jnk 65535                      ; Error
 jnv -32768                     ; Error
 jnv 32767                      ; Error
 jnv 65535                      ; Error
 jnx5 -32768                    ; Error
 jnx5 32767                     ; Error
 jnx5 65535                     ; Error
 jp (c)                         ; Error
 jp (ix)                        ; Error
 jp (iy)                        ; Error
 jp m, -32768                   ; Error
 jp m, 32767                    ; Error
 jp m, 65535                    ; Error
 jp nv, -32768                  ; Error
 jp nv, 32767                   ; Error
 jp nv, 65535                   ; Error
 jp p, -32768                   ; Error
 jp p, 32767                    ; Error
 jp p, 65535                    ; Error
 jp pe, -32768                  ; Error
 jp pe, 32767                   ; Error
 jp pe, 65535                   ; Error
 jp po, -32768                  ; Error
 jp po, 32767                   ; Error
 jp po, 65535                   ; Error
 jp v, -32768                   ; Error
 jp v, 32767                    ; Error
 jp v, 65535                    ; Error
 jpe -32768                     ; Error
 jpe 32767                      ; Error
 jpe 65535                      ; Error
 jpo -32768                     ; Error
 jpo 32767                      ; Error
 jpo 65535                      ; Error
 jr -32768                      ; Error
 jr 32767                       ; Error
 jr 65535                       ; Error
 jr c, -32768                   ; Error
 jr c, 32767                    ; Error
 jr c, 65535                    ; Error
 jr nc, -32768                  ; Error
 jr nc, 32767                   ; Error
 jr nc, 65535                   ; Error
 jr nz, -32768                  ; Error
 jr nz, 32767                   ; Error
 jr nz, 65535                   ; Error
 jr z, -32768                   ; Error
 jr z, 32767                    ; Error
 jr z, 65535                    ; Error
 jv -32768                      ; Error
 jv 32767                       ; Error
 jv 65535                       ; Error
 jx5 -32768                     ; Error
 jx5 32767                      ; Error
 jx5 65535                      ; Error
 ld (-32768), bc                ; Error
 ld (-32768), de                ; Error
 ld (-32768), hl                ; Error
 ld (-32768), ix                ; Error
 ld (-32768), iy                ; Error
 ld (32767), bc                 ; Error
 ld (32767), de                 ; Error
 ld (32767), hl                 ; Error
 ld (32767), ix                 ; Error
 ld (32767), iy                 ; Error
 ld (65535), bc                 ; Error
 ld (65535), de                 ; Error
 ld (65535), hl                 ; Error
 ld (65535), ix                 ; Error
 ld (65535), iy                 ; Error
 ld (de), hl                    ; Error
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
 ld (ix-128), -128              ; Error
 ld (ix-128), 127               ; Error
 ld (ix-128), 255               ; Error
 ld (ix-128), a                 ; Error
 ld (ix-128), b                 ; Error
 ld (ix-128), c                 ; Error
 ld (ix-128), d                 ; Error
 ld (ix-128), e                 ; Error
 ld (ix-128), h                 ; Error
 ld (ix-128), l                 ; Error
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
 ld (iy-128), -128              ; Error
 ld (iy-128), 127               ; Error
 ld (iy-128), 255               ; Error
 ld (iy-128), a                 ; Error
 ld (iy-128), b                 ; Error
 ld (iy-128), c                 ; Error
 ld (iy-128), d                 ; Error
 ld (iy-128), e                 ; Error
 ld (iy-128), h                 ; Error
 ld (iy-128), l                 ; Error
 ld a, (ix)                     ; Error
 ld a, (ix+127)                 ; Error
 ld a, (ix-128)                 ; Error
 ld a, (iy)                     ; Error
 ld a, (iy+127)                 ; Error
 ld a, (iy-128)                 ; Error
 ld a, i                        ; Error
 ld a, ixh                      ; Error
 ld a, ixl                      ; Error
 ld a, iyh                      ; Error
 ld a, iyl                      ; Error
 ld a, r                        ; Error
 ld b, (ix)                     ; Error
 ld b, (ix+127)                 ; Error
 ld b, (ix-128)                 ; Error
 ld b, (iy)                     ; Error
 ld b, (iy+127)                 ; Error
 ld b, (iy-128)                 ; Error
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
 ld c, (ix+127)                 ; Error
 ld c, (ix-128)                 ; Error
 ld c, (iy)                     ; Error
 ld c, (iy+127)                 ; Error
 ld c, (iy-128)                 ; Error
 ld c, ixh                      ; Error
 ld c, ixl                      ; Error
 ld c, iyh                      ; Error
 ld c, iyl                      ; Error
 ld d, (ix)                     ; Error
 ld d, (ix+127)                 ; Error
 ld d, (ix-128)                 ; Error
 ld d, (iy)                     ; Error
 ld d, (iy+127)                 ; Error
 ld d, (iy-128)                 ; Error
 ld d, ixh                      ; Error
 ld d, ixl                      ; Error
 ld d, iyh                      ; Error
 ld d, iyl                      ; Error
 ld de, (-32768)                ; Error
 ld de, (32767)                 ; Error
 ld de, (65535)                 ; Error
 ld de, hl+127                  ; Error
 ld de, hl+255                  ; Error
 ld de, hl-128                  ; Error
 ld de, ix                      ; Error
 ld de, iy                      ; Error
 ld e, (ix)                     ; Error
 ld e, (ix+127)                 ; Error
 ld e, (ix-128)                 ; Error
 ld e, (iy)                     ; Error
 ld e, (iy+127)                 ; Error
 ld e, (iy-128)                 ; Error
 ld e, ixh                      ; Error
 ld e, ixl                      ; Error
 ld e, iyh                      ; Error
 ld e, iyl                      ; Error
 ld h, (ix)                     ; Error
 ld h, (ix+127)                 ; Error
 ld h, (ix-128)                 ; Error
 ld h, (iy)                     ; Error
 ld h, (iy+127)                 ; Error
 ld h, (iy-128)                 ; Error
 ld hl, (-32768)                ; Error
 ld hl, (32767)                 ; Error
 ld hl, (65535)                 ; Error
 ld hl, (de)                    ; Error
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
 ld l, (ix+127)                 ; Error
 ld l, (ix-128)                 ; Error
 ld l, (iy)                     ; Error
 ld l, (iy+127)                 ; Error
 ld l, (iy-128)                 ; Error
 ld r, a                        ; Error
 ld sp, (-32768)                ; Error
 ld sp, (32767)                 ; Error
 ld sp, (65535)                 ; Error
 ld sp, ix                      ; Error
 ld sp, iy                      ; Error
 lddrx                          ; Error
 lddx                           ; Error
 ldhi -128                      ; Error
 ldhi 127                       ; Error
 ldhi 255                       ; Error
 ldirx                          ; Error
 ldix                           ; Error
 ldpirx                         ; Error
 ldsi -128                      ; Error
 ldsi 127                       ; Error
 ldsi 255                       ; Error
 ldws                           ; Error
 lhld -32768                    ; Error
 lhld 32767                     ; Error
 lhld 65535                     ; Error
 lhlde                          ; Error
 lhlx                           ; Error
 mirror a                       ; Error
 mlt bc                         ; Error
 mlt de                         ; Error
 mlt hl                         ; Error
 mlt sp                         ; Error
 mul bc                         ; Error
 mul de                         ; Error
 mul hl                         ; Error
 mul sp                         ; Error
 nextreg -128, %N               ; Error
 nextreg -128, a                ; Error
 nextreg 127, %N                ; Error
 nextreg 127, a                 ; Error
 nextreg 255, %N                ; Error
 nextreg 255, a                 ; Error
 or (ix)                        ; Error
 or (ix+127)                    ; Error
 or (ix-128)                    ; Error
 or (iy)                        ; Error
 or (iy+127)                    ; Error
 or (iy-128)                    ; Error
 or a, (ix)                     ; Error
 or a, (ix+127)                 ; Error
 or a, (ix-128)                 ; Error
 or a, (iy)                     ; Error
 or a, (iy+127)                 ; Error
 or a, (iy-128)                 ; Error
 otdm                           ; Error
 otdmr                          ; Error
 otdr                           ; Error
 otim                           ; Error
 otimr                          ; Error
 otir                           ; Error
 out (-128), a                  ; Error
 out (127), a                   ; Error
 out (255), a                   ; Error
 out (c), 0                     ; Error
 out (c), a                     ; Error
 out (c), b                     ; Error
 out (c), c                     ; Error
 out (c), d                     ; Error
 out (c), e                     ; Error
 out (c), h                     ; Error
 out (c), l                     ; Error
 out -128                       ; Error
 out 127                        ; Error
 out 255                        ; Error
 out0 (-128), a                 ; Error
 out0 (-128), b                 ; Error
 out0 (-128), c                 ; Error
 out0 (-128), d                 ; Error
 out0 (-128), e                 ; Error
 out0 (-128), h                 ; Error
 out0 (-128), l                 ; Error
 out0 (127), a                  ; Error
 out0 (127), b                  ; Error
 out0 (127), c                  ; Error
 out0 (127), d                  ; Error
 out0 (127), e                  ; Error
 out0 (127), h                  ; Error
 out0 (127), l                  ; Error
 out0 (255), a                  ; Error
 out0 (255), b                  ; Error
 out0 (255), c                  ; Error
 out0 (255), d                  ; Error
 out0 (255), e                  ; Error
 out0 (255), h                  ; Error
 out0 (255), l                  ; Error
 outd                           ; Error
 outi                           ; Error
 outinb                         ; Error
 ovrst8                         ; Error
 pixelad                        ; Error
 pixeldn                        ; Error
 pop ix                         ; Error
 pop iy                         ; Error
 push %M                        ; Error
 push ix                        ; Error
 push iy                        ; Error
 res 0, (ix)                    ; Error
 res 0, (ix), a                 ; Error
 res 0, (ix), b                 ; Error
 res 0, (ix), c                 ; Error
 res 0, (ix), d                 ; Error
 res 0, (ix), e                 ; Error
 res 0, (ix), h                 ; Error
 res 0, (ix), l                 ; Error
 res 0, (ix+127)                ; Error
 res 0, (ix+127), a             ; Error
 res 0, (ix+127), b             ; Error
 res 0, (ix+127), c             ; Error
 res 0, (ix+127), d             ; Error
 res 0, (ix+127), e             ; Error
 res 0, (ix+127), h             ; Error
 res 0, (ix+127), l             ; Error
 res 0, (ix-128)                ; Error
 res 0, (ix-128), a             ; Error
 res 0, (ix-128), b             ; Error
 res 0, (ix-128), c             ; Error
 res 0, (ix-128), d             ; Error
 res 0, (ix-128), e             ; Error
 res 0, (ix-128), h             ; Error
 res 0, (ix-128), l             ; Error
 res 0, (iy)                    ; Error
 res 0, (iy), a                 ; Error
 res 0, (iy), b                 ; Error
 res 0, (iy), c                 ; Error
 res 0, (iy), d                 ; Error
 res 0, (iy), e                 ; Error
 res 0, (iy), h                 ; Error
 res 0, (iy), l                 ; Error
 res 0, (iy+127)                ; Error
 res 0, (iy+127), a             ; Error
 res 0, (iy+127), b             ; Error
 res 0, (iy+127), c             ; Error
 res 0, (iy+127), d             ; Error
 res 0, (iy+127), e             ; Error
 res 0, (iy+127), h             ; Error
 res 0, (iy+127), l             ; Error
 res 0, (iy-128)                ; Error
 res 0, (iy-128), a             ; Error
 res 0, (iy-128), b             ; Error
 res 0, (iy-128), c             ; Error
 res 0, (iy-128), d             ; Error
 res 0, (iy-128), e             ; Error
 res 0, (iy-128), h             ; Error
 res 0, (iy-128), l             ; Error
 res 1, (ix)                    ; Error
 res 1, (ix), a                 ; Error
 res 1, (ix), b                 ; Error
 res 1, (ix), c                 ; Error
 res 1, (ix), d                 ; Error
 res 1, (ix), e                 ; Error
 res 1, (ix), h                 ; Error
 res 1, (ix), l                 ; Error
 res 1, (ix+127)                ; Error
 res 1, (ix+127), a             ; Error
 res 1, (ix+127), b             ; Error
 res 1, (ix+127), c             ; Error
 res 1, (ix+127), d             ; Error
 res 1, (ix+127), e             ; Error
 res 1, (ix+127), h             ; Error
 res 1, (ix+127), l             ; Error
 res 1, (ix-128)                ; Error
 res 1, (ix-128), a             ; Error
 res 1, (ix-128), b             ; Error
 res 1, (ix-128), c             ; Error
 res 1, (ix-128), d             ; Error
 res 1, (ix-128), e             ; Error
 res 1, (ix-128), h             ; Error
 res 1, (ix-128), l             ; Error
 res 1, (iy)                    ; Error
 res 1, (iy), a                 ; Error
 res 1, (iy), b                 ; Error
 res 1, (iy), c                 ; Error
 res 1, (iy), d                 ; Error
 res 1, (iy), e                 ; Error
 res 1, (iy), h                 ; Error
 res 1, (iy), l                 ; Error
 res 1, (iy+127)                ; Error
 res 1, (iy+127), a             ; Error
 res 1, (iy+127), b             ; Error
 res 1, (iy+127), c             ; Error
 res 1, (iy+127), d             ; Error
 res 1, (iy+127), e             ; Error
 res 1, (iy+127), h             ; Error
 res 1, (iy+127), l             ; Error
 res 1, (iy-128)                ; Error
 res 1, (iy-128), a             ; Error
 res 1, (iy-128), b             ; Error
 res 1, (iy-128), c             ; Error
 res 1, (iy-128), d             ; Error
 res 1, (iy-128), e             ; Error
 res 1, (iy-128), h             ; Error
 res 1, (iy-128), l             ; Error
 res 2, (ix)                    ; Error
 res 2, (ix), a                 ; Error
 res 2, (ix), b                 ; Error
 res 2, (ix), c                 ; Error
 res 2, (ix), d                 ; Error
 res 2, (ix), e                 ; Error
 res 2, (ix), h                 ; Error
 res 2, (ix), l                 ; Error
 res 2, (ix+127)                ; Error
 res 2, (ix+127), a             ; Error
 res 2, (ix+127), b             ; Error
 res 2, (ix+127), c             ; Error
 res 2, (ix+127), d             ; Error
 res 2, (ix+127), e             ; Error
 res 2, (ix+127), h             ; Error
 res 2, (ix+127), l             ; Error
 res 2, (ix-128)                ; Error
 res 2, (ix-128), a             ; Error
 res 2, (ix-128), b             ; Error
 res 2, (ix-128), c             ; Error
 res 2, (ix-128), d             ; Error
 res 2, (ix-128), e             ; Error
 res 2, (ix-128), h             ; Error
 res 2, (ix-128), l             ; Error
 res 2, (iy)                    ; Error
 res 2, (iy), a                 ; Error
 res 2, (iy), b                 ; Error
 res 2, (iy), c                 ; Error
 res 2, (iy), d                 ; Error
 res 2, (iy), e                 ; Error
 res 2, (iy), h                 ; Error
 res 2, (iy), l                 ; Error
 res 2, (iy+127)                ; Error
 res 2, (iy+127), a             ; Error
 res 2, (iy+127), b             ; Error
 res 2, (iy+127), c             ; Error
 res 2, (iy+127), d             ; Error
 res 2, (iy+127), e             ; Error
 res 2, (iy+127), h             ; Error
 res 2, (iy+127), l             ; Error
 res 2, (iy-128)                ; Error
 res 2, (iy-128), a             ; Error
 res 2, (iy-128), b             ; Error
 res 2, (iy-128), c             ; Error
 res 2, (iy-128), d             ; Error
 res 2, (iy-128), e             ; Error
 res 2, (iy-128), h             ; Error
 res 2, (iy-128), l             ; Error
 res 3, (ix)                    ; Error
 res 3, (ix), a                 ; Error
 res 3, (ix), b                 ; Error
 res 3, (ix), c                 ; Error
 res 3, (ix), d                 ; Error
 res 3, (ix), e                 ; Error
 res 3, (ix), h                 ; Error
 res 3, (ix), l                 ; Error
 res 3, (ix+127)                ; Error
 res 3, (ix+127), a             ; Error
 res 3, (ix+127), b             ; Error
 res 3, (ix+127), c             ; Error
 res 3, (ix+127), d             ; Error
 res 3, (ix+127), e             ; Error
 res 3, (ix+127), h             ; Error
 res 3, (ix+127), l             ; Error
 res 3, (ix-128)                ; Error
 res 3, (ix-128), a             ; Error
 res 3, (ix-128), b             ; Error
 res 3, (ix-128), c             ; Error
 res 3, (ix-128), d             ; Error
 res 3, (ix-128), e             ; Error
 res 3, (ix-128), h             ; Error
 res 3, (ix-128), l             ; Error
 res 3, (iy)                    ; Error
 res 3, (iy), a                 ; Error
 res 3, (iy), b                 ; Error
 res 3, (iy), c                 ; Error
 res 3, (iy), d                 ; Error
 res 3, (iy), e                 ; Error
 res 3, (iy), h                 ; Error
 res 3, (iy), l                 ; Error
 res 3, (iy+127)                ; Error
 res 3, (iy+127), a             ; Error
 res 3, (iy+127), b             ; Error
 res 3, (iy+127), c             ; Error
 res 3, (iy+127), d             ; Error
 res 3, (iy+127), e             ; Error
 res 3, (iy+127), h             ; Error
 res 3, (iy+127), l             ; Error
 res 3, (iy-128)                ; Error
 res 3, (iy-128), a             ; Error
 res 3, (iy-128), b             ; Error
 res 3, (iy-128), c             ; Error
 res 3, (iy-128), d             ; Error
 res 3, (iy-128), e             ; Error
 res 3, (iy-128), h             ; Error
 res 3, (iy-128), l             ; Error
 res 4, (ix)                    ; Error
 res 4, (ix), a                 ; Error
 res 4, (ix), b                 ; Error
 res 4, (ix), c                 ; Error
 res 4, (ix), d                 ; Error
 res 4, (ix), e                 ; Error
 res 4, (ix), h                 ; Error
 res 4, (ix), l                 ; Error
 res 4, (ix+127)                ; Error
 res 4, (ix+127), a             ; Error
 res 4, (ix+127), b             ; Error
 res 4, (ix+127), c             ; Error
 res 4, (ix+127), d             ; Error
 res 4, (ix+127), e             ; Error
 res 4, (ix+127), h             ; Error
 res 4, (ix+127), l             ; Error
 res 4, (ix-128)                ; Error
 res 4, (ix-128), a             ; Error
 res 4, (ix-128), b             ; Error
 res 4, (ix-128), c             ; Error
 res 4, (ix-128), d             ; Error
 res 4, (ix-128), e             ; Error
 res 4, (ix-128), h             ; Error
 res 4, (ix-128), l             ; Error
 res 4, (iy)                    ; Error
 res 4, (iy), a                 ; Error
 res 4, (iy), b                 ; Error
 res 4, (iy), c                 ; Error
 res 4, (iy), d                 ; Error
 res 4, (iy), e                 ; Error
 res 4, (iy), h                 ; Error
 res 4, (iy), l                 ; Error
 res 4, (iy+127)                ; Error
 res 4, (iy+127), a             ; Error
 res 4, (iy+127), b             ; Error
 res 4, (iy+127), c             ; Error
 res 4, (iy+127), d             ; Error
 res 4, (iy+127), e             ; Error
 res 4, (iy+127), h             ; Error
 res 4, (iy+127), l             ; Error
 res 4, (iy-128)                ; Error
 res 4, (iy-128), a             ; Error
 res 4, (iy-128), b             ; Error
 res 4, (iy-128), c             ; Error
 res 4, (iy-128), d             ; Error
 res 4, (iy-128), e             ; Error
 res 4, (iy-128), h             ; Error
 res 4, (iy-128), l             ; Error
 res 5, (ix)                    ; Error
 res 5, (ix), a                 ; Error
 res 5, (ix), b                 ; Error
 res 5, (ix), c                 ; Error
 res 5, (ix), d                 ; Error
 res 5, (ix), e                 ; Error
 res 5, (ix), h                 ; Error
 res 5, (ix), l                 ; Error
 res 5, (ix+127)                ; Error
 res 5, (ix+127), a             ; Error
 res 5, (ix+127), b             ; Error
 res 5, (ix+127), c             ; Error
 res 5, (ix+127), d             ; Error
 res 5, (ix+127), e             ; Error
 res 5, (ix+127), h             ; Error
 res 5, (ix+127), l             ; Error
 res 5, (ix-128)                ; Error
 res 5, (ix-128), a             ; Error
 res 5, (ix-128), b             ; Error
 res 5, (ix-128), c             ; Error
 res 5, (ix-128), d             ; Error
 res 5, (ix-128), e             ; Error
 res 5, (ix-128), h             ; Error
 res 5, (ix-128), l             ; Error
 res 5, (iy)                    ; Error
 res 5, (iy), a                 ; Error
 res 5, (iy), b                 ; Error
 res 5, (iy), c                 ; Error
 res 5, (iy), d                 ; Error
 res 5, (iy), e                 ; Error
 res 5, (iy), h                 ; Error
 res 5, (iy), l                 ; Error
 res 5, (iy+127)                ; Error
 res 5, (iy+127), a             ; Error
 res 5, (iy+127), b             ; Error
 res 5, (iy+127), c             ; Error
 res 5, (iy+127), d             ; Error
 res 5, (iy+127), e             ; Error
 res 5, (iy+127), h             ; Error
 res 5, (iy+127), l             ; Error
 res 5, (iy-128)                ; Error
 res 5, (iy-128), a             ; Error
 res 5, (iy-128), b             ; Error
 res 5, (iy-128), c             ; Error
 res 5, (iy-128), d             ; Error
 res 5, (iy-128), e             ; Error
 res 5, (iy-128), h             ; Error
 res 5, (iy-128), l             ; Error
 res 6, (ix)                    ; Error
 res 6, (ix), a                 ; Error
 res 6, (ix), b                 ; Error
 res 6, (ix), c                 ; Error
 res 6, (ix), d                 ; Error
 res 6, (ix), e                 ; Error
 res 6, (ix), h                 ; Error
 res 6, (ix), l                 ; Error
 res 6, (ix+127)                ; Error
 res 6, (ix+127), a             ; Error
 res 6, (ix+127), b             ; Error
 res 6, (ix+127), c             ; Error
 res 6, (ix+127), d             ; Error
 res 6, (ix+127), e             ; Error
 res 6, (ix+127), h             ; Error
 res 6, (ix+127), l             ; Error
 res 6, (ix-128)                ; Error
 res 6, (ix-128), a             ; Error
 res 6, (ix-128), b             ; Error
 res 6, (ix-128), c             ; Error
 res 6, (ix-128), d             ; Error
 res 6, (ix-128), e             ; Error
 res 6, (ix-128), h             ; Error
 res 6, (ix-128), l             ; Error
 res 6, (iy)                    ; Error
 res 6, (iy), a                 ; Error
 res 6, (iy), b                 ; Error
 res 6, (iy), c                 ; Error
 res 6, (iy), d                 ; Error
 res 6, (iy), e                 ; Error
 res 6, (iy), h                 ; Error
 res 6, (iy), l                 ; Error
 res 6, (iy+127)                ; Error
 res 6, (iy+127), a             ; Error
 res 6, (iy+127), b             ; Error
 res 6, (iy+127), c             ; Error
 res 6, (iy+127), d             ; Error
 res 6, (iy+127), e             ; Error
 res 6, (iy+127), h             ; Error
 res 6, (iy+127), l             ; Error
 res 6, (iy-128)                ; Error
 res 6, (iy-128), a             ; Error
 res 6, (iy-128), b             ; Error
 res 6, (iy-128), c             ; Error
 res 6, (iy-128), d             ; Error
 res 6, (iy-128), e             ; Error
 res 6, (iy-128), h             ; Error
 res 6, (iy-128), l             ; Error
 res 7, (ix)                    ; Error
 res 7, (ix), a                 ; Error
 res 7, (ix), b                 ; Error
 res 7, (ix), c                 ; Error
 res 7, (ix), d                 ; Error
 res 7, (ix), e                 ; Error
 res 7, (ix), h                 ; Error
 res 7, (ix), l                 ; Error
 res 7, (ix+127)                ; Error
 res 7, (ix+127), a             ; Error
 res 7, (ix+127), b             ; Error
 res 7, (ix+127), c             ; Error
 res 7, (ix+127), d             ; Error
 res 7, (ix+127), e             ; Error
 res 7, (ix+127), h             ; Error
 res 7, (ix+127), l             ; Error
 res 7, (ix-128)                ; Error
 res 7, (ix-128), a             ; Error
 res 7, (ix-128), b             ; Error
 res 7, (ix-128), c             ; Error
 res 7, (ix-128), d             ; Error
 res 7, (ix-128), e             ; Error
 res 7, (ix-128), h             ; Error
 res 7, (ix-128), l             ; Error
 res 7, (iy)                    ; Error
 res 7, (iy), a                 ; Error
 res 7, (iy), b                 ; Error
 res 7, (iy), c                 ; Error
 res 7, (iy), d                 ; Error
 res 7, (iy), e                 ; Error
 res 7, (iy), h                 ; Error
 res 7, (iy), l                 ; Error
 res 7, (iy+127)                ; Error
 res 7, (iy+127), a             ; Error
 res 7, (iy+127), b             ; Error
 res 7, (iy+127), c             ; Error
 res 7, (iy+127), d             ; Error
 res 7, (iy+127), e             ; Error
 res 7, (iy+127), h             ; Error
 res 7, (iy+127), l             ; Error
 res 7, (iy-128)                ; Error
 res 7, (iy-128), a             ; Error
 res 7, (iy-128), b             ; Error
 res 7, (iy-128), c             ; Error
 res 7, (iy-128), d             ; Error
 res 7, (iy-128), e             ; Error
 res 7, (iy-128), h             ; Error
 res 7, (iy-128), l             ; Error
 res a, 0, (ix)                 ; Error
 res a, 0, (ix+127)             ; Error
 res a, 0, (ix-128)             ; Error
 res a, 0, (iy)                 ; Error
 res a, 0, (iy+127)             ; Error
 res a, 0, (iy-128)             ; Error
 res a, 1, (ix)                 ; Error
 res a, 1, (ix+127)             ; Error
 res a, 1, (ix-128)             ; Error
 res a, 1, (iy)                 ; Error
 res a, 1, (iy+127)             ; Error
 res a, 1, (iy-128)             ; Error
 res a, 2, (ix)                 ; Error
 res a, 2, (ix+127)             ; Error
 res a, 2, (ix-128)             ; Error
 res a, 2, (iy)                 ; Error
 res a, 2, (iy+127)             ; Error
 res a, 2, (iy-128)             ; Error
 res a, 3, (ix)                 ; Error
 res a, 3, (ix+127)             ; Error
 res a, 3, (ix-128)             ; Error
 res a, 3, (iy)                 ; Error
 res a, 3, (iy+127)             ; Error
 res a, 3, (iy-128)             ; Error
 res a, 4, (ix)                 ; Error
 res a, 4, (ix+127)             ; Error
 res a, 4, (ix-128)             ; Error
 res a, 4, (iy)                 ; Error
 res a, 4, (iy+127)             ; Error
 res a, 4, (iy-128)             ; Error
 res a, 5, (ix)                 ; Error
 res a, 5, (ix+127)             ; Error
 res a, 5, (ix-128)             ; Error
 res a, 5, (iy)                 ; Error
 res a, 5, (iy+127)             ; Error
 res a, 5, (iy-128)             ; Error
 res a, 6, (ix)                 ; Error
 res a, 6, (ix+127)             ; Error
 res a, 6, (ix-128)             ; Error
 res a, 6, (iy)                 ; Error
 res a, 6, (iy+127)             ; Error
 res a, 6, (iy-128)             ; Error
 res a, 7, (ix)                 ; Error
 res a, 7, (ix+127)             ; Error
 res a, 7, (ix-128)             ; Error
 res a, 7, (iy)                 ; Error
 res a, 7, (iy+127)             ; Error
 res a, 7, (iy-128)             ; Error
 res b, 0, (ix)                 ; Error
 res b, 0, (ix+127)             ; Error
 res b, 0, (ix-128)             ; Error
 res b, 0, (iy)                 ; Error
 res b, 0, (iy+127)             ; Error
 res b, 0, (iy-128)             ; Error
 res b, 1, (ix)                 ; Error
 res b, 1, (ix+127)             ; Error
 res b, 1, (ix-128)             ; Error
 res b, 1, (iy)                 ; Error
 res b, 1, (iy+127)             ; Error
 res b, 1, (iy-128)             ; Error
 res b, 2, (ix)                 ; Error
 res b, 2, (ix+127)             ; Error
 res b, 2, (ix-128)             ; Error
 res b, 2, (iy)                 ; Error
 res b, 2, (iy+127)             ; Error
 res b, 2, (iy-128)             ; Error
 res b, 3, (ix)                 ; Error
 res b, 3, (ix+127)             ; Error
 res b, 3, (ix-128)             ; Error
 res b, 3, (iy)                 ; Error
 res b, 3, (iy+127)             ; Error
 res b, 3, (iy-128)             ; Error
 res b, 4, (ix)                 ; Error
 res b, 4, (ix+127)             ; Error
 res b, 4, (ix-128)             ; Error
 res b, 4, (iy)                 ; Error
 res b, 4, (iy+127)             ; Error
 res b, 4, (iy-128)             ; Error
 res b, 5, (ix)                 ; Error
 res b, 5, (ix+127)             ; Error
 res b, 5, (ix-128)             ; Error
 res b, 5, (iy)                 ; Error
 res b, 5, (iy+127)             ; Error
 res b, 5, (iy-128)             ; Error
 res b, 6, (ix)                 ; Error
 res b, 6, (ix+127)             ; Error
 res b, 6, (ix-128)             ; Error
 res b, 6, (iy)                 ; Error
 res b, 6, (iy+127)             ; Error
 res b, 6, (iy-128)             ; Error
 res b, 7, (ix)                 ; Error
 res b, 7, (ix+127)             ; Error
 res b, 7, (ix-128)             ; Error
 res b, 7, (iy)                 ; Error
 res b, 7, (iy+127)             ; Error
 res b, 7, (iy-128)             ; Error
 res c, 0, (ix)                 ; Error
 res c, 0, (ix+127)             ; Error
 res c, 0, (ix-128)             ; Error
 res c, 0, (iy)                 ; Error
 res c, 0, (iy+127)             ; Error
 res c, 0, (iy-128)             ; Error
 res c, 1, (ix)                 ; Error
 res c, 1, (ix+127)             ; Error
 res c, 1, (ix-128)             ; Error
 res c, 1, (iy)                 ; Error
 res c, 1, (iy+127)             ; Error
 res c, 1, (iy-128)             ; Error
 res c, 2, (ix)                 ; Error
 res c, 2, (ix+127)             ; Error
 res c, 2, (ix-128)             ; Error
 res c, 2, (iy)                 ; Error
 res c, 2, (iy+127)             ; Error
 res c, 2, (iy-128)             ; Error
 res c, 3, (ix)                 ; Error
 res c, 3, (ix+127)             ; Error
 res c, 3, (ix-128)             ; Error
 res c, 3, (iy)                 ; Error
 res c, 3, (iy+127)             ; Error
 res c, 3, (iy-128)             ; Error
 res c, 4, (ix)                 ; Error
 res c, 4, (ix+127)             ; Error
 res c, 4, (ix-128)             ; Error
 res c, 4, (iy)                 ; Error
 res c, 4, (iy+127)             ; Error
 res c, 4, (iy-128)             ; Error
 res c, 5, (ix)                 ; Error
 res c, 5, (ix+127)             ; Error
 res c, 5, (ix-128)             ; Error
 res c, 5, (iy)                 ; Error
 res c, 5, (iy+127)             ; Error
 res c, 5, (iy-128)             ; Error
 res c, 6, (ix)                 ; Error
 res c, 6, (ix+127)             ; Error
 res c, 6, (ix-128)             ; Error
 res c, 6, (iy)                 ; Error
 res c, 6, (iy+127)             ; Error
 res c, 6, (iy-128)             ; Error
 res c, 7, (ix)                 ; Error
 res c, 7, (ix+127)             ; Error
 res c, 7, (ix-128)             ; Error
 res c, 7, (iy)                 ; Error
 res c, 7, (iy+127)             ; Error
 res c, 7, (iy-128)             ; Error
 res d, 0, (ix)                 ; Error
 res d, 0, (ix+127)             ; Error
 res d, 0, (ix-128)             ; Error
 res d, 0, (iy)                 ; Error
 res d, 0, (iy+127)             ; Error
 res d, 0, (iy-128)             ; Error
 res d, 1, (ix)                 ; Error
 res d, 1, (ix+127)             ; Error
 res d, 1, (ix-128)             ; Error
 res d, 1, (iy)                 ; Error
 res d, 1, (iy+127)             ; Error
 res d, 1, (iy-128)             ; Error
 res d, 2, (ix)                 ; Error
 res d, 2, (ix+127)             ; Error
 res d, 2, (ix-128)             ; Error
 res d, 2, (iy)                 ; Error
 res d, 2, (iy+127)             ; Error
 res d, 2, (iy-128)             ; Error
 res d, 3, (ix)                 ; Error
 res d, 3, (ix+127)             ; Error
 res d, 3, (ix-128)             ; Error
 res d, 3, (iy)                 ; Error
 res d, 3, (iy+127)             ; Error
 res d, 3, (iy-128)             ; Error
 res d, 4, (ix)                 ; Error
 res d, 4, (ix+127)             ; Error
 res d, 4, (ix-128)             ; Error
 res d, 4, (iy)                 ; Error
 res d, 4, (iy+127)             ; Error
 res d, 4, (iy-128)             ; Error
 res d, 5, (ix)                 ; Error
 res d, 5, (ix+127)             ; Error
 res d, 5, (ix-128)             ; Error
 res d, 5, (iy)                 ; Error
 res d, 5, (iy+127)             ; Error
 res d, 5, (iy-128)             ; Error
 res d, 6, (ix)                 ; Error
 res d, 6, (ix+127)             ; Error
 res d, 6, (ix-128)             ; Error
 res d, 6, (iy)                 ; Error
 res d, 6, (iy+127)             ; Error
 res d, 6, (iy-128)             ; Error
 res d, 7, (ix)                 ; Error
 res d, 7, (ix+127)             ; Error
 res d, 7, (ix-128)             ; Error
 res d, 7, (iy)                 ; Error
 res d, 7, (iy+127)             ; Error
 res d, 7, (iy-128)             ; Error
 res e, 0, (ix)                 ; Error
 res e, 0, (ix+127)             ; Error
 res e, 0, (ix-128)             ; Error
 res e, 0, (iy)                 ; Error
 res e, 0, (iy+127)             ; Error
 res e, 0, (iy-128)             ; Error
 res e, 1, (ix)                 ; Error
 res e, 1, (ix+127)             ; Error
 res e, 1, (ix-128)             ; Error
 res e, 1, (iy)                 ; Error
 res e, 1, (iy+127)             ; Error
 res e, 1, (iy-128)             ; Error
 res e, 2, (ix)                 ; Error
 res e, 2, (ix+127)             ; Error
 res e, 2, (ix-128)             ; Error
 res e, 2, (iy)                 ; Error
 res e, 2, (iy+127)             ; Error
 res e, 2, (iy-128)             ; Error
 res e, 3, (ix)                 ; Error
 res e, 3, (ix+127)             ; Error
 res e, 3, (ix-128)             ; Error
 res e, 3, (iy)                 ; Error
 res e, 3, (iy+127)             ; Error
 res e, 3, (iy-128)             ; Error
 res e, 4, (ix)                 ; Error
 res e, 4, (ix+127)             ; Error
 res e, 4, (ix-128)             ; Error
 res e, 4, (iy)                 ; Error
 res e, 4, (iy+127)             ; Error
 res e, 4, (iy-128)             ; Error
 res e, 5, (ix)                 ; Error
 res e, 5, (ix+127)             ; Error
 res e, 5, (ix-128)             ; Error
 res e, 5, (iy)                 ; Error
 res e, 5, (iy+127)             ; Error
 res e, 5, (iy-128)             ; Error
 res e, 6, (ix)                 ; Error
 res e, 6, (ix+127)             ; Error
 res e, 6, (ix-128)             ; Error
 res e, 6, (iy)                 ; Error
 res e, 6, (iy+127)             ; Error
 res e, 6, (iy-128)             ; Error
 res e, 7, (ix)                 ; Error
 res e, 7, (ix+127)             ; Error
 res e, 7, (ix-128)             ; Error
 res e, 7, (iy)                 ; Error
 res e, 7, (iy+127)             ; Error
 res e, 7, (iy-128)             ; Error
 res h, 0, (ix)                 ; Error
 res h, 0, (ix+127)             ; Error
 res h, 0, (ix-128)             ; Error
 res h, 0, (iy)                 ; Error
 res h, 0, (iy+127)             ; Error
 res h, 0, (iy-128)             ; Error
 res h, 1, (ix)                 ; Error
 res h, 1, (ix+127)             ; Error
 res h, 1, (ix-128)             ; Error
 res h, 1, (iy)                 ; Error
 res h, 1, (iy+127)             ; Error
 res h, 1, (iy-128)             ; Error
 res h, 2, (ix)                 ; Error
 res h, 2, (ix+127)             ; Error
 res h, 2, (ix-128)             ; Error
 res h, 2, (iy)                 ; Error
 res h, 2, (iy+127)             ; Error
 res h, 2, (iy-128)             ; Error
 res h, 3, (ix)                 ; Error
 res h, 3, (ix+127)             ; Error
 res h, 3, (ix-128)             ; Error
 res h, 3, (iy)                 ; Error
 res h, 3, (iy+127)             ; Error
 res h, 3, (iy-128)             ; Error
 res h, 4, (ix)                 ; Error
 res h, 4, (ix+127)             ; Error
 res h, 4, (ix-128)             ; Error
 res h, 4, (iy)                 ; Error
 res h, 4, (iy+127)             ; Error
 res h, 4, (iy-128)             ; Error
 res h, 5, (ix)                 ; Error
 res h, 5, (ix+127)             ; Error
 res h, 5, (ix-128)             ; Error
 res h, 5, (iy)                 ; Error
 res h, 5, (iy+127)             ; Error
 res h, 5, (iy-128)             ; Error
 res h, 6, (ix)                 ; Error
 res h, 6, (ix+127)             ; Error
 res h, 6, (ix-128)             ; Error
 res h, 6, (iy)                 ; Error
 res h, 6, (iy+127)             ; Error
 res h, 6, (iy-128)             ; Error
 res h, 7, (ix)                 ; Error
 res h, 7, (ix+127)             ; Error
 res h, 7, (ix-128)             ; Error
 res h, 7, (iy)                 ; Error
 res h, 7, (iy+127)             ; Error
 res h, 7, (iy-128)             ; Error
 res l, 0, (ix)                 ; Error
 res l, 0, (ix+127)             ; Error
 res l, 0, (ix-128)             ; Error
 res l, 0, (iy)                 ; Error
 res l, 0, (iy+127)             ; Error
 res l, 0, (iy-128)             ; Error
 res l, 1, (ix)                 ; Error
 res l, 1, (ix+127)             ; Error
 res l, 1, (ix-128)             ; Error
 res l, 1, (iy)                 ; Error
 res l, 1, (iy+127)             ; Error
 res l, 1, (iy-128)             ; Error
 res l, 2, (ix)                 ; Error
 res l, 2, (ix+127)             ; Error
 res l, 2, (ix-128)             ; Error
 res l, 2, (iy)                 ; Error
 res l, 2, (iy+127)             ; Error
 res l, 2, (iy-128)             ; Error
 res l, 3, (ix)                 ; Error
 res l, 3, (ix+127)             ; Error
 res l, 3, (ix-128)             ; Error
 res l, 3, (iy)                 ; Error
 res l, 3, (iy+127)             ; Error
 res l, 3, (iy-128)             ; Error
 res l, 4, (ix)                 ; Error
 res l, 4, (ix+127)             ; Error
 res l, 4, (ix-128)             ; Error
 res l, 4, (iy)                 ; Error
 res l, 4, (iy+127)             ; Error
 res l, 4, (iy-128)             ; Error
 res l, 5, (ix)                 ; Error
 res l, 5, (ix+127)             ; Error
 res l, 5, (ix-128)             ; Error
 res l, 5, (iy)                 ; Error
 res l, 5, (iy+127)             ; Error
 res l, 5, (iy-128)             ; Error
 res l, 6, (ix)                 ; Error
 res l, 6, (ix+127)             ; Error
 res l, 6, (ix-128)             ; Error
 res l, 6, (iy)                 ; Error
 res l, 6, (iy+127)             ; Error
 res l, 6, (iy-128)             ; Error
 res l, 7, (ix)                 ; Error
 res l, 7, (ix+127)             ; Error
 res l, 7, (ix-128)             ; Error
 res l, 7, (iy)                 ; Error
 res l, 7, (iy+127)             ; Error
 res l, 7, (iy-128)             ; Error
 ret m                          ; Error
 ret nv                         ; Error
 ret p                          ; Error
 ret pe                         ; Error
 ret po                         ; Error
 ret v                          ; Error
 retn                           ; Error
 rim                            ; Error
 rl (ix)                        ; Error
 rl (ix), a                     ; Error
 rl (ix), b                     ; Error
 rl (ix), c                     ; Error
 rl (ix), d                     ; Error
 rl (ix), e                     ; Error
 rl (ix), h                     ; Error
 rl (ix), l                     ; Error
 rl (ix+127)                    ; Error
 rl (ix+127), a                 ; Error
 rl (ix+127), b                 ; Error
 rl (ix+127), c                 ; Error
 rl (ix+127), d                 ; Error
 rl (ix+127), e                 ; Error
 rl (ix+127), h                 ; Error
 rl (ix+127), l                 ; Error
 rl (ix-128)                    ; Error
 rl (ix-128), a                 ; Error
 rl (ix-128), b                 ; Error
 rl (ix-128), c                 ; Error
 rl (ix-128), d                 ; Error
 rl (ix-128), e                 ; Error
 rl (ix-128), h                 ; Error
 rl (ix-128), l                 ; Error
 rl (iy)                        ; Error
 rl (iy), a                     ; Error
 rl (iy), b                     ; Error
 rl (iy), c                     ; Error
 rl (iy), d                     ; Error
 rl (iy), e                     ; Error
 rl (iy), h                     ; Error
 rl (iy), l                     ; Error
 rl (iy+127)                    ; Error
 rl (iy+127), a                 ; Error
 rl (iy+127), b                 ; Error
 rl (iy+127), c                 ; Error
 rl (iy+127), d                 ; Error
 rl (iy+127), e                 ; Error
 rl (iy+127), h                 ; Error
 rl (iy+127), l                 ; Error
 rl (iy-128)                    ; Error
 rl (iy-128), a                 ; Error
 rl (iy-128), b                 ; Error
 rl (iy-128), c                 ; Error
 rl (iy-128), d                 ; Error
 rl (iy-128), e                 ; Error
 rl (iy-128), h                 ; Error
 rl (iy-128), l                 ; Error
 rl a, (ix)                     ; Error
 rl a, (ix+127)                 ; Error
 rl a, (ix-128)                 ; Error
 rl a, (iy)                     ; Error
 rl a, (iy+127)                 ; Error
 rl a, (iy-128)                 ; Error
 rl b, (ix)                     ; Error
 rl b, (ix+127)                 ; Error
 rl b, (ix-128)                 ; Error
 rl b, (iy)                     ; Error
 rl b, (iy+127)                 ; Error
 rl b, (iy-128)                 ; Error
 rl c, (ix)                     ; Error
 rl c, (ix+127)                 ; Error
 rl c, (ix-128)                 ; Error
 rl c, (iy)                     ; Error
 rl c, (iy+127)                 ; Error
 rl c, (iy-128)                 ; Error
 rl d, (ix)                     ; Error
 rl d, (ix+127)                 ; Error
 rl d, (ix-128)                 ; Error
 rl d, (iy)                     ; Error
 rl d, (iy+127)                 ; Error
 rl d, (iy-128)                 ; Error
 rl e, (ix)                     ; Error
 rl e, (ix+127)                 ; Error
 rl e, (ix-128)                 ; Error
 rl e, (iy)                     ; Error
 rl e, (iy+127)                 ; Error
 rl e, (iy-128)                 ; Error
 rl h, (ix)                     ; Error
 rl h, (ix+127)                 ; Error
 rl h, (ix-128)                 ; Error
 rl h, (iy)                     ; Error
 rl h, (iy+127)                 ; Error
 rl h, (iy-128)                 ; Error
 rl l, (ix)                     ; Error
 rl l, (ix+127)                 ; Error
 rl l, (ix-128)                 ; Error
 rl l, (iy)                     ; Error
 rl l, (iy+127)                 ; Error
 rl l, (iy-128)                 ; Error
 rlc (ix)                       ; Error
 rlc (ix), a                    ; Error
 rlc (ix), b                    ; Error
 rlc (ix), c                    ; Error
 rlc (ix), d                    ; Error
 rlc (ix), e                    ; Error
 rlc (ix), h                    ; Error
 rlc (ix), l                    ; Error
 rlc (ix+127)                   ; Error
 rlc (ix+127), a                ; Error
 rlc (ix+127), b                ; Error
 rlc (ix+127), c                ; Error
 rlc (ix+127), d                ; Error
 rlc (ix+127), e                ; Error
 rlc (ix+127), h                ; Error
 rlc (ix+127), l                ; Error
 rlc (ix-128)                   ; Error
 rlc (ix-128), a                ; Error
 rlc (ix-128), b                ; Error
 rlc (ix-128), c                ; Error
 rlc (ix-128), d                ; Error
 rlc (ix-128), e                ; Error
 rlc (ix-128), h                ; Error
 rlc (ix-128), l                ; Error
 rlc (iy)                       ; Error
 rlc (iy), a                    ; Error
 rlc (iy), b                    ; Error
 rlc (iy), c                    ; Error
 rlc (iy), d                    ; Error
 rlc (iy), e                    ; Error
 rlc (iy), h                    ; Error
 rlc (iy), l                    ; Error
 rlc (iy+127)                   ; Error
 rlc (iy+127), a                ; Error
 rlc (iy+127), b                ; Error
 rlc (iy+127), c                ; Error
 rlc (iy+127), d                ; Error
 rlc (iy+127), e                ; Error
 rlc (iy+127), h                ; Error
 rlc (iy+127), l                ; Error
 rlc (iy-128)                   ; Error
 rlc (iy-128), a                ; Error
 rlc (iy-128), b                ; Error
 rlc (iy-128), c                ; Error
 rlc (iy-128), d                ; Error
 rlc (iy-128), e                ; Error
 rlc (iy-128), h                ; Error
 rlc (iy-128), l                ; Error
 rlc a, (ix)                    ; Error
 rlc a, (ix+127)                ; Error
 rlc a, (ix-128)                ; Error
 rlc a, (iy)                    ; Error
 rlc a, (iy+127)                ; Error
 rlc a, (iy-128)                ; Error
 rlc b, (ix)                    ; Error
 rlc b, (ix+127)                ; Error
 rlc b, (ix-128)                ; Error
 rlc b, (iy)                    ; Error
 rlc b, (iy+127)                ; Error
 rlc b, (iy-128)                ; Error
 rlc c, (ix)                    ; Error
 rlc c, (ix+127)                ; Error
 rlc c, (ix-128)                ; Error
 rlc c, (iy)                    ; Error
 rlc c, (iy+127)                ; Error
 rlc c, (iy-128)                ; Error
 rlc d, (ix)                    ; Error
 rlc d, (ix+127)                ; Error
 rlc d, (ix-128)                ; Error
 rlc d, (iy)                    ; Error
 rlc d, (iy+127)                ; Error
 rlc d, (iy-128)                ; Error
 rlc e, (ix)                    ; Error
 rlc e, (ix+127)                ; Error
 rlc e, (ix-128)                ; Error
 rlc e, (iy)                    ; Error
 rlc e, (iy+127)                ; Error
 rlc e, (iy-128)                ; Error
 rlc h, (ix)                    ; Error
 rlc h, (ix+127)                ; Error
 rlc h, (ix-128)                ; Error
 rlc h, (iy)                    ; Error
 rlc h, (iy+127)                ; Error
 rlc h, (iy-128)                ; Error
 rlc l, (ix)                    ; Error
 rlc l, (ix+127)                ; Error
 rlc l, (ix-128)                ; Error
 rlc l, (iy)                    ; Error
 rlc l, (iy+127)                ; Error
 rlc l, (iy-128)                ; Error
 rm                             ; Error
 rnv                            ; Error
 rp                             ; Error
 rpe                            ; Error
 rpo                            ; Error
 rr (ix)                        ; Error
 rr (ix), a                     ; Error
 rr (ix), b                     ; Error
 rr (ix), c                     ; Error
 rr (ix), d                     ; Error
 rr (ix), e                     ; Error
 rr (ix), h                     ; Error
 rr (ix), l                     ; Error
 rr (ix+127)                    ; Error
 rr (ix+127), a                 ; Error
 rr (ix+127), b                 ; Error
 rr (ix+127), c                 ; Error
 rr (ix+127), d                 ; Error
 rr (ix+127), e                 ; Error
 rr (ix+127), h                 ; Error
 rr (ix+127), l                 ; Error
 rr (ix-128)                    ; Error
 rr (ix-128), a                 ; Error
 rr (ix-128), b                 ; Error
 rr (ix-128), c                 ; Error
 rr (ix-128), d                 ; Error
 rr (ix-128), e                 ; Error
 rr (ix-128), h                 ; Error
 rr (ix-128), l                 ; Error
 rr (iy)                        ; Error
 rr (iy), a                     ; Error
 rr (iy), b                     ; Error
 rr (iy), c                     ; Error
 rr (iy), d                     ; Error
 rr (iy), e                     ; Error
 rr (iy), h                     ; Error
 rr (iy), l                     ; Error
 rr (iy+127)                    ; Error
 rr (iy+127), a                 ; Error
 rr (iy+127), b                 ; Error
 rr (iy+127), c                 ; Error
 rr (iy+127), d                 ; Error
 rr (iy+127), e                 ; Error
 rr (iy+127), h                 ; Error
 rr (iy+127), l                 ; Error
 rr (iy-128)                    ; Error
 rr (iy-128), a                 ; Error
 rr (iy-128), b                 ; Error
 rr (iy-128), c                 ; Error
 rr (iy-128), d                 ; Error
 rr (iy-128), e                 ; Error
 rr (iy-128), h                 ; Error
 rr (iy-128), l                 ; Error
 rr a, (ix)                     ; Error
 rr a, (ix+127)                 ; Error
 rr a, (ix-128)                 ; Error
 rr a, (iy)                     ; Error
 rr a, (iy+127)                 ; Error
 rr a, (iy-128)                 ; Error
 rr b, (ix)                     ; Error
 rr b, (ix+127)                 ; Error
 rr b, (ix-128)                 ; Error
 rr b, (iy)                     ; Error
 rr b, (iy+127)                 ; Error
 rr b, (iy-128)                 ; Error
 rr c, (ix)                     ; Error
 rr c, (ix+127)                 ; Error
 rr c, (ix-128)                 ; Error
 rr c, (iy)                     ; Error
 rr c, (iy+127)                 ; Error
 rr c, (iy-128)                 ; Error
 rr d, (ix)                     ; Error
 rr d, (ix+127)                 ; Error
 rr d, (ix-128)                 ; Error
 rr d, (iy)                     ; Error
 rr d, (iy+127)                 ; Error
 rr d, (iy-128)                 ; Error
 rr e, (ix)                     ; Error
 rr e, (ix+127)                 ; Error
 rr e, (ix-128)                 ; Error
 rr e, (iy)                     ; Error
 rr e, (iy+127)                 ; Error
 rr e, (iy-128)                 ; Error
 rr h, (ix)                     ; Error
 rr h, (ix+127)                 ; Error
 rr h, (ix-128)                 ; Error
 rr h, (iy)                     ; Error
 rr h, (iy+127)                 ; Error
 rr h, (iy-128)                 ; Error
 rr l, (ix)                     ; Error
 rr l, (ix+127)                 ; Error
 rr l, (ix-128)                 ; Error
 rr l, (iy)                     ; Error
 rr l, (iy+127)                 ; Error
 rr l, (iy-128)                 ; Error
 rrc (ix)                       ; Error
 rrc (ix), a                    ; Error
 rrc (ix), b                    ; Error
 rrc (ix), c                    ; Error
 rrc (ix), d                    ; Error
 rrc (ix), e                    ; Error
 rrc (ix), h                    ; Error
 rrc (ix), l                    ; Error
 rrc (ix+127)                   ; Error
 rrc (ix+127), a                ; Error
 rrc (ix+127), b                ; Error
 rrc (ix+127), c                ; Error
 rrc (ix+127), d                ; Error
 rrc (ix+127), e                ; Error
 rrc (ix+127), h                ; Error
 rrc (ix+127), l                ; Error
 rrc (ix-128)                   ; Error
 rrc (ix-128), a                ; Error
 rrc (ix-128), b                ; Error
 rrc (ix-128), c                ; Error
 rrc (ix-128), d                ; Error
 rrc (ix-128), e                ; Error
 rrc (ix-128), h                ; Error
 rrc (ix-128), l                ; Error
 rrc (iy)                       ; Error
 rrc (iy), a                    ; Error
 rrc (iy), b                    ; Error
 rrc (iy), c                    ; Error
 rrc (iy), d                    ; Error
 rrc (iy), e                    ; Error
 rrc (iy), h                    ; Error
 rrc (iy), l                    ; Error
 rrc (iy+127)                   ; Error
 rrc (iy+127), a                ; Error
 rrc (iy+127), b                ; Error
 rrc (iy+127), c                ; Error
 rrc (iy+127), d                ; Error
 rrc (iy+127), e                ; Error
 rrc (iy+127), h                ; Error
 rrc (iy+127), l                ; Error
 rrc (iy-128)                   ; Error
 rrc (iy-128), a                ; Error
 rrc (iy-128), b                ; Error
 rrc (iy-128), c                ; Error
 rrc (iy-128), d                ; Error
 rrc (iy-128), e                ; Error
 rrc (iy-128), h                ; Error
 rrc (iy-128), l                ; Error
 rrc a, (ix)                    ; Error
 rrc a, (ix+127)                ; Error
 rrc a, (ix-128)                ; Error
 rrc a, (iy)                    ; Error
 rrc a, (iy+127)                ; Error
 rrc a, (iy-128)                ; Error
 rrc b, (ix)                    ; Error
 rrc b, (ix+127)                ; Error
 rrc b, (ix-128)                ; Error
 rrc b, (iy)                    ; Error
 rrc b, (iy+127)                ; Error
 rrc b, (iy-128)                ; Error
 rrc c, (ix)                    ; Error
 rrc c, (ix+127)                ; Error
 rrc c, (ix-128)                ; Error
 rrc c, (iy)                    ; Error
 rrc c, (iy+127)                ; Error
 rrc c, (iy-128)                ; Error
 rrc d, (ix)                    ; Error
 rrc d, (ix+127)                ; Error
 rrc d, (ix-128)                ; Error
 rrc d, (iy)                    ; Error
 rrc d, (iy+127)                ; Error
 rrc d, (iy-128)                ; Error
 rrc e, (ix)                    ; Error
 rrc e, (ix+127)                ; Error
 rrc e, (ix-128)                ; Error
 rrc e, (iy)                    ; Error
 rrc e, (iy+127)                ; Error
 rrc e, (iy-128)                ; Error
 rrc h, (ix)                    ; Error
 rrc h, (ix+127)                ; Error
 rrc h, (ix-128)                ; Error
 rrc h, (iy)                    ; Error
 rrc h, (iy+127)                ; Error
 rrc h, (iy-128)                ; Error
 rrc l, (ix)                    ; Error
 rrc l, (ix+127)                ; Error
 rrc l, (ix-128)                ; Error
 rrc l, (iy)                    ; Error
 rrc l, (iy+127)                ; Error
 rrc l, (iy-128)                ; Error
 rstv                           ; Error
 rv                             ; Error
 sbc (ix)                       ; Error
 sbc (ix+127)                   ; Error
 sbc (ix-128)                   ; Error
 sbc (iy)                       ; Error
 sbc (iy+127)                   ; Error
 sbc (iy-128)                   ; Error
 sbc a, (ix)                    ; Error
 sbc a, (ix+127)                ; Error
 sbc a, (ix-128)                ; Error
 sbc a, (iy)                    ; Error
 sbc a, (iy+127)                ; Error
 sbc a, (iy-128)                ; Error
 set 0, (ix)                    ; Error
 set 0, (ix), a                 ; Error
 set 0, (ix), b                 ; Error
 set 0, (ix), c                 ; Error
 set 0, (ix), d                 ; Error
 set 0, (ix), e                 ; Error
 set 0, (ix), h                 ; Error
 set 0, (ix), l                 ; Error
 set 0, (ix+127)                ; Error
 set 0, (ix+127), a             ; Error
 set 0, (ix+127), b             ; Error
 set 0, (ix+127), c             ; Error
 set 0, (ix+127), d             ; Error
 set 0, (ix+127), e             ; Error
 set 0, (ix+127), h             ; Error
 set 0, (ix+127), l             ; Error
 set 0, (ix-128)                ; Error
 set 0, (ix-128), a             ; Error
 set 0, (ix-128), b             ; Error
 set 0, (ix-128), c             ; Error
 set 0, (ix-128), d             ; Error
 set 0, (ix-128), e             ; Error
 set 0, (ix-128), h             ; Error
 set 0, (ix-128), l             ; Error
 set 0, (iy)                    ; Error
 set 0, (iy), a                 ; Error
 set 0, (iy), b                 ; Error
 set 0, (iy), c                 ; Error
 set 0, (iy), d                 ; Error
 set 0, (iy), e                 ; Error
 set 0, (iy), h                 ; Error
 set 0, (iy), l                 ; Error
 set 0, (iy+127)                ; Error
 set 0, (iy+127), a             ; Error
 set 0, (iy+127), b             ; Error
 set 0, (iy+127), c             ; Error
 set 0, (iy+127), d             ; Error
 set 0, (iy+127), e             ; Error
 set 0, (iy+127), h             ; Error
 set 0, (iy+127), l             ; Error
 set 0, (iy-128)                ; Error
 set 0, (iy-128), a             ; Error
 set 0, (iy-128), b             ; Error
 set 0, (iy-128), c             ; Error
 set 0, (iy-128), d             ; Error
 set 0, (iy-128), e             ; Error
 set 0, (iy-128), h             ; Error
 set 0, (iy-128), l             ; Error
 set 1, (ix)                    ; Error
 set 1, (ix), a                 ; Error
 set 1, (ix), b                 ; Error
 set 1, (ix), c                 ; Error
 set 1, (ix), d                 ; Error
 set 1, (ix), e                 ; Error
 set 1, (ix), h                 ; Error
 set 1, (ix), l                 ; Error
 set 1, (ix+127)                ; Error
 set 1, (ix+127), a             ; Error
 set 1, (ix+127), b             ; Error
 set 1, (ix+127), c             ; Error
 set 1, (ix+127), d             ; Error
 set 1, (ix+127), e             ; Error
 set 1, (ix+127), h             ; Error
 set 1, (ix+127), l             ; Error
 set 1, (ix-128)                ; Error
 set 1, (ix-128), a             ; Error
 set 1, (ix-128), b             ; Error
 set 1, (ix-128), c             ; Error
 set 1, (ix-128), d             ; Error
 set 1, (ix-128), e             ; Error
 set 1, (ix-128), h             ; Error
 set 1, (ix-128), l             ; Error
 set 1, (iy)                    ; Error
 set 1, (iy), a                 ; Error
 set 1, (iy), b                 ; Error
 set 1, (iy), c                 ; Error
 set 1, (iy), d                 ; Error
 set 1, (iy), e                 ; Error
 set 1, (iy), h                 ; Error
 set 1, (iy), l                 ; Error
 set 1, (iy+127)                ; Error
 set 1, (iy+127), a             ; Error
 set 1, (iy+127), b             ; Error
 set 1, (iy+127), c             ; Error
 set 1, (iy+127), d             ; Error
 set 1, (iy+127), e             ; Error
 set 1, (iy+127), h             ; Error
 set 1, (iy+127), l             ; Error
 set 1, (iy-128)                ; Error
 set 1, (iy-128), a             ; Error
 set 1, (iy-128), b             ; Error
 set 1, (iy-128), c             ; Error
 set 1, (iy-128), d             ; Error
 set 1, (iy-128), e             ; Error
 set 1, (iy-128), h             ; Error
 set 1, (iy-128), l             ; Error
 set 2, (ix)                    ; Error
 set 2, (ix), a                 ; Error
 set 2, (ix), b                 ; Error
 set 2, (ix), c                 ; Error
 set 2, (ix), d                 ; Error
 set 2, (ix), e                 ; Error
 set 2, (ix), h                 ; Error
 set 2, (ix), l                 ; Error
 set 2, (ix+127)                ; Error
 set 2, (ix+127), a             ; Error
 set 2, (ix+127), b             ; Error
 set 2, (ix+127), c             ; Error
 set 2, (ix+127), d             ; Error
 set 2, (ix+127), e             ; Error
 set 2, (ix+127), h             ; Error
 set 2, (ix+127), l             ; Error
 set 2, (ix-128)                ; Error
 set 2, (ix-128), a             ; Error
 set 2, (ix-128), b             ; Error
 set 2, (ix-128), c             ; Error
 set 2, (ix-128), d             ; Error
 set 2, (ix-128), e             ; Error
 set 2, (ix-128), h             ; Error
 set 2, (ix-128), l             ; Error
 set 2, (iy)                    ; Error
 set 2, (iy), a                 ; Error
 set 2, (iy), b                 ; Error
 set 2, (iy), c                 ; Error
 set 2, (iy), d                 ; Error
 set 2, (iy), e                 ; Error
 set 2, (iy), h                 ; Error
 set 2, (iy), l                 ; Error
 set 2, (iy+127)                ; Error
 set 2, (iy+127), a             ; Error
 set 2, (iy+127), b             ; Error
 set 2, (iy+127), c             ; Error
 set 2, (iy+127), d             ; Error
 set 2, (iy+127), e             ; Error
 set 2, (iy+127), h             ; Error
 set 2, (iy+127), l             ; Error
 set 2, (iy-128)                ; Error
 set 2, (iy-128), a             ; Error
 set 2, (iy-128), b             ; Error
 set 2, (iy-128), c             ; Error
 set 2, (iy-128), d             ; Error
 set 2, (iy-128), e             ; Error
 set 2, (iy-128), h             ; Error
 set 2, (iy-128), l             ; Error
 set 3, (ix)                    ; Error
 set 3, (ix), a                 ; Error
 set 3, (ix), b                 ; Error
 set 3, (ix), c                 ; Error
 set 3, (ix), d                 ; Error
 set 3, (ix), e                 ; Error
 set 3, (ix), h                 ; Error
 set 3, (ix), l                 ; Error
 set 3, (ix+127)                ; Error
 set 3, (ix+127), a             ; Error
 set 3, (ix+127), b             ; Error
 set 3, (ix+127), c             ; Error
 set 3, (ix+127), d             ; Error
 set 3, (ix+127), e             ; Error
 set 3, (ix+127), h             ; Error
 set 3, (ix+127), l             ; Error
 set 3, (ix-128)                ; Error
 set 3, (ix-128), a             ; Error
 set 3, (ix-128), b             ; Error
 set 3, (ix-128), c             ; Error
 set 3, (ix-128), d             ; Error
 set 3, (ix-128), e             ; Error
 set 3, (ix-128), h             ; Error
 set 3, (ix-128), l             ; Error
 set 3, (iy)                    ; Error
 set 3, (iy), a                 ; Error
 set 3, (iy), b                 ; Error
 set 3, (iy), c                 ; Error
 set 3, (iy), d                 ; Error
 set 3, (iy), e                 ; Error
 set 3, (iy), h                 ; Error
 set 3, (iy), l                 ; Error
 set 3, (iy+127)                ; Error
 set 3, (iy+127), a             ; Error
 set 3, (iy+127), b             ; Error
 set 3, (iy+127), c             ; Error
 set 3, (iy+127), d             ; Error
 set 3, (iy+127), e             ; Error
 set 3, (iy+127), h             ; Error
 set 3, (iy+127), l             ; Error
 set 3, (iy-128)                ; Error
 set 3, (iy-128), a             ; Error
 set 3, (iy-128), b             ; Error
 set 3, (iy-128), c             ; Error
 set 3, (iy-128), d             ; Error
 set 3, (iy-128), e             ; Error
 set 3, (iy-128), h             ; Error
 set 3, (iy-128), l             ; Error
 set 4, (ix)                    ; Error
 set 4, (ix), a                 ; Error
 set 4, (ix), b                 ; Error
 set 4, (ix), c                 ; Error
 set 4, (ix), d                 ; Error
 set 4, (ix), e                 ; Error
 set 4, (ix), h                 ; Error
 set 4, (ix), l                 ; Error
 set 4, (ix+127)                ; Error
 set 4, (ix+127), a             ; Error
 set 4, (ix+127), b             ; Error
 set 4, (ix+127), c             ; Error
 set 4, (ix+127), d             ; Error
 set 4, (ix+127), e             ; Error
 set 4, (ix+127), h             ; Error
 set 4, (ix+127), l             ; Error
 set 4, (ix-128)                ; Error
 set 4, (ix-128), a             ; Error
 set 4, (ix-128), b             ; Error
 set 4, (ix-128), c             ; Error
 set 4, (ix-128), d             ; Error
 set 4, (ix-128), e             ; Error
 set 4, (ix-128), h             ; Error
 set 4, (ix-128), l             ; Error
 set 4, (iy)                    ; Error
 set 4, (iy), a                 ; Error
 set 4, (iy), b                 ; Error
 set 4, (iy), c                 ; Error
 set 4, (iy), d                 ; Error
 set 4, (iy), e                 ; Error
 set 4, (iy), h                 ; Error
 set 4, (iy), l                 ; Error
 set 4, (iy+127)                ; Error
 set 4, (iy+127), a             ; Error
 set 4, (iy+127), b             ; Error
 set 4, (iy+127), c             ; Error
 set 4, (iy+127), d             ; Error
 set 4, (iy+127), e             ; Error
 set 4, (iy+127), h             ; Error
 set 4, (iy+127), l             ; Error
 set 4, (iy-128)                ; Error
 set 4, (iy-128), a             ; Error
 set 4, (iy-128), b             ; Error
 set 4, (iy-128), c             ; Error
 set 4, (iy-128), d             ; Error
 set 4, (iy-128), e             ; Error
 set 4, (iy-128), h             ; Error
 set 4, (iy-128), l             ; Error
 set 5, (ix)                    ; Error
 set 5, (ix), a                 ; Error
 set 5, (ix), b                 ; Error
 set 5, (ix), c                 ; Error
 set 5, (ix), d                 ; Error
 set 5, (ix), e                 ; Error
 set 5, (ix), h                 ; Error
 set 5, (ix), l                 ; Error
 set 5, (ix+127)                ; Error
 set 5, (ix+127), a             ; Error
 set 5, (ix+127), b             ; Error
 set 5, (ix+127), c             ; Error
 set 5, (ix+127), d             ; Error
 set 5, (ix+127), e             ; Error
 set 5, (ix+127), h             ; Error
 set 5, (ix+127), l             ; Error
 set 5, (ix-128)                ; Error
 set 5, (ix-128), a             ; Error
 set 5, (ix-128), b             ; Error
 set 5, (ix-128), c             ; Error
 set 5, (ix-128), d             ; Error
 set 5, (ix-128), e             ; Error
 set 5, (ix-128), h             ; Error
 set 5, (ix-128), l             ; Error
 set 5, (iy)                    ; Error
 set 5, (iy), a                 ; Error
 set 5, (iy), b                 ; Error
 set 5, (iy), c                 ; Error
 set 5, (iy), d                 ; Error
 set 5, (iy), e                 ; Error
 set 5, (iy), h                 ; Error
 set 5, (iy), l                 ; Error
 set 5, (iy+127)                ; Error
 set 5, (iy+127), a             ; Error
 set 5, (iy+127), b             ; Error
 set 5, (iy+127), c             ; Error
 set 5, (iy+127), d             ; Error
 set 5, (iy+127), e             ; Error
 set 5, (iy+127), h             ; Error
 set 5, (iy+127), l             ; Error
 set 5, (iy-128)                ; Error
 set 5, (iy-128), a             ; Error
 set 5, (iy-128), b             ; Error
 set 5, (iy-128), c             ; Error
 set 5, (iy-128), d             ; Error
 set 5, (iy-128), e             ; Error
 set 5, (iy-128), h             ; Error
 set 5, (iy-128), l             ; Error
 set 6, (ix)                    ; Error
 set 6, (ix), a                 ; Error
 set 6, (ix), b                 ; Error
 set 6, (ix), c                 ; Error
 set 6, (ix), d                 ; Error
 set 6, (ix), e                 ; Error
 set 6, (ix), h                 ; Error
 set 6, (ix), l                 ; Error
 set 6, (ix+127)                ; Error
 set 6, (ix+127), a             ; Error
 set 6, (ix+127), b             ; Error
 set 6, (ix+127), c             ; Error
 set 6, (ix+127), d             ; Error
 set 6, (ix+127), e             ; Error
 set 6, (ix+127), h             ; Error
 set 6, (ix+127), l             ; Error
 set 6, (ix-128)                ; Error
 set 6, (ix-128), a             ; Error
 set 6, (ix-128), b             ; Error
 set 6, (ix-128), c             ; Error
 set 6, (ix-128), d             ; Error
 set 6, (ix-128), e             ; Error
 set 6, (ix-128), h             ; Error
 set 6, (ix-128), l             ; Error
 set 6, (iy)                    ; Error
 set 6, (iy), a                 ; Error
 set 6, (iy), b                 ; Error
 set 6, (iy), c                 ; Error
 set 6, (iy), d                 ; Error
 set 6, (iy), e                 ; Error
 set 6, (iy), h                 ; Error
 set 6, (iy), l                 ; Error
 set 6, (iy+127)                ; Error
 set 6, (iy+127), a             ; Error
 set 6, (iy+127), b             ; Error
 set 6, (iy+127), c             ; Error
 set 6, (iy+127), d             ; Error
 set 6, (iy+127), e             ; Error
 set 6, (iy+127), h             ; Error
 set 6, (iy+127), l             ; Error
 set 6, (iy-128)                ; Error
 set 6, (iy-128), a             ; Error
 set 6, (iy-128), b             ; Error
 set 6, (iy-128), c             ; Error
 set 6, (iy-128), d             ; Error
 set 6, (iy-128), e             ; Error
 set 6, (iy-128), h             ; Error
 set 6, (iy-128), l             ; Error
 set 7, (ix)                    ; Error
 set 7, (ix), a                 ; Error
 set 7, (ix), b                 ; Error
 set 7, (ix), c                 ; Error
 set 7, (ix), d                 ; Error
 set 7, (ix), e                 ; Error
 set 7, (ix), h                 ; Error
 set 7, (ix), l                 ; Error
 set 7, (ix+127)                ; Error
 set 7, (ix+127), a             ; Error
 set 7, (ix+127), b             ; Error
 set 7, (ix+127), c             ; Error
 set 7, (ix+127), d             ; Error
 set 7, (ix+127), e             ; Error
 set 7, (ix+127), h             ; Error
 set 7, (ix+127), l             ; Error
 set 7, (ix-128)                ; Error
 set 7, (ix-128), a             ; Error
 set 7, (ix-128), b             ; Error
 set 7, (ix-128), c             ; Error
 set 7, (ix-128), d             ; Error
 set 7, (ix-128), e             ; Error
 set 7, (ix-128), h             ; Error
 set 7, (ix-128), l             ; Error
 set 7, (iy)                    ; Error
 set 7, (iy), a                 ; Error
 set 7, (iy), b                 ; Error
 set 7, (iy), c                 ; Error
 set 7, (iy), d                 ; Error
 set 7, (iy), e                 ; Error
 set 7, (iy), h                 ; Error
 set 7, (iy), l                 ; Error
 set 7, (iy+127)                ; Error
 set 7, (iy+127), a             ; Error
 set 7, (iy+127), b             ; Error
 set 7, (iy+127), c             ; Error
 set 7, (iy+127), d             ; Error
 set 7, (iy+127), e             ; Error
 set 7, (iy+127), h             ; Error
 set 7, (iy+127), l             ; Error
 set 7, (iy-128)                ; Error
 set 7, (iy-128), a             ; Error
 set 7, (iy-128), b             ; Error
 set 7, (iy-128), c             ; Error
 set 7, (iy-128), d             ; Error
 set 7, (iy-128), e             ; Error
 set 7, (iy-128), h             ; Error
 set 7, (iy-128), l             ; Error
 set a, 0, (ix)                 ; Error
 set a, 0, (ix+127)             ; Error
 set a, 0, (ix-128)             ; Error
 set a, 0, (iy)                 ; Error
 set a, 0, (iy+127)             ; Error
 set a, 0, (iy-128)             ; Error
 set a, 1, (ix)                 ; Error
 set a, 1, (ix+127)             ; Error
 set a, 1, (ix-128)             ; Error
 set a, 1, (iy)                 ; Error
 set a, 1, (iy+127)             ; Error
 set a, 1, (iy-128)             ; Error
 set a, 2, (ix)                 ; Error
 set a, 2, (ix+127)             ; Error
 set a, 2, (ix-128)             ; Error
 set a, 2, (iy)                 ; Error
 set a, 2, (iy+127)             ; Error
 set a, 2, (iy-128)             ; Error
 set a, 3, (ix)                 ; Error
 set a, 3, (ix+127)             ; Error
 set a, 3, (ix-128)             ; Error
 set a, 3, (iy)                 ; Error
 set a, 3, (iy+127)             ; Error
 set a, 3, (iy-128)             ; Error
 set a, 4, (ix)                 ; Error
 set a, 4, (ix+127)             ; Error
 set a, 4, (ix-128)             ; Error
 set a, 4, (iy)                 ; Error
 set a, 4, (iy+127)             ; Error
 set a, 4, (iy-128)             ; Error
 set a, 5, (ix)                 ; Error
 set a, 5, (ix+127)             ; Error
 set a, 5, (ix-128)             ; Error
 set a, 5, (iy)                 ; Error
 set a, 5, (iy+127)             ; Error
 set a, 5, (iy-128)             ; Error
 set a, 6, (ix)                 ; Error
 set a, 6, (ix+127)             ; Error
 set a, 6, (ix-128)             ; Error
 set a, 6, (iy)                 ; Error
 set a, 6, (iy+127)             ; Error
 set a, 6, (iy-128)             ; Error
 set a, 7, (ix)                 ; Error
 set a, 7, (ix+127)             ; Error
 set a, 7, (ix-128)             ; Error
 set a, 7, (iy)                 ; Error
 set a, 7, (iy+127)             ; Error
 set a, 7, (iy-128)             ; Error
 set b, 0, (ix)                 ; Error
 set b, 0, (ix+127)             ; Error
 set b, 0, (ix-128)             ; Error
 set b, 0, (iy)                 ; Error
 set b, 0, (iy+127)             ; Error
 set b, 0, (iy-128)             ; Error
 set b, 1, (ix)                 ; Error
 set b, 1, (ix+127)             ; Error
 set b, 1, (ix-128)             ; Error
 set b, 1, (iy)                 ; Error
 set b, 1, (iy+127)             ; Error
 set b, 1, (iy-128)             ; Error
 set b, 2, (ix)                 ; Error
 set b, 2, (ix+127)             ; Error
 set b, 2, (ix-128)             ; Error
 set b, 2, (iy)                 ; Error
 set b, 2, (iy+127)             ; Error
 set b, 2, (iy-128)             ; Error
 set b, 3, (ix)                 ; Error
 set b, 3, (ix+127)             ; Error
 set b, 3, (ix-128)             ; Error
 set b, 3, (iy)                 ; Error
 set b, 3, (iy+127)             ; Error
 set b, 3, (iy-128)             ; Error
 set b, 4, (ix)                 ; Error
 set b, 4, (ix+127)             ; Error
 set b, 4, (ix-128)             ; Error
 set b, 4, (iy)                 ; Error
 set b, 4, (iy+127)             ; Error
 set b, 4, (iy-128)             ; Error
 set b, 5, (ix)                 ; Error
 set b, 5, (ix+127)             ; Error
 set b, 5, (ix-128)             ; Error
 set b, 5, (iy)                 ; Error
 set b, 5, (iy+127)             ; Error
 set b, 5, (iy-128)             ; Error
 set b, 6, (ix)                 ; Error
 set b, 6, (ix+127)             ; Error
 set b, 6, (ix-128)             ; Error
 set b, 6, (iy)                 ; Error
 set b, 6, (iy+127)             ; Error
 set b, 6, (iy-128)             ; Error
 set b, 7, (ix)                 ; Error
 set b, 7, (ix+127)             ; Error
 set b, 7, (ix-128)             ; Error
 set b, 7, (iy)                 ; Error
 set b, 7, (iy+127)             ; Error
 set b, 7, (iy-128)             ; Error
 set c, 0, (ix)                 ; Error
 set c, 0, (ix+127)             ; Error
 set c, 0, (ix-128)             ; Error
 set c, 0, (iy)                 ; Error
 set c, 0, (iy+127)             ; Error
 set c, 0, (iy-128)             ; Error
 set c, 1, (ix)                 ; Error
 set c, 1, (ix+127)             ; Error
 set c, 1, (ix-128)             ; Error
 set c, 1, (iy)                 ; Error
 set c, 1, (iy+127)             ; Error
 set c, 1, (iy-128)             ; Error
 set c, 2, (ix)                 ; Error
 set c, 2, (ix+127)             ; Error
 set c, 2, (ix-128)             ; Error
 set c, 2, (iy)                 ; Error
 set c, 2, (iy+127)             ; Error
 set c, 2, (iy-128)             ; Error
 set c, 3, (ix)                 ; Error
 set c, 3, (ix+127)             ; Error
 set c, 3, (ix-128)             ; Error
 set c, 3, (iy)                 ; Error
 set c, 3, (iy+127)             ; Error
 set c, 3, (iy-128)             ; Error
 set c, 4, (ix)                 ; Error
 set c, 4, (ix+127)             ; Error
 set c, 4, (ix-128)             ; Error
 set c, 4, (iy)                 ; Error
 set c, 4, (iy+127)             ; Error
 set c, 4, (iy-128)             ; Error
 set c, 5, (ix)                 ; Error
 set c, 5, (ix+127)             ; Error
 set c, 5, (ix-128)             ; Error
 set c, 5, (iy)                 ; Error
 set c, 5, (iy+127)             ; Error
 set c, 5, (iy-128)             ; Error
 set c, 6, (ix)                 ; Error
 set c, 6, (ix+127)             ; Error
 set c, 6, (ix-128)             ; Error
 set c, 6, (iy)                 ; Error
 set c, 6, (iy+127)             ; Error
 set c, 6, (iy-128)             ; Error
 set c, 7, (ix)                 ; Error
 set c, 7, (ix+127)             ; Error
 set c, 7, (ix-128)             ; Error
 set c, 7, (iy)                 ; Error
 set c, 7, (iy+127)             ; Error
 set c, 7, (iy-128)             ; Error
 set d, 0, (ix)                 ; Error
 set d, 0, (ix+127)             ; Error
 set d, 0, (ix-128)             ; Error
 set d, 0, (iy)                 ; Error
 set d, 0, (iy+127)             ; Error
 set d, 0, (iy-128)             ; Error
 set d, 1, (ix)                 ; Error
 set d, 1, (ix+127)             ; Error
 set d, 1, (ix-128)             ; Error
 set d, 1, (iy)                 ; Error
 set d, 1, (iy+127)             ; Error
 set d, 1, (iy-128)             ; Error
 set d, 2, (ix)                 ; Error
 set d, 2, (ix+127)             ; Error
 set d, 2, (ix-128)             ; Error
 set d, 2, (iy)                 ; Error
 set d, 2, (iy+127)             ; Error
 set d, 2, (iy-128)             ; Error
 set d, 3, (ix)                 ; Error
 set d, 3, (ix+127)             ; Error
 set d, 3, (ix-128)             ; Error
 set d, 3, (iy)                 ; Error
 set d, 3, (iy+127)             ; Error
 set d, 3, (iy-128)             ; Error
 set d, 4, (ix)                 ; Error
 set d, 4, (ix+127)             ; Error
 set d, 4, (ix-128)             ; Error
 set d, 4, (iy)                 ; Error
 set d, 4, (iy+127)             ; Error
 set d, 4, (iy-128)             ; Error
 set d, 5, (ix)                 ; Error
 set d, 5, (ix+127)             ; Error
 set d, 5, (ix-128)             ; Error
 set d, 5, (iy)                 ; Error
 set d, 5, (iy+127)             ; Error
 set d, 5, (iy-128)             ; Error
 set d, 6, (ix)                 ; Error
 set d, 6, (ix+127)             ; Error
 set d, 6, (ix-128)             ; Error
 set d, 6, (iy)                 ; Error
 set d, 6, (iy+127)             ; Error
 set d, 6, (iy-128)             ; Error
 set d, 7, (ix)                 ; Error
 set d, 7, (ix+127)             ; Error
 set d, 7, (ix-128)             ; Error
 set d, 7, (iy)                 ; Error
 set d, 7, (iy+127)             ; Error
 set d, 7, (iy-128)             ; Error
 set e, 0, (ix)                 ; Error
 set e, 0, (ix+127)             ; Error
 set e, 0, (ix-128)             ; Error
 set e, 0, (iy)                 ; Error
 set e, 0, (iy+127)             ; Error
 set e, 0, (iy-128)             ; Error
 set e, 1, (ix)                 ; Error
 set e, 1, (ix+127)             ; Error
 set e, 1, (ix-128)             ; Error
 set e, 1, (iy)                 ; Error
 set e, 1, (iy+127)             ; Error
 set e, 1, (iy-128)             ; Error
 set e, 2, (ix)                 ; Error
 set e, 2, (ix+127)             ; Error
 set e, 2, (ix-128)             ; Error
 set e, 2, (iy)                 ; Error
 set e, 2, (iy+127)             ; Error
 set e, 2, (iy-128)             ; Error
 set e, 3, (ix)                 ; Error
 set e, 3, (ix+127)             ; Error
 set e, 3, (ix-128)             ; Error
 set e, 3, (iy)                 ; Error
 set e, 3, (iy+127)             ; Error
 set e, 3, (iy-128)             ; Error
 set e, 4, (ix)                 ; Error
 set e, 4, (ix+127)             ; Error
 set e, 4, (ix-128)             ; Error
 set e, 4, (iy)                 ; Error
 set e, 4, (iy+127)             ; Error
 set e, 4, (iy-128)             ; Error
 set e, 5, (ix)                 ; Error
 set e, 5, (ix+127)             ; Error
 set e, 5, (ix-128)             ; Error
 set e, 5, (iy)                 ; Error
 set e, 5, (iy+127)             ; Error
 set e, 5, (iy-128)             ; Error
 set e, 6, (ix)                 ; Error
 set e, 6, (ix+127)             ; Error
 set e, 6, (ix-128)             ; Error
 set e, 6, (iy)                 ; Error
 set e, 6, (iy+127)             ; Error
 set e, 6, (iy-128)             ; Error
 set e, 7, (ix)                 ; Error
 set e, 7, (ix+127)             ; Error
 set e, 7, (ix-128)             ; Error
 set e, 7, (iy)                 ; Error
 set e, 7, (iy+127)             ; Error
 set e, 7, (iy-128)             ; Error
 set h, 0, (ix)                 ; Error
 set h, 0, (ix+127)             ; Error
 set h, 0, (ix-128)             ; Error
 set h, 0, (iy)                 ; Error
 set h, 0, (iy+127)             ; Error
 set h, 0, (iy-128)             ; Error
 set h, 1, (ix)                 ; Error
 set h, 1, (ix+127)             ; Error
 set h, 1, (ix-128)             ; Error
 set h, 1, (iy)                 ; Error
 set h, 1, (iy+127)             ; Error
 set h, 1, (iy-128)             ; Error
 set h, 2, (ix)                 ; Error
 set h, 2, (ix+127)             ; Error
 set h, 2, (ix-128)             ; Error
 set h, 2, (iy)                 ; Error
 set h, 2, (iy+127)             ; Error
 set h, 2, (iy-128)             ; Error
 set h, 3, (ix)                 ; Error
 set h, 3, (ix+127)             ; Error
 set h, 3, (ix-128)             ; Error
 set h, 3, (iy)                 ; Error
 set h, 3, (iy+127)             ; Error
 set h, 3, (iy-128)             ; Error
 set h, 4, (ix)                 ; Error
 set h, 4, (ix+127)             ; Error
 set h, 4, (ix-128)             ; Error
 set h, 4, (iy)                 ; Error
 set h, 4, (iy+127)             ; Error
 set h, 4, (iy-128)             ; Error
 set h, 5, (ix)                 ; Error
 set h, 5, (ix+127)             ; Error
 set h, 5, (ix-128)             ; Error
 set h, 5, (iy)                 ; Error
 set h, 5, (iy+127)             ; Error
 set h, 5, (iy-128)             ; Error
 set h, 6, (ix)                 ; Error
 set h, 6, (ix+127)             ; Error
 set h, 6, (ix-128)             ; Error
 set h, 6, (iy)                 ; Error
 set h, 6, (iy+127)             ; Error
 set h, 6, (iy-128)             ; Error
 set h, 7, (ix)                 ; Error
 set h, 7, (ix+127)             ; Error
 set h, 7, (ix-128)             ; Error
 set h, 7, (iy)                 ; Error
 set h, 7, (iy+127)             ; Error
 set h, 7, (iy-128)             ; Error
 set l, 0, (ix)                 ; Error
 set l, 0, (ix+127)             ; Error
 set l, 0, (ix-128)             ; Error
 set l, 0, (iy)                 ; Error
 set l, 0, (iy+127)             ; Error
 set l, 0, (iy-128)             ; Error
 set l, 1, (ix)                 ; Error
 set l, 1, (ix+127)             ; Error
 set l, 1, (ix-128)             ; Error
 set l, 1, (iy)                 ; Error
 set l, 1, (iy+127)             ; Error
 set l, 1, (iy-128)             ; Error
 set l, 2, (ix)                 ; Error
 set l, 2, (ix+127)             ; Error
 set l, 2, (ix-128)             ; Error
 set l, 2, (iy)                 ; Error
 set l, 2, (iy+127)             ; Error
 set l, 2, (iy-128)             ; Error
 set l, 3, (ix)                 ; Error
 set l, 3, (ix+127)             ; Error
 set l, 3, (ix-128)             ; Error
 set l, 3, (iy)                 ; Error
 set l, 3, (iy+127)             ; Error
 set l, 3, (iy-128)             ; Error
 set l, 4, (ix)                 ; Error
 set l, 4, (ix+127)             ; Error
 set l, 4, (ix-128)             ; Error
 set l, 4, (iy)                 ; Error
 set l, 4, (iy+127)             ; Error
 set l, 4, (iy-128)             ; Error
 set l, 5, (ix)                 ; Error
 set l, 5, (ix+127)             ; Error
 set l, 5, (ix-128)             ; Error
 set l, 5, (iy)                 ; Error
 set l, 5, (iy+127)             ; Error
 set l, 5, (iy-128)             ; Error
 set l, 6, (ix)                 ; Error
 set l, 6, (ix+127)             ; Error
 set l, 6, (ix-128)             ; Error
 set l, 6, (iy)                 ; Error
 set l, 6, (iy+127)             ; Error
 set l, 6, (iy-128)             ; Error
 set l, 7, (ix)                 ; Error
 set l, 7, (ix+127)             ; Error
 set l, 7, (ix-128)             ; Error
 set l, 7, (iy)                 ; Error
 set l, 7, (iy+127)             ; Error
 set l, 7, (iy-128)             ; Error
 setae                          ; Error
 shld -32768                    ; Error
 shld 32767                     ; Error
 shld 65535                     ; Error
 shlde                          ; Error
 shlx                           ; Error
 sim                            ; Error
 sl1 (hl)                       ; Error
 sl1 (ix)                       ; Error
 sl1 (ix), a                    ; Error
 sl1 (ix), b                    ; Error
 sl1 (ix), c                    ; Error
 sl1 (ix), d                    ; Error
 sl1 (ix), e                    ; Error
 sl1 (ix), h                    ; Error
 sl1 (ix), l                    ; Error
 sl1 (ix+127)                   ; Error
 sl1 (ix+127), a                ; Error
 sl1 (ix+127), b                ; Error
 sl1 (ix+127), c                ; Error
 sl1 (ix+127), d                ; Error
 sl1 (ix+127), e                ; Error
 sl1 (ix+127), h                ; Error
 sl1 (ix+127), l                ; Error
 sl1 (ix-128)                   ; Error
 sl1 (ix-128), a                ; Error
 sl1 (ix-128), b                ; Error
 sl1 (ix-128), c                ; Error
 sl1 (ix-128), d                ; Error
 sl1 (ix-128), e                ; Error
 sl1 (ix-128), h                ; Error
 sl1 (ix-128), l                ; Error
 sl1 (iy)                       ; Error
 sl1 (iy), a                    ; Error
 sl1 (iy), b                    ; Error
 sl1 (iy), c                    ; Error
 sl1 (iy), d                    ; Error
 sl1 (iy), e                    ; Error
 sl1 (iy), h                    ; Error
 sl1 (iy), l                    ; Error
 sl1 (iy+127)                   ; Error
 sl1 (iy+127), a                ; Error
 sl1 (iy+127), b                ; Error
 sl1 (iy+127), c                ; Error
 sl1 (iy+127), d                ; Error
 sl1 (iy+127), e                ; Error
 sl1 (iy+127), h                ; Error
 sl1 (iy+127), l                ; Error
 sl1 (iy-128)                   ; Error
 sl1 (iy-128), a                ; Error
 sl1 (iy-128), b                ; Error
 sl1 (iy-128), c                ; Error
 sl1 (iy-128), d                ; Error
 sl1 (iy-128), e                ; Error
 sl1 (iy-128), h                ; Error
 sl1 (iy-128), l                ; Error
 sl1 a                          ; Error
 sl1 a, (ix)                    ; Error
 sl1 a, (ix+127)                ; Error
 sl1 a, (ix-128)                ; Error
 sl1 a, (iy)                    ; Error
 sl1 a, (iy+127)                ; Error
 sl1 a, (iy-128)                ; Error
 sl1 b                          ; Error
 sl1 b, (ix)                    ; Error
 sl1 b, (ix+127)                ; Error
 sl1 b, (ix-128)                ; Error
 sl1 b, (iy)                    ; Error
 sl1 b, (iy+127)                ; Error
 sl1 b, (iy-128)                ; Error
 sl1 c                          ; Error
 sl1 c, (ix)                    ; Error
 sl1 c, (ix+127)                ; Error
 sl1 c, (ix-128)                ; Error
 sl1 c, (iy)                    ; Error
 sl1 c, (iy+127)                ; Error
 sl1 c, (iy-128)                ; Error
 sl1 d                          ; Error
 sl1 d, (ix)                    ; Error
 sl1 d, (ix+127)                ; Error
 sl1 d, (ix-128)                ; Error
 sl1 d, (iy)                    ; Error
 sl1 d, (iy+127)                ; Error
 sl1 d, (iy-128)                ; Error
 sl1 e                          ; Error
 sl1 e, (ix)                    ; Error
 sl1 e, (ix+127)                ; Error
 sl1 e, (ix-128)                ; Error
 sl1 e, (iy)                    ; Error
 sl1 e, (iy+127)                ; Error
 sl1 e, (iy-128)                ; Error
 sl1 h                          ; Error
 sl1 h, (ix)                    ; Error
 sl1 h, (ix+127)                ; Error
 sl1 h, (ix-128)                ; Error
 sl1 h, (iy)                    ; Error
 sl1 h, (iy+127)                ; Error
 sl1 h, (iy-128)                ; Error
 sl1 l                          ; Error
 sl1 l, (ix)                    ; Error
 sl1 l, (ix+127)                ; Error
 sl1 l, (ix-128)                ; Error
 sl1 l, (iy)                    ; Error
 sl1 l, (iy+127)                ; Error
 sl1 l, (iy-128)                ; Error
 sla (ix)                       ; Error
 sla (ix), a                    ; Error
 sla (ix), b                    ; Error
 sla (ix), c                    ; Error
 sla (ix), d                    ; Error
 sla (ix), e                    ; Error
 sla (ix), h                    ; Error
 sla (ix), l                    ; Error
 sla (ix+127)                   ; Error
 sla (ix+127), a                ; Error
 sla (ix+127), b                ; Error
 sla (ix+127), c                ; Error
 sla (ix+127), d                ; Error
 sla (ix+127), e                ; Error
 sla (ix+127), h                ; Error
 sla (ix+127), l                ; Error
 sla (ix-128)                   ; Error
 sla (ix-128), a                ; Error
 sla (ix-128), b                ; Error
 sla (ix-128), c                ; Error
 sla (ix-128), d                ; Error
 sla (ix-128), e                ; Error
 sla (ix-128), h                ; Error
 sla (ix-128), l                ; Error
 sla (iy)                       ; Error
 sla (iy), a                    ; Error
 sla (iy), b                    ; Error
 sla (iy), c                    ; Error
 sla (iy), d                    ; Error
 sla (iy), e                    ; Error
 sla (iy), h                    ; Error
 sla (iy), l                    ; Error
 sla (iy+127)                   ; Error
 sla (iy+127), a                ; Error
 sla (iy+127), b                ; Error
 sla (iy+127), c                ; Error
 sla (iy+127), d                ; Error
 sla (iy+127), e                ; Error
 sla (iy+127), h                ; Error
 sla (iy+127), l                ; Error
 sla (iy-128)                   ; Error
 sla (iy-128), a                ; Error
 sla (iy-128), b                ; Error
 sla (iy-128), c                ; Error
 sla (iy-128), d                ; Error
 sla (iy-128), e                ; Error
 sla (iy-128), h                ; Error
 sla (iy-128), l                ; Error
 sla a, (ix)                    ; Error
 sla a, (ix+127)                ; Error
 sla a, (ix-128)                ; Error
 sla a, (iy)                    ; Error
 sla a, (iy+127)                ; Error
 sla a, (iy-128)                ; Error
 sla b, (ix)                    ; Error
 sla b, (ix+127)                ; Error
 sla b, (ix-128)                ; Error
 sla b, (iy)                    ; Error
 sla b, (iy+127)                ; Error
 sla b, (iy-128)                ; Error
 sla c, (ix)                    ; Error
 sla c, (ix+127)                ; Error
 sla c, (ix-128)                ; Error
 sla c, (iy)                    ; Error
 sla c, (iy+127)                ; Error
 sla c, (iy-128)                ; Error
 sla d, (ix)                    ; Error
 sla d, (ix+127)                ; Error
 sla d, (ix-128)                ; Error
 sla d, (iy)                    ; Error
 sla d, (iy+127)                ; Error
 sla d, (iy-128)                ; Error
 sla e, (ix)                    ; Error
 sla e, (ix+127)                ; Error
 sla e, (ix-128)                ; Error
 sla e, (iy)                    ; Error
 sla e, (iy+127)                ; Error
 sla e, (iy-128)                ; Error
 sla h, (ix)                    ; Error
 sla h, (ix+127)                ; Error
 sla h, (ix-128)                ; Error
 sla h, (iy)                    ; Error
 sla h, (iy+127)                ; Error
 sla h, (iy-128)                ; Error
 sla l, (ix)                    ; Error
 sla l, (ix+127)                ; Error
 sla l, (ix-128)                ; Error
 sla l, (iy)                    ; Error
 sla l, (iy+127)                ; Error
 sla l, (iy-128)                ; Error
 sli (hl)                       ; Error
 sli (ix)                       ; Error
 sli (ix), a                    ; Error
 sli (ix), b                    ; Error
 sli (ix), c                    ; Error
 sli (ix), d                    ; Error
 sli (ix), e                    ; Error
 sli (ix), h                    ; Error
 sli (ix), l                    ; Error
 sli (ix+127)                   ; Error
 sli (ix+127), a                ; Error
 sli (ix+127), b                ; Error
 sli (ix+127), c                ; Error
 sli (ix+127), d                ; Error
 sli (ix+127), e                ; Error
 sli (ix+127), h                ; Error
 sli (ix+127), l                ; Error
 sli (ix-128)                   ; Error
 sli (ix-128), a                ; Error
 sli (ix-128), b                ; Error
 sli (ix-128), c                ; Error
 sli (ix-128), d                ; Error
 sli (ix-128), e                ; Error
 sli (ix-128), h                ; Error
 sli (ix-128), l                ; Error
 sli (iy)                       ; Error
 sli (iy), a                    ; Error
 sli (iy), b                    ; Error
 sli (iy), c                    ; Error
 sli (iy), d                    ; Error
 sli (iy), e                    ; Error
 sli (iy), h                    ; Error
 sli (iy), l                    ; Error
 sli (iy+127)                   ; Error
 sli (iy+127), a                ; Error
 sli (iy+127), b                ; Error
 sli (iy+127), c                ; Error
 sli (iy+127), d                ; Error
 sli (iy+127), e                ; Error
 sli (iy+127), h                ; Error
 sli (iy+127), l                ; Error
 sli (iy-128)                   ; Error
 sli (iy-128), a                ; Error
 sli (iy-128), b                ; Error
 sli (iy-128), c                ; Error
 sli (iy-128), d                ; Error
 sli (iy-128), e                ; Error
 sli (iy-128), h                ; Error
 sli (iy-128), l                ; Error
 sli a                          ; Error
 sli a, (ix)                    ; Error
 sli a, (ix+127)                ; Error
 sli a, (ix-128)                ; Error
 sli a, (iy)                    ; Error
 sli a, (iy+127)                ; Error
 sli a, (iy-128)                ; Error
 sli b                          ; Error
 sli b, (ix)                    ; Error
 sli b, (ix+127)                ; Error
 sli b, (ix-128)                ; Error
 sli b, (iy)                    ; Error
 sli b, (iy+127)                ; Error
 sli b, (iy-128)                ; Error
 sli c                          ; Error
 sli c, (ix)                    ; Error
 sli c, (ix+127)                ; Error
 sli c, (ix-128)                ; Error
 sli c, (iy)                    ; Error
 sli c, (iy+127)                ; Error
 sli c, (iy-128)                ; Error
 sli d                          ; Error
 sli d, (ix)                    ; Error
 sli d, (ix+127)                ; Error
 sli d, (ix-128)                ; Error
 sli d, (iy)                    ; Error
 sli d, (iy+127)                ; Error
 sli d, (iy-128)                ; Error
 sli e                          ; Error
 sli e, (ix)                    ; Error
 sli e, (ix+127)                ; Error
 sli e, (ix-128)                ; Error
 sli e, (iy)                    ; Error
 sli e, (iy+127)                ; Error
 sli e, (iy-128)                ; Error
 sli h                          ; Error
 sli h, (ix)                    ; Error
 sli h, (ix+127)                ; Error
 sli h, (ix-128)                ; Error
 sli h, (iy)                    ; Error
 sli h, (iy+127)                ; Error
 sli h, (iy-128)                ; Error
 sli l                          ; Error
 sli l, (ix)                    ; Error
 sli l, (ix+127)                ; Error
 sli l, (ix-128)                ; Error
 sli l, (iy)                    ; Error
 sli l, (iy+127)                ; Error
 sli l, (iy-128)                ; Error
 sll (hl)                       ; Error
 sll (ix)                       ; Error
 sll (ix), a                    ; Error
 sll (ix), b                    ; Error
 sll (ix), c                    ; Error
 sll (ix), d                    ; Error
 sll (ix), e                    ; Error
 sll (ix), h                    ; Error
 sll (ix), l                    ; Error
 sll (ix+127)                   ; Error
 sll (ix+127), a                ; Error
 sll (ix+127), b                ; Error
 sll (ix+127), c                ; Error
 sll (ix+127), d                ; Error
 sll (ix+127), e                ; Error
 sll (ix+127), h                ; Error
 sll (ix+127), l                ; Error
 sll (ix-128)                   ; Error
 sll (ix-128), a                ; Error
 sll (ix-128), b                ; Error
 sll (ix-128), c                ; Error
 sll (ix-128), d                ; Error
 sll (ix-128), e                ; Error
 sll (ix-128), h                ; Error
 sll (ix-128), l                ; Error
 sll (iy)                       ; Error
 sll (iy), a                    ; Error
 sll (iy), b                    ; Error
 sll (iy), c                    ; Error
 sll (iy), d                    ; Error
 sll (iy), e                    ; Error
 sll (iy), h                    ; Error
 sll (iy), l                    ; Error
 sll (iy+127)                   ; Error
 sll (iy+127), a                ; Error
 sll (iy+127), b                ; Error
 sll (iy+127), c                ; Error
 sll (iy+127), d                ; Error
 sll (iy+127), e                ; Error
 sll (iy+127), h                ; Error
 sll (iy+127), l                ; Error
 sll (iy-128)                   ; Error
 sll (iy-128), a                ; Error
 sll (iy-128), b                ; Error
 sll (iy-128), c                ; Error
 sll (iy-128), d                ; Error
 sll (iy-128), e                ; Error
 sll (iy-128), h                ; Error
 sll (iy-128), l                ; Error
 sll a                          ; Error
 sll a, (ix)                    ; Error
 sll a, (ix+127)                ; Error
 sll a, (ix-128)                ; Error
 sll a, (iy)                    ; Error
 sll a, (iy+127)                ; Error
 sll a, (iy-128)                ; Error
 sll b                          ; Error
 sll b, (ix)                    ; Error
 sll b, (ix+127)                ; Error
 sll b, (ix-128)                ; Error
 sll b, (iy)                    ; Error
 sll b, (iy+127)                ; Error
 sll b, (iy-128)                ; Error
 sll c                          ; Error
 sll c, (ix)                    ; Error
 sll c, (ix+127)                ; Error
 sll c, (ix-128)                ; Error
 sll c, (iy)                    ; Error
 sll c, (iy+127)                ; Error
 sll c, (iy-128)                ; Error
 sll d                          ; Error
 sll d, (ix)                    ; Error
 sll d, (ix+127)                ; Error
 sll d, (ix-128)                ; Error
 sll d, (iy)                    ; Error
 sll d, (iy+127)                ; Error
 sll d, (iy-128)                ; Error
 sll e                          ; Error
 sll e, (ix)                    ; Error
 sll e, (ix+127)                ; Error
 sll e, (ix-128)                ; Error
 sll e, (iy)                    ; Error
 sll e, (iy+127)                ; Error
 sll e, (iy-128)                ; Error
 sll h                          ; Error
 sll h, (ix)                    ; Error
 sll h, (ix+127)                ; Error
 sll h, (ix-128)                ; Error
 sll h, (iy)                    ; Error
 sll h, (iy+127)                ; Error
 sll h, (iy-128)                ; Error
 sll l                          ; Error
 sll l, (ix)                    ; Error
 sll l, (ix+127)                ; Error
 sll l, (ix-128)                ; Error
 sll l, (iy)                    ; Error
 sll l, (iy+127)                ; Error
 sll l, (iy-128)                ; Error
 slp                            ; Error
 sra (ix)                       ; Error
 sra (ix), a                    ; Error
 sra (ix), b                    ; Error
 sra (ix), c                    ; Error
 sra (ix), d                    ; Error
 sra (ix), e                    ; Error
 sra (ix), h                    ; Error
 sra (ix), l                    ; Error
 sra (ix+127)                   ; Error
 sra (ix+127), a                ; Error
 sra (ix+127), b                ; Error
 sra (ix+127), c                ; Error
 sra (ix+127), d                ; Error
 sra (ix+127), e                ; Error
 sra (ix+127), h                ; Error
 sra (ix+127), l                ; Error
 sra (ix-128)                   ; Error
 sra (ix-128), a                ; Error
 sra (ix-128), b                ; Error
 sra (ix-128), c                ; Error
 sra (ix-128), d                ; Error
 sra (ix-128), e                ; Error
 sra (ix-128), h                ; Error
 sra (ix-128), l                ; Error
 sra (iy)                       ; Error
 sra (iy), a                    ; Error
 sra (iy), b                    ; Error
 sra (iy), c                    ; Error
 sra (iy), d                    ; Error
 sra (iy), e                    ; Error
 sra (iy), h                    ; Error
 sra (iy), l                    ; Error
 sra (iy+127)                   ; Error
 sra (iy+127), a                ; Error
 sra (iy+127), b                ; Error
 sra (iy+127), c                ; Error
 sra (iy+127), d                ; Error
 sra (iy+127), e                ; Error
 sra (iy+127), h                ; Error
 sra (iy+127), l                ; Error
 sra (iy-128)                   ; Error
 sra (iy-128), a                ; Error
 sra (iy-128), b                ; Error
 sra (iy-128), c                ; Error
 sra (iy-128), d                ; Error
 sra (iy-128), e                ; Error
 sra (iy-128), h                ; Error
 sra (iy-128), l                ; Error
 sra a, (ix)                    ; Error
 sra a, (ix+127)                ; Error
 sra a, (ix-128)                ; Error
 sra a, (iy)                    ; Error
 sra a, (iy+127)                ; Error
 sra a, (iy-128)                ; Error
 sra b, (ix)                    ; Error
 sra b, (ix+127)                ; Error
 sra b, (ix-128)                ; Error
 sra b, (iy)                    ; Error
 sra b, (iy+127)                ; Error
 sra b, (iy-128)                ; Error
 sra c, (ix)                    ; Error
 sra c, (ix+127)                ; Error
 sra c, (ix-128)                ; Error
 sra c, (iy)                    ; Error
 sra c, (iy+127)                ; Error
 sra c, (iy-128)                ; Error
 sra d, (ix)                    ; Error
 sra d, (ix+127)                ; Error
 sra d, (ix-128)                ; Error
 sra d, (iy)                    ; Error
 sra d, (iy+127)                ; Error
 sra d, (iy-128)                ; Error
 sra e, (ix)                    ; Error
 sra e, (ix+127)                ; Error
 sra e, (ix-128)                ; Error
 sra e, (iy)                    ; Error
 sra e, (iy+127)                ; Error
 sra e, (iy-128)                ; Error
 sra h, (ix)                    ; Error
 sra h, (ix+127)                ; Error
 sra h, (ix-128)                ; Error
 sra h, (iy)                    ; Error
 sra h, (iy+127)                ; Error
 sra h, (iy-128)                ; Error
 sra l, (ix)                    ; Error
 sra l, (ix+127)                ; Error
 sra l, (ix-128)                ; Error
 sra l, (iy)                    ; Error
 sra l, (iy+127)                ; Error
 sra l, (iy-128)                ; Error
 srl (ix)                       ; Error
 srl (ix), a                    ; Error
 srl (ix), b                    ; Error
 srl (ix), c                    ; Error
 srl (ix), d                    ; Error
 srl (ix), e                    ; Error
 srl (ix), h                    ; Error
 srl (ix), l                    ; Error
 srl (ix+127)                   ; Error
 srl (ix+127), a                ; Error
 srl (ix+127), b                ; Error
 srl (ix+127), c                ; Error
 srl (ix+127), d                ; Error
 srl (ix+127), e                ; Error
 srl (ix+127), h                ; Error
 srl (ix+127), l                ; Error
 srl (ix-128)                   ; Error
 srl (ix-128), a                ; Error
 srl (ix-128), b                ; Error
 srl (ix-128), c                ; Error
 srl (ix-128), d                ; Error
 srl (ix-128), e                ; Error
 srl (ix-128), h                ; Error
 srl (ix-128), l                ; Error
 srl (iy)                       ; Error
 srl (iy), a                    ; Error
 srl (iy), b                    ; Error
 srl (iy), c                    ; Error
 srl (iy), d                    ; Error
 srl (iy), e                    ; Error
 srl (iy), h                    ; Error
 srl (iy), l                    ; Error
 srl (iy+127)                   ; Error
 srl (iy+127), a                ; Error
 srl (iy+127), b                ; Error
 srl (iy+127), c                ; Error
 srl (iy+127), d                ; Error
 srl (iy+127), e                ; Error
 srl (iy+127), h                ; Error
 srl (iy+127), l                ; Error
 srl (iy-128)                   ; Error
 srl (iy-128), a                ; Error
 srl (iy-128), b                ; Error
 srl (iy-128), c                ; Error
 srl (iy-128), d                ; Error
 srl (iy-128), e                ; Error
 srl (iy-128), h                ; Error
 srl (iy-128), l                ; Error
 srl a, (ix)                    ; Error
 srl a, (ix+127)                ; Error
 srl a, (ix-128)                ; Error
 srl a, (iy)                    ; Error
 srl a, (iy+127)                ; Error
 srl a, (iy-128)                ; Error
 srl b, (ix)                    ; Error
 srl b, (ix+127)                ; Error
 srl b, (ix-128)                ; Error
 srl b, (iy)                    ; Error
 srl b, (iy+127)                ; Error
 srl b, (iy-128)                ; Error
 srl c, (ix)                    ; Error
 srl c, (ix+127)                ; Error
 srl c, (ix-128)                ; Error
 srl c, (iy)                    ; Error
 srl c, (iy+127)                ; Error
 srl c, (iy-128)                ; Error
 srl d, (ix)                    ; Error
 srl d, (ix+127)                ; Error
 srl d, (ix-128)                ; Error
 srl d, (iy)                    ; Error
 srl d, (iy+127)                ; Error
 srl d, (iy-128)                ; Error
 srl e, (ix)                    ; Error
 srl e, (ix+127)                ; Error
 srl e, (ix-128)                ; Error
 srl e, (iy)                    ; Error
 srl e, (iy+127)                ; Error
 srl e, (iy-128)                ; Error
 srl h, (ix)                    ; Error
 srl h, (ix+127)                ; Error
 srl h, (ix-128)                ; Error
 srl h, (iy)                    ; Error
 srl h, (iy+127)                ; Error
 srl h, (iy-128)                ; Error
 srl l, (ix)                    ; Error
 srl l, (ix+127)                ; Error
 srl l, (ix-128)                ; Error
 srl l, (iy)                    ; Error
 srl l, (iy+127)                ; Error
 srl l, (iy-128)                ; Error
 sub (ix)                       ; Error
 sub (ix+127)                   ; Error
 sub (ix-128)                   ; Error
 sub (iy)                       ; Error
 sub (iy+127)                   ; Error
 sub (iy-128)                   ; Error
 sub a, (ix)                    ; Error
 sub a, (ix+127)                ; Error
 sub a, (ix-128)                ; Error
 sub a, (iy)                    ; Error
 sub a, (iy+127)                ; Error
 sub a, (iy-128)                ; Error
 swapnib                        ; Error
 test (hl)                      ; Error
 test -128                      ; Error
 test 127                       ; Error
 test 255                       ; Error
 test a                         ; Error
 test a, (hl)                   ; Error
 test a, -128                   ; Error
 test a, 127                    ; Error
 test a, 255                    ; Error
 test a, a                      ; Error
 test a, b                      ; Error
 test a, c                      ; Error
 test a, d                      ; Error
 test a, e                      ; Error
 test a, h                      ; Error
 test a, l                      ; Error
 test b                         ; Error
 test c                         ; Error
 test d                         ; Error
 test e                         ; Error
 test h                         ; Error
 test l                         ; Error
 tst (hl)                       ; Error
 tst -128                       ; Error
 tst 127                        ; Error
 tst 255                        ; Error
 tst a                          ; Error
 tst a, (hl)                    ; Error
 tst a, -128                    ; Error
 tst a, 127                     ; Error
 tst a, 255                     ; Error
 tst a, a                       ; Error
 tst a, b                       ; Error
 tst a, c                       ; Error
 tst a, d                       ; Error
 tst a, e                       ; Error
 tst a, h                       ; Error
 tst a, l                       ; Error
 tst b                          ; Error
 tst c                          ; Error
 tst d                          ; Error
 tst e                          ; Error
 tst h                          ; Error
 tst l                          ; Error
 tstio -128                     ; Error
 tstio 127                      ; Error
 tstio 255                      ; Error
 xor (ix)                       ; Error
 xor (ix+127)                   ; Error
 xor (ix-128)                   ; Error
 xor (iy)                       ; Error
 xor (iy+127)                   ; Error
 xor (iy-128)                   ; Error
 xor a, (ix)                    ; Error
 xor a, (ix+127)                ; Error
 xor a, (ix-128)                ; Error
 xor a, (iy)                    ; Error
 xor a, (iy+127)                ; Error
 xor a, (iy-128)                ; Error
 xthl                           ; Error
