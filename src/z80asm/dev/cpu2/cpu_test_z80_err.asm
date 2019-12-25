 add sp, -128                   ; Error
 add sp, 127                    ; Error
 adi hl, -128                   ; Error
 adi hl, 127                    ; Error
 adi hl, 255                    ; Error
 adi sp, -128                   ; Error
 adi sp, 127                    ; Error
 adi sp, 255                    ; Error
 djnz -32768                    ; Error
 djnz 32767                     ; Error
 djnz 65535                     ; Error
 djnz b, -32768                 ; Error
 djnz b, 32767                  ; Error
 djnz b, 65535                  ; Error
 jk -32768                      ; Error
 jk 32767                       ; Error
 jk 65535                       ; Error
 jnk -32768                     ; Error
 jnk 32767                      ; Error
 jnk 65535                      ; Error
 jnx5 -32768                    ; Error
 jnx5 32767                     ; Error
 jnx5 65535                     ; Error
 jp (c)                         ; Error
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
 jx5 -32768                     ; Error
 jx5 32767                      ; Error
 jx5 65535                      ; Error
 ld (c), a                      ; Error
 ld (de), hl                    ; Error
 ld (hld), a                    ; Error
 ld (hli), a                    ; Error
 ld a, (c)                      ; Error
 ld a, (hld)                    ; Error
 ld a, (hli)                    ; Error
 ld de, hl+-128                 ; Error
 ld de, hl+127                  ; Error
 ld de, hl+255                  ; Error
 ld hl, (de)                    ; Error
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
 ldhi -128                      ; Error
 ldhi 127                       ; Error
 ldhi 255                       ; Error
 ldhl sp, -128                  ; Error
 ldhl sp, 127                   ; Error
 ldirx                          ; Error
 ldix                           ; Error
 ldpirx                         ; Error
 ldsi -128                      ; Error
 ldsi 127                       ; Error
 ldsi 255                       ; Error
 ldws                           ; Error
 lhlde                          ; Error
 lhlx                           ; Error
 mirror a                       ; Error
 mlt de                         ; Error
 mul de                         ; Error
 nextreg -128, %N               ; Error
 nextreg -128, a                ; Error
 nextreg 127, %N                ; Error
 nextreg 127, a                 ; Error
 nextreg 255, %N                ; Error
 nextreg 255, a                 ; Error
 outinb                         ; Error
 ovrst8                         ; Error
 pixelad                        ; Error
 pixeldn                        ; Error
 push %M                        ; Error
 rim                            ; Error
 rstv                           ; Error
 setae                          ; Error
 shlde                          ; Error
 shlx                           ; Error
 sim                            ; Error
 stop                           ; Error
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
