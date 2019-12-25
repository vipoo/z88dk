 adc a, ixh                     ; Error
 adc a, ixl                     ; Error
 adc a, iyh                     ; Error
 adc a, iyl                     ; Error
 adc ixh                        ; Error
 adc ixl                        ; Error
 adc iyh                        ; Error
 adc iyl                        ; Error
 add a, ixh                     ; Error
 add a, ixl                     ; Error
 add a, iyh                     ; Error
 add a, iyl                     ; Error
 add ixh                        ; Error
 add ixl                        ; Error
 add iyh                        ; Error
 add iyl                        ; Error
 adi hl, -128                   ; Error
 adi hl, 127                    ; Error
 adi hl, 255                    ; Error
 adi sp, -128                   ; Error
 adi sp, 127                    ; Error
 adi sp, 255                    ; Error
 altd bit -1, (hl)              ; Error
 altd bit -1, (hl)              ; Error
 altd bit -1, (ix)              ; Error
 altd bit -1, (ix)              ; Error
 altd bit -1, (ix+127)          ; Error
 altd bit -1, (ix+127)          ; Error
 altd bit -1, (ix-128)          ; Error
 altd bit -1, (ix-128)          ; Error
 altd bit -1, (iy)              ; Error
 altd bit -1, (iy)              ; Error
 altd bit -1, (iy+127)          ; Error
 altd bit -1, (iy+127)          ; Error
 altd bit -1, (iy-128)          ; Error
 altd bit -1, (iy-128)          ; Error
 altd bit -1, a                 ; Error
 altd bit -1, a                 ; Error
 altd bit -1, b                 ; Error
 altd bit -1, b                 ; Error
 altd bit -1, c                 ; Error
 altd bit -1, c                 ; Error
 altd bit -1, d                 ; Error
 altd bit -1, d                 ; Error
 altd bit -1, e                 ; Error
 altd bit -1, e                 ; Error
 altd bit -1, h                 ; Error
 altd bit -1, h                 ; Error
 altd bit -1, l                 ; Error
 altd bit -1, l                 ; Error
 altd bit 8, (hl)               ; Error
 altd bit 8, (hl)               ; Error
 altd bit 8, (ix)               ; Error
 altd bit 8, (ix)               ; Error
 altd bit 8, (ix+127)           ; Error
 altd bit 8, (ix+127)           ; Error
 altd bit 8, (ix-128)           ; Error
 altd bit 8, (ix-128)           ; Error
 altd bit 8, (iy)               ; Error
 altd bit 8, (iy)               ; Error
 altd bit 8, (iy+127)           ; Error
 altd bit 8, (iy+127)           ; Error
 altd bit 8, (iy-128)           ; Error
 altd bit 8, (iy-128)           ; Error
 altd bit 8, a                  ; Error
 altd bit 8, a                  ; Error
 altd bit 8, b                  ; Error
 altd bit 8, b                  ; Error
 altd bit 8, c                  ; Error
 altd bit 8, c                  ; Error
 altd bit 8, d                  ; Error
 altd bit 8, d                  ; Error
 altd bit 8, e                  ; Error
 altd bit 8, e                  ; Error
 altd bit 8, h                  ; Error
 altd bit 8, h                  ; Error
 altd bit 8, l                  ; Error
 altd bit 8, l                  ; Error
 altd ioe bit -1, (hl)          ; Error
 altd ioe bit -1, (hl)          ; Error
 altd ioe bit -1, (ix)          ; Error
 altd ioe bit -1, (ix)          ; Error
 altd ioe bit -1, (ix+127)      ; Error
 altd ioe bit -1, (ix+127)      ; Error
 altd ioe bit -1, (ix-128)      ; Error
 altd ioe bit -1, (ix-128)      ; Error
 altd ioe bit -1, (iy)          ; Error
 altd ioe bit -1, (iy)          ; Error
 altd ioe bit -1, (iy+127)      ; Error
 altd ioe bit -1, (iy+127)      ; Error
 altd ioe bit -1, (iy-128)      ; Error
 altd ioe bit -1, (iy-128)      ; Error
 altd ioe bit 8, (hl)           ; Error
 altd ioe bit 8, (hl)           ; Error
 altd ioe bit 8, (ix)           ; Error
 altd ioe bit 8, (ix)           ; Error
 altd ioe bit 8, (ix+127)       ; Error
 altd ioe bit 8, (ix+127)       ; Error
 altd ioe bit 8, (ix-128)       ; Error
 altd ioe bit 8, (ix-128)       ; Error
 altd ioe bit 8, (iy)           ; Error
 altd ioe bit 8, (iy)           ; Error
 altd ioe bit 8, (iy+127)       ; Error
 altd ioe bit 8, (iy+127)       ; Error
 altd ioe bit 8, (iy-128)       ; Error
 altd ioe bit 8, (iy-128)       ; Error
 altd ioi bit -1, (hl)          ; Error
 altd ioi bit -1, (hl)          ; Error
 altd ioi bit -1, (ix)          ; Error
 altd ioi bit -1, (ix)          ; Error
 altd ioi bit -1, (ix+127)      ; Error
 altd ioi bit -1, (ix+127)      ; Error
 altd ioi bit -1, (ix-128)      ; Error
 altd ioi bit -1, (ix-128)      ; Error
 altd ioi bit -1, (iy)          ; Error
 altd ioi bit -1, (iy)          ; Error
 altd ioi bit -1, (iy+127)      ; Error
 altd ioi bit -1, (iy+127)      ; Error
 altd ioi bit -1, (iy-128)      ; Error
 altd ioi bit -1, (iy-128)      ; Error
 altd ioi bit 8, (hl)           ; Error
 altd ioi bit 8, (hl)           ; Error
 altd ioi bit 8, (ix)           ; Error
 altd ioi bit 8, (ix)           ; Error
 altd ioi bit 8, (ix+127)       ; Error
 altd ioi bit 8, (ix+127)       ; Error
 altd ioi bit 8, (ix-128)       ; Error
 altd ioi bit 8, (ix-128)       ; Error
 altd ioi bit 8, (iy)           ; Error
 altd ioi bit 8, (iy)           ; Error
 altd ioi bit 8, (iy+127)       ; Error
 altd ioi bit 8, (iy+127)       ; Error
 altd ioi bit 8, (iy-128)       ; Error
 altd ioi bit 8, (iy-128)       ; Error
 altd res -1, a                 ; Error
 altd res -1, a                 ; Error
 altd res -1, b                 ; Error
 altd res -1, b                 ; Error
 altd res -1, c                 ; Error
 altd res -1, c                 ; Error
 altd res -1, d                 ; Error
 altd res -1, d                 ; Error
 altd res -1, e                 ; Error
 altd res -1, e                 ; Error
 altd res -1, h                 ; Error
 altd res -1, h                 ; Error
 altd res -1, l                 ; Error
 altd res -1, l                 ; Error
 altd res 8, a                  ; Error
 altd res 8, a                  ; Error
 altd res 8, b                  ; Error
 altd res 8, b                  ; Error
 altd res 8, c                  ; Error
 altd res 8, c                  ; Error
 altd res 8, d                  ; Error
 altd res 8, d                  ; Error
 altd res 8, e                  ; Error
 altd res 8, e                  ; Error
 altd res 8, h                  ; Error
 altd res 8, h                  ; Error
 altd res 8, l                  ; Error
 altd res 8, l                  ; Error
 altd set -1, a                 ; Error
 altd set -1, a                 ; Error
 altd set -1, b                 ; Error
 altd set -1, b                 ; Error
 altd set -1, c                 ; Error
 altd set -1, c                 ; Error
 altd set -1, d                 ; Error
 altd set -1, d                 ; Error
 altd set -1, e                 ; Error
 altd set -1, e                 ; Error
 altd set -1, h                 ; Error
 altd set -1, h                 ; Error
 altd set -1, l                 ; Error
 altd set -1, l                 ; Error
 altd set 8, a                  ; Error
 altd set 8, a                  ; Error
 altd set 8, b                  ; Error
 altd set 8, b                  ; Error
 altd set 8, c                  ; Error
 altd set 8, c                  ; Error
 altd set 8, d                  ; Error
 altd set 8, d                  ; Error
 altd set 8, e                  ; Error
 altd set 8, e                  ; Error
 altd set 8, h                  ; Error
 altd set 8, h                  ; Error
 altd set 8, l                  ; Error
 altd set 8, l                  ; Error
 and a, ixh                     ; Error
 and a, ixl                     ; Error
 and a, iyh                     ; Error
 and a, iyl                     ; Error
 and ixh                        ; Error
 and ixl                        ; Error
 and iyh                        ; Error
 and iyl                        ; Error
 bit -1, (hl)                   ; Error
 bit -1, (hl)                   ; Error
 bit -1, (ix)                   ; Error
 bit -1, (ix)                   ; Error
 bit -1, (ix+127)               ; Error
 bit -1, (ix+127)               ; Error
 bit -1, (ix-128)               ; Error
 bit -1, (ix-128)               ; Error
 bit -1, (iy)                   ; Error
 bit -1, (iy)                   ; Error
 bit -1, (iy+127)               ; Error
 bit -1, (iy+127)               ; Error
 bit -1, (iy-128)               ; Error
 bit -1, (iy-128)               ; Error
 bit -1, a                      ; Error
 bit -1, a                      ; Error
 bit -1, b                      ; Error
 bit -1, b                      ; Error
 bit -1, c                      ; Error
 bit -1, c                      ; Error
 bit -1, d                      ; Error
 bit -1, d                      ; Error
 bit -1, e                      ; Error
 bit -1, e                      ; Error
 bit -1, h                      ; Error
 bit -1, h                      ; Error
 bit -1, l                      ; Error
 bit -1, l                      ; Error
 bit 8, (hl)                    ; Error
 bit 8, (hl)                    ; Error
 bit 8, (ix)                    ; Error
 bit 8, (ix)                    ; Error
 bit 8, (ix+127)                ; Error
 bit 8, (ix+127)                ; Error
 bit 8, (ix-128)                ; Error
 bit 8, (ix-128)                ; Error
 bit 8, (iy)                    ; Error
 bit 8, (iy)                    ; Error
 bit 8, (iy+127)                ; Error
 bit 8, (iy+127)                ; Error
 bit 8, (iy-128)                ; Error
 bit 8, (iy-128)                ; Error
 bit 8, a                       ; Error
 bit 8, a                       ; Error
 bit 8, b                       ; Error
 bit 8, b                       ; Error
 bit 8, c                       ; Error
 bit 8, c                       ; Error
 bit 8, d                       ; Error
 bit 8, d                       ; Error
 bit 8, e                       ; Error
 bit 8, e                       ; Error
 bit 8, h                       ; Error
 bit 8, h                       ; Error
 bit 8, l                       ; Error
 bit 8, l                       ; Error
 bit.a -1, (hl)                 ; Error
 bit.a -1, (hl)                 ; Error
 bit.a -1, (ix)                 ; Error
 bit.a -1, (ix)                 ; Error
 bit.a -1, (ix+127)             ; Error
 bit.a -1, (ix+127)             ; Error
 bit.a -1, (ix-128)             ; Error
 bit.a -1, (ix-128)             ; Error
 bit.a -1, (iy)                 ; Error
 bit.a -1, (iy)                 ; Error
 bit.a -1, (iy+127)             ; Error
 bit.a -1, (iy+127)             ; Error
 bit.a -1, (iy-128)             ; Error
 bit.a -1, (iy-128)             ; Error
 bit.a -1, a                    ; Error
 bit.a -1, a                    ; Error
 bit.a -1, b                    ; Error
 bit.a -1, b                    ; Error
 bit.a -1, c                    ; Error
 bit.a -1, c                    ; Error
 bit.a -1, d                    ; Error
 bit.a -1, d                    ; Error
 bit.a -1, e                    ; Error
 bit.a -1, e                    ; Error
 bit.a -1, h                    ; Error
 bit.a -1, h                    ; Error
 bit.a -1, l                    ; Error
 bit.a -1, l                    ; Error
 bit.a 8, (hl)                  ; Error
 bit.a 8, (hl)                  ; Error
 bit.a 8, (ix)                  ; Error
 bit.a 8, (ix)                  ; Error
 bit.a 8, (ix+127)              ; Error
 bit.a 8, (ix+127)              ; Error
 bit.a 8, (ix-128)              ; Error
 bit.a 8, (ix-128)              ; Error
 bit.a 8, (iy)                  ; Error
 bit.a 8, (iy)                  ; Error
 bit.a 8, (iy+127)              ; Error
 bit.a 8, (iy+127)              ; Error
 bit.a 8, (iy-128)              ; Error
 bit.a 8, (iy-128)              ; Error
 bit.a 8, a                     ; Error
 bit.a 8, a                     ; Error
 bit.a 8, b                     ; Error
 bit.a 8, b                     ; Error
 bit.a 8, c                     ; Error
 bit.a 8, c                     ; Error
 bit.a 8, d                     ; Error
 bit.a 8, d                     ; Error
 bit.a 8, e                     ; Error
 bit.a 8, e                     ; Error
 bit.a 8, h                     ; Error
 bit.a 8, h                     ; Error
 bit.a 8, l                     ; Error
 bit.a 8, l                     ; Error
 cmp a, ixh                     ; Error
 cmp a, ixl                     ; Error
 cmp a, iyh                     ; Error
 cmp a, iyl                     ; Error
 cmp ixh                        ; Error
 cmp ixl                        ; Error
 cmp iyh                        ; Error
 cmp iyl                        ; Error
 cp a, ixh                      ; Error
 cp a, ixl                      ; Error
 cp a, iyh                      ; Error
 cp a, iyl                      ; Error
 cp ixh                         ; Error
 cp ixl                         ; Error
 cp iyh                         ; Error
 cp iyl                         ; Error
 dec ixh                        ; Error
 dec ixl                        ; Error
 dec iyh                        ; Error
 dec iyl                        ; Error
 di                             ; Error
 ei                             ; Error
 halt                           ; Error
 hlt                            ; Error
 im -1                          ; Error
 im -1                          ; Error
 im 0                           ; Error
 im 1                           ; Error
 im 2                           ; Error
 im 3                           ; Error
 im 3                           ; Error
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
 inc ixh                        ; Error
 inc ixl                        ; Error
 inc iyh                        ; Error
 inc iyl                        ; Error
 ind                            ; Error
 indr                           ; Error
 ini                            ; Error
 inir                           ; Error
 ioe altd bit -1, (hl)          ; Error
 ioe altd bit -1, (hl)          ; Error
 ioe altd bit -1, (ix)          ; Error
 ioe altd bit -1, (ix)          ; Error
 ioe altd bit -1, (ix+127)      ; Error
 ioe altd bit -1, (ix+127)      ; Error
 ioe altd bit -1, (ix-128)      ; Error
 ioe altd bit -1, (ix-128)      ; Error
 ioe altd bit -1, (iy)          ; Error
 ioe altd bit -1, (iy)          ; Error
 ioe altd bit -1, (iy+127)      ; Error
 ioe altd bit -1, (iy+127)      ; Error
 ioe altd bit -1, (iy-128)      ; Error
 ioe altd bit -1, (iy-128)      ; Error
 ioe altd bit 8, (hl)           ; Error
 ioe altd bit 8, (hl)           ; Error
 ioe altd bit 8, (ix)           ; Error
 ioe altd bit 8, (ix)           ; Error
 ioe altd bit 8, (ix+127)       ; Error
 ioe altd bit 8, (ix+127)       ; Error
 ioe altd bit 8, (ix-128)       ; Error
 ioe altd bit 8, (ix-128)       ; Error
 ioe altd bit 8, (iy)           ; Error
 ioe altd bit 8, (iy)           ; Error
 ioe altd bit 8, (iy+127)       ; Error
 ioe altd bit 8, (iy+127)       ; Error
 ioe altd bit 8, (iy-128)       ; Error
 ioe altd bit 8, (iy-128)       ; Error
 ioe bit -1, (hl)               ; Error
 ioe bit -1, (hl)               ; Error
 ioe bit -1, (ix)               ; Error
 ioe bit -1, (ix)               ; Error
 ioe bit -1, (ix+127)           ; Error
 ioe bit -1, (ix+127)           ; Error
 ioe bit -1, (ix-128)           ; Error
 ioe bit -1, (ix-128)           ; Error
 ioe bit -1, (iy)               ; Error
 ioe bit -1, (iy)               ; Error
 ioe bit -1, (iy+127)           ; Error
 ioe bit -1, (iy+127)           ; Error
 ioe bit -1, (iy-128)           ; Error
 ioe bit -1, (iy-128)           ; Error
 ioe bit 8, (hl)                ; Error
 ioe bit 8, (hl)                ; Error
 ioe bit 8, (ix)                ; Error
 ioe bit 8, (ix)                ; Error
 ioe bit 8, (ix+127)            ; Error
 ioe bit 8, (ix+127)            ; Error
 ioe bit 8, (ix-128)            ; Error
 ioe bit 8, (ix-128)            ; Error
 ioe bit 8, (iy)                ; Error
 ioe bit 8, (iy)                ; Error
 ioe bit 8, (iy+127)            ; Error
 ioe bit 8, (iy+127)            ; Error
 ioe bit 8, (iy-128)            ; Error
 ioe bit 8, (iy-128)            ; Error
 ioe bit.a -1, (hl)             ; Error
 ioe bit.a -1, (hl)             ; Error
 ioe bit.a -1, (ix)             ; Error
 ioe bit.a -1, (ix)             ; Error
 ioe bit.a -1, (ix+127)         ; Error
 ioe bit.a -1, (ix+127)         ; Error
 ioe bit.a -1, (ix-128)         ; Error
 ioe bit.a -1, (ix-128)         ; Error
 ioe bit.a -1, (iy)             ; Error
 ioe bit.a -1, (iy)             ; Error
 ioe bit.a -1, (iy+127)         ; Error
 ioe bit.a -1, (iy+127)         ; Error
 ioe bit.a -1, (iy-128)         ; Error
 ioe bit.a -1, (iy-128)         ; Error
 ioe bit.a 8, (hl)              ; Error
 ioe bit.a 8, (hl)              ; Error
 ioe bit.a 8, (ix)              ; Error
 ioe bit.a 8, (ix)              ; Error
 ioe bit.a 8, (ix+127)          ; Error
 ioe bit.a 8, (ix+127)          ; Error
 ioe bit.a 8, (ix-128)          ; Error
 ioe bit.a 8, (ix-128)          ; Error
 ioe bit.a 8, (iy)              ; Error
 ioe bit.a 8, (iy)              ; Error
 ioe bit.a 8, (iy+127)          ; Error
 ioe bit.a 8, (iy+127)          ; Error
 ioe bit.a 8, (iy-128)          ; Error
 ioe bit.a 8, (iy-128)          ; Error
 ioe res -1, (hl)               ; Error
 ioe res -1, (hl)               ; Error
 ioe res -1, (ix)               ; Error
 ioe res -1, (ix)               ; Error
 ioe res -1, (ix+127)           ; Error
 ioe res -1, (ix+127)           ; Error
 ioe res -1, (ix-128)           ; Error
 ioe res -1, (ix-128)           ; Error
 ioe res -1, (iy)               ; Error
 ioe res -1, (iy)               ; Error
 ioe res -1, (iy+127)           ; Error
 ioe res -1, (iy+127)           ; Error
 ioe res -1, (iy-128)           ; Error
 ioe res -1, (iy-128)           ; Error
 ioe res 8, (hl)                ; Error
 ioe res 8, (hl)                ; Error
 ioe res 8, (ix)                ; Error
 ioe res 8, (ix)                ; Error
 ioe res 8, (ix+127)            ; Error
 ioe res 8, (ix+127)            ; Error
 ioe res 8, (ix-128)            ; Error
 ioe res 8, (ix-128)            ; Error
 ioe res 8, (iy)                ; Error
 ioe res 8, (iy)                ; Error
 ioe res 8, (iy+127)            ; Error
 ioe res 8, (iy+127)            ; Error
 ioe res 8, (iy-128)            ; Error
 ioe res 8, (iy-128)            ; Error
 ioe res.a -1, (hl)             ; Error
 ioe res.a -1, (hl)             ; Error
 ioe res.a -1, (ix)             ; Error
 ioe res.a -1, (ix)             ; Error
 ioe res.a -1, (ix+127)         ; Error
 ioe res.a -1, (ix+127)         ; Error
 ioe res.a -1, (ix-128)         ; Error
 ioe res.a -1, (ix-128)         ; Error
 ioe res.a -1, (iy)             ; Error
 ioe res.a -1, (iy)             ; Error
 ioe res.a -1, (iy+127)         ; Error
 ioe res.a -1, (iy+127)         ; Error
 ioe res.a -1, (iy-128)         ; Error
 ioe res.a -1, (iy-128)         ; Error
 ioe res.a 8, (hl)              ; Error
 ioe res.a 8, (hl)              ; Error
 ioe res.a 8, (ix)              ; Error
 ioe res.a 8, (ix)              ; Error
 ioe res.a 8, (ix+127)          ; Error
 ioe res.a 8, (ix+127)          ; Error
 ioe res.a 8, (ix-128)          ; Error
 ioe res.a 8, (ix-128)          ; Error
 ioe res.a 8, (iy)              ; Error
 ioe res.a 8, (iy)              ; Error
 ioe res.a 8, (iy+127)          ; Error
 ioe res.a 8, (iy+127)          ; Error
 ioe res.a 8, (iy-128)          ; Error
 ioe res.a 8, (iy-128)          ; Error
 ioe set -1, (hl)               ; Error
 ioe set -1, (hl)               ; Error
 ioe set -1, (ix)               ; Error
 ioe set -1, (ix)               ; Error
 ioe set -1, (ix+127)           ; Error
 ioe set -1, (ix+127)           ; Error
 ioe set -1, (ix-128)           ; Error
 ioe set -1, (ix-128)           ; Error
 ioe set -1, (iy)               ; Error
 ioe set -1, (iy)               ; Error
 ioe set -1, (iy+127)           ; Error
 ioe set -1, (iy+127)           ; Error
 ioe set -1, (iy-128)           ; Error
 ioe set -1, (iy-128)           ; Error
 ioe set 8, (hl)                ; Error
 ioe set 8, (hl)                ; Error
 ioe set 8, (ix)                ; Error
 ioe set 8, (ix)                ; Error
 ioe set 8, (ix+127)            ; Error
 ioe set 8, (ix+127)            ; Error
 ioe set 8, (ix-128)            ; Error
 ioe set 8, (ix-128)            ; Error
 ioe set 8, (iy)                ; Error
 ioe set 8, (iy)                ; Error
 ioe set 8, (iy+127)            ; Error
 ioe set 8, (iy+127)            ; Error
 ioe set 8, (iy-128)            ; Error
 ioe set 8, (iy-128)            ; Error
 ioe set.a -1, (hl)             ; Error
 ioe set.a -1, (hl)             ; Error
 ioe set.a -1, (ix)             ; Error
 ioe set.a -1, (ix)             ; Error
 ioe set.a -1, (ix+127)         ; Error
 ioe set.a -1, (ix+127)         ; Error
 ioe set.a -1, (ix-128)         ; Error
 ioe set.a -1, (ix-128)         ; Error
 ioe set.a -1, (iy)             ; Error
 ioe set.a -1, (iy)             ; Error
 ioe set.a -1, (iy+127)         ; Error
 ioe set.a -1, (iy+127)         ; Error
 ioe set.a -1, (iy-128)         ; Error
 ioe set.a -1, (iy-128)         ; Error
 ioe set.a 8, (hl)              ; Error
 ioe set.a 8, (hl)              ; Error
 ioe set.a 8, (ix)              ; Error
 ioe set.a 8, (ix)              ; Error
 ioe set.a 8, (ix+127)          ; Error
 ioe set.a 8, (ix+127)          ; Error
 ioe set.a 8, (ix-128)          ; Error
 ioe set.a 8, (ix-128)          ; Error
 ioe set.a 8, (iy)              ; Error
 ioe set.a 8, (iy)              ; Error
 ioe set.a 8, (iy+127)          ; Error
 ioe set.a 8, (iy+127)          ; Error
 ioe set.a 8, (iy-128)          ; Error
 ioe set.a 8, (iy-128)          ; Error
 ioi altd bit -1, (hl)          ; Error
 ioi altd bit -1, (hl)          ; Error
 ioi altd bit -1, (ix)          ; Error
 ioi altd bit -1, (ix)          ; Error
 ioi altd bit -1, (ix+127)      ; Error
 ioi altd bit -1, (ix+127)      ; Error
 ioi altd bit -1, (ix-128)      ; Error
 ioi altd bit -1, (ix-128)      ; Error
 ioi altd bit -1, (iy)          ; Error
 ioi altd bit -1, (iy)          ; Error
 ioi altd bit -1, (iy+127)      ; Error
 ioi altd bit -1, (iy+127)      ; Error
 ioi altd bit -1, (iy-128)      ; Error
 ioi altd bit -1, (iy-128)      ; Error
 ioi altd bit 8, (hl)           ; Error
 ioi altd bit 8, (hl)           ; Error
 ioi altd bit 8, (ix)           ; Error
 ioi altd bit 8, (ix)           ; Error
 ioi altd bit 8, (ix+127)       ; Error
 ioi altd bit 8, (ix+127)       ; Error
 ioi altd bit 8, (ix-128)       ; Error
 ioi altd bit 8, (ix-128)       ; Error
 ioi altd bit 8, (iy)           ; Error
 ioi altd bit 8, (iy)           ; Error
 ioi altd bit 8, (iy+127)       ; Error
 ioi altd bit 8, (iy+127)       ; Error
 ioi altd bit 8, (iy-128)       ; Error
 ioi altd bit 8, (iy-128)       ; Error
 ioi bit -1, (hl)               ; Error
 ioi bit -1, (hl)               ; Error
 ioi bit -1, (ix)               ; Error
 ioi bit -1, (ix)               ; Error
 ioi bit -1, (ix+127)           ; Error
 ioi bit -1, (ix+127)           ; Error
 ioi bit -1, (ix-128)           ; Error
 ioi bit -1, (ix-128)           ; Error
 ioi bit -1, (iy)               ; Error
 ioi bit -1, (iy)               ; Error
 ioi bit -1, (iy+127)           ; Error
 ioi bit -1, (iy+127)           ; Error
 ioi bit -1, (iy-128)           ; Error
 ioi bit -1, (iy-128)           ; Error
 ioi bit 8, (hl)                ; Error
 ioi bit 8, (hl)                ; Error
 ioi bit 8, (ix)                ; Error
 ioi bit 8, (ix)                ; Error
 ioi bit 8, (ix+127)            ; Error
 ioi bit 8, (ix+127)            ; Error
 ioi bit 8, (ix-128)            ; Error
 ioi bit 8, (ix-128)            ; Error
 ioi bit 8, (iy)                ; Error
 ioi bit 8, (iy)                ; Error
 ioi bit 8, (iy+127)            ; Error
 ioi bit 8, (iy+127)            ; Error
 ioi bit 8, (iy-128)            ; Error
 ioi bit 8, (iy-128)            ; Error
 ioi bit.a -1, (hl)             ; Error
 ioi bit.a -1, (hl)             ; Error
 ioi bit.a -1, (ix)             ; Error
 ioi bit.a -1, (ix)             ; Error
 ioi bit.a -1, (ix+127)         ; Error
 ioi bit.a -1, (ix+127)         ; Error
 ioi bit.a -1, (ix-128)         ; Error
 ioi bit.a -1, (ix-128)         ; Error
 ioi bit.a -1, (iy)             ; Error
 ioi bit.a -1, (iy)             ; Error
 ioi bit.a -1, (iy+127)         ; Error
 ioi bit.a -1, (iy+127)         ; Error
 ioi bit.a -1, (iy-128)         ; Error
 ioi bit.a -1, (iy-128)         ; Error
 ioi bit.a 8, (hl)              ; Error
 ioi bit.a 8, (hl)              ; Error
 ioi bit.a 8, (ix)              ; Error
 ioi bit.a 8, (ix)              ; Error
 ioi bit.a 8, (ix+127)          ; Error
 ioi bit.a 8, (ix+127)          ; Error
 ioi bit.a 8, (ix-128)          ; Error
 ioi bit.a 8, (ix-128)          ; Error
 ioi bit.a 8, (iy)              ; Error
 ioi bit.a 8, (iy)              ; Error
 ioi bit.a 8, (iy+127)          ; Error
 ioi bit.a 8, (iy+127)          ; Error
 ioi bit.a 8, (iy-128)          ; Error
 ioi bit.a 8, (iy-128)          ; Error
 ioi res -1, (hl)               ; Error
 ioi res -1, (hl)               ; Error
 ioi res -1, (ix)               ; Error
 ioi res -1, (ix)               ; Error
 ioi res -1, (ix+127)           ; Error
 ioi res -1, (ix+127)           ; Error
 ioi res -1, (ix-128)           ; Error
 ioi res -1, (ix-128)           ; Error
 ioi res -1, (iy)               ; Error
 ioi res -1, (iy)               ; Error
 ioi res -1, (iy+127)           ; Error
 ioi res -1, (iy+127)           ; Error
 ioi res -1, (iy-128)           ; Error
 ioi res -1, (iy-128)           ; Error
 ioi res 8, (hl)                ; Error
 ioi res 8, (hl)                ; Error
 ioi res 8, (ix)                ; Error
 ioi res 8, (ix)                ; Error
 ioi res 8, (ix+127)            ; Error
 ioi res 8, (ix+127)            ; Error
 ioi res 8, (ix-128)            ; Error
 ioi res 8, (ix-128)            ; Error
 ioi res 8, (iy)                ; Error
 ioi res 8, (iy)                ; Error
 ioi res 8, (iy+127)            ; Error
 ioi res 8, (iy+127)            ; Error
 ioi res 8, (iy-128)            ; Error
 ioi res 8, (iy-128)            ; Error
 ioi res.a -1, (hl)             ; Error
 ioi res.a -1, (hl)             ; Error
 ioi res.a -1, (ix)             ; Error
 ioi res.a -1, (ix)             ; Error
 ioi res.a -1, (ix+127)         ; Error
 ioi res.a -1, (ix+127)         ; Error
 ioi res.a -1, (ix-128)         ; Error
 ioi res.a -1, (ix-128)         ; Error
 ioi res.a -1, (iy)             ; Error
 ioi res.a -1, (iy)             ; Error
 ioi res.a -1, (iy+127)         ; Error
 ioi res.a -1, (iy+127)         ; Error
 ioi res.a -1, (iy-128)         ; Error
 ioi res.a -1, (iy-128)         ; Error
 ioi res.a 8, (hl)              ; Error
 ioi res.a 8, (hl)              ; Error
 ioi res.a 8, (ix)              ; Error
 ioi res.a 8, (ix)              ; Error
 ioi res.a 8, (ix+127)          ; Error
 ioi res.a 8, (ix+127)          ; Error
 ioi res.a 8, (ix-128)          ; Error
 ioi res.a 8, (ix-128)          ; Error
 ioi res.a 8, (iy)              ; Error
 ioi res.a 8, (iy)              ; Error
 ioi res.a 8, (iy+127)          ; Error
 ioi res.a 8, (iy+127)          ; Error
 ioi res.a 8, (iy-128)          ; Error
 ioi res.a 8, (iy-128)          ; Error
 ioi set -1, (hl)               ; Error
 ioi set -1, (hl)               ; Error
 ioi set -1, (ix)               ; Error
 ioi set -1, (ix)               ; Error
 ioi set -1, (ix+127)           ; Error
 ioi set -1, (ix+127)           ; Error
 ioi set -1, (ix-128)           ; Error
 ioi set -1, (ix-128)           ; Error
 ioi set -1, (iy)               ; Error
 ioi set -1, (iy)               ; Error
 ioi set -1, (iy+127)           ; Error
 ioi set -1, (iy+127)           ; Error
 ioi set -1, (iy-128)           ; Error
 ioi set -1, (iy-128)           ; Error
 ioi set 8, (hl)                ; Error
 ioi set 8, (hl)                ; Error
 ioi set 8, (ix)                ; Error
 ioi set 8, (ix)                ; Error
 ioi set 8, (ix+127)            ; Error
 ioi set 8, (ix+127)            ; Error
 ioi set 8, (ix-128)            ; Error
 ioi set 8, (ix-128)            ; Error
 ioi set 8, (iy)                ; Error
 ioi set 8, (iy)                ; Error
 ioi set 8, (iy+127)            ; Error
 ioi set 8, (iy+127)            ; Error
 ioi set 8, (iy-128)            ; Error
 ioi set 8, (iy-128)            ; Error
 ioi set.a -1, (hl)             ; Error
 ioi set.a -1, (hl)             ; Error
 ioi set.a -1, (ix)             ; Error
 ioi set.a -1, (ix)             ; Error
 ioi set.a -1, (ix+127)         ; Error
 ioi set.a -1, (ix+127)         ; Error
 ioi set.a -1, (ix-128)         ; Error
 ioi set.a -1, (ix-128)         ; Error
 ioi set.a -1, (iy)             ; Error
 ioi set.a -1, (iy)             ; Error
 ioi set.a -1, (iy+127)         ; Error
 ioi set.a -1, (iy+127)         ; Error
 ioi set.a -1, (iy-128)         ; Error
 ioi set.a -1, (iy-128)         ; Error
 ioi set.a 8, (hl)              ; Error
 ioi set.a 8, (hl)              ; Error
 ioi set.a 8, (ix)              ; Error
 ioi set.a 8, (ix)              ; Error
 ioi set.a 8, (ix+127)          ; Error
 ioi set.a 8, (ix+127)          ; Error
 ioi set.a 8, (ix-128)          ; Error
 ioi set.a 8, (ix-128)          ; Error
 ioi set.a 8, (iy)              ; Error
 ioi set.a 8, (iy)              ; Error
 ioi set.a 8, (iy+127)          ; Error
 ioi set.a 8, (iy+127)          ; Error
 ioi set.a 8, (iy-128)          ; Error
 ioi set.a 8, (iy-128)          ; Error
 ipset -1                       ; Error
 ipset -1                       ; Error
 ipset 4                        ; Error
 ipset 4                        ; Error
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
 jx5 -32768                     ; Error
 jx5 32767                      ; Error
 jx5 65535                      ; Error
 ld (c), a                      ; Error
 ld (de), hl                    ; Error
 ld a, (c)                      ; Error
 ld a, i                        ; Error
 ld a, ixh                      ; Error
 ld a, ixl                      ; Error
 ld a, iyh                      ; Error
 ld a, iyl                      ; Error
 ld a, r                        ; Error
 ld b, ixh                      ; Error
 ld b, ixl                      ; Error
 ld b, iyh                      ; Error
 ld b, iyl                      ; Error
 ld bc, ix                      ; Error
 ld bc, iy                      ; Error
 ld c, ixh                      ; Error
 ld c, ixl                      ; Error
 ld c, iyh                      ; Error
 ld c, iyl                      ; Error
 ld d, ixh                      ; Error
 ld d, ixl                      ; Error
 ld d, iyh                      ; Error
 ld d, iyl                      ; Error
 ld de, hl+0                    ; Error
 ld de, hl+255                  ; Error
 ld de, ix                      ; Error
 ld de, iy                      ; Error
 ld e, ixh                      ; Error
 ld e, ixl                      ; Error
 ld e, iyh                      ; Error
 ld e, iyl                      ; Error
 ld hl, (de)                    ; Error
 ld i, a                        ; Error
 ld ix, bc                      ; Error
 ld ix, de                      ; Error
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
 ld iy, bc                      ; Error
 ld iy, de                      ; Error
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
 ld r, a                        ; Error
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
 mlt bc                         ; Error
 mlt de                         ; Error
 mlt hl                         ; Error
 mlt sp                         ; Error
 mmu -1, -128                   ; Error
 mmu -1, -128                   ; Error
 mmu -1, 127                    ; Error
 mmu -1, 127                    ; Error
 mmu -1, 255                    ; Error
 mmu -1, 255                    ; Error
 mmu -1, a                      ; Error
 mmu -1, a                      ; Error
 mmu 0, -128                    ; Error
 mmu 0, 127                     ; Error
 mmu 0, 255                     ; Error
 mmu 0, a                       ; Error
 mmu 1, -128                    ; Error
 mmu 1, 127                     ; Error
 mmu 1, 255                     ; Error
 mmu 1, a                       ; Error
 mmu 2, -128                    ; Error
 mmu 2, 127                     ; Error
 mmu 2, 255                     ; Error
 mmu 2, a                       ; Error
 mmu 3, -128                    ; Error
 mmu 3, 127                     ; Error
 mmu 3, 255                     ; Error
 mmu 3, a                       ; Error
 mmu 4, -128                    ; Error
 mmu 4, 127                     ; Error
 mmu 4, 255                     ; Error
 mmu 4, a                       ; Error
 mmu 5, -128                    ; Error
 mmu 5, 127                     ; Error
 mmu 5, 255                     ; Error
 mmu 5, a                       ; Error
 mmu 6, -128                    ; Error
 mmu 6, 127                     ; Error
 mmu 6, 255                     ; Error
 mmu 6, a                       ; Error
 mmu 7, -128                    ; Error
 mmu 7, 127                     ; Error
 mmu 7, 255                     ; Error
 mmu 7, a                       ; Error
 mmu 8, -128                    ; Error
 mmu 8, -128                    ; Error
 mmu 8, 127                     ; Error
 mmu 8, 127                     ; Error
 mmu 8, 255                     ; Error
 mmu 8, 255                     ; Error
 mmu 8, a                       ; Error
 mmu 8, a                       ; Error
 mmu0 -128                      ; Error
 mmu0 127                       ; Error
 mmu0 255                       ; Error
 mmu0 a                         ; Error
 mmu1 -128                      ; Error
 mmu1 127                       ; Error
 mmu1 255                       ; Error
 mmu1 a                         ; Error
 mmu2 -128                      ; Error
 mmu2 127                       ; Error
 mmu2 255                       ; Error
 mmu2 a                         ; Error
 mmu3 -128                      ; Error
 mmu3 127                       ; Error
 mmu3 255                       ; Error
 mmu3 a                         ; Error
 mmu4 -128                      ; Error
 mmu4 127                       ; Error
 mmu4 255                       ; Error
 mmu4 a                         ; Error
 mmu5 -128                      ; Error
 mmu5 127                       ; Error
 mmu5 255                       ; Error
 mmu5 a                         ; Error
 mmu6 -128                      ; Error
 mmu6 127                       ; Error
 mmu6 255                       ; Error
 mmu6 a                         ; Error
 mmu7 -128                      ; Error
 mmu7 127                       ; Error
 mmu7 255                       ; Error
 mmu7 a                         ; Error
 mul bc                         ; Error
 mul de                         ; Error
 mul hl                         ; Error
 mul sp                         ; Error
 nextreg -128, -128             ; Error
 nextreg -128, a                ; Error
 nextreg 127, 127               ; Error
 nextreg 127, a                 ; Error
 nextreg 255, 255               ; Error
 nextreg 255, a                 ; Error
 or a, ixh                      ; Error
 or a, ixl                      ; Error
 or a, iyh                      ; Error
 or a, iyl                      ; Error
 or ixh                         ; Error
 or ixl                         ; Error
 or iyh                         ; Error
 or iyl                         ; Error
 otdm                           ; Error
 otdmr                          ; Error
 otdr                           ; Error
 otim                           ; Error
 otimr                          ; Error
 otir                           ; Error
 out (-128), a                  ; Error
 out (127), a                   ; Error
 out (255), a                   ; Error
 out (c), -1                    ; Error
 out (c), -1                    ; Error
 out (c), 0                     ; Error
 out (c), 1                     ; Error
 out (c), 1                     ; Error
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
 push -32768                    ; Error
 push 32767                     ; Error
 push 65535                     ; Error
 res -1, (hl)                   ; Error
 res -1, (hl)                   ; Error
 res -1, (ix)                   ; Error
 res -1, (ix)                   ; Error
 res -1, (ix), a                ; Error
 res -1, (ix), a                ; Error
 res -1, (ix), b                ; Error
 res -1, (ix), b                ; Error
 res -1, (ix), c                ; Error
 res -1, (ix), c                ; Error
 res -1, (ix), d                ; Error
 res -1, (ix), d                ; Error
 res -1, (ix), e                ; Error
 res -1, (ix), e                ; Error
 res -1, (ix), h                ; Error
 res -1, (ix), h                ; Error
 res -1, (ix), l                ; Error
 res -1, (ix), l                ; Error
 res -1, (ix+127)               ; Error
 res -1, (ix+127)               ; Error
 res -1, (ix+127), a            ; Error
 res -1, (ix+127), a            ; Error
 res -1, (ix+127), b            ; Error
 res -1, (ix+127), b            ; Error
 res -1, (ix+127), c            ; Error
 res -1, (ix+127), c            ; Error
 res -1, (ix+127), d            ; Error
 res -1, (ix+127), d            ; Error
 res -1, (ix+127), e            ; Error
 res -1, (ix+127), e            ; Error
 res -1, (ix+127), h            ; Error
 res -1, (ix+127), h            ; Error
 res -1, (ix+127), l            ; Error
 res -1, (ix+127), l            ; Error
 res -1, (ix-128)               ; Error
 res -1, (ix-128)               ; Error
 res -1, (ix-128), a            ; Error
 res -1, (ix-128), a            ; Error
 res -1, (ix-128), b            ; Error
 res -1, (ix-128), b            ; Error
 res -1, (ix-128), c            ; Error
 res -1, (ix-128), c            ; Error
 res -1, (ix-128), d            ; Error
 res -1, (ix-128), d            ; Error
 res -1, (ix-128), e            ; Error
 res -1, (ix-128), e            ; Error
 res -1, (ix-128), h            ; Error
 res -1, (ix-128), h            ; Error
 res -1, (ix-128), l            ; Error
 res -1, (ix-128), l            ; Error
 res -1, (iy)                   ; Error
 res -1, (iy)                   ; Error
 res -1, (iy), a                ; Error
 res -1, (iy), a                ; Error
 res -1, (iy), b                ; Error
 res -1, (iy), b                ; Error
 res -1, (iy), c                ; Error
 res -1, (iy), c                ; Error
 res -1, (iy), d                ; Error
 res -1, (iy), d                ; Error
 res -1, (iy), e                ; Error
 res -1, (iy), e                ; Error
 res -1, (iy), h                ; Error
 res -1, (iy), h                ; Error
 res -1, (iy), l                ; Error
 res -1, (iy), l                ; Error
 res -1, (iy+127)               ; Error
 res -1, (iy+127)               ; Error
 res -1, (iy+127), a            ; Error
 res -1, (iy+127), a            ; Error
 res -1, (iy+127), b            ; Error
 res -1, (iy+127), b            ; Error
 res -1, (iy+127), c            ; Error
 res -1, (iy+127), c            ; Error
 res -1, (iy+127), d            ; Error
 res -1, (iy+127), d            ; Error
 res -1, (iy+127), e            ; Error
 res -1, (iy+127), e            ; Error
 res -1, (iy+127), h            ; Error
 res -1, (iy+127), h            ; Error
 res -1, (iy+127), l            ; Error
 res -1, (iy+127), l            ; Error
 res -1, (iy-128)               ; Error
 res -1, (iy-128)               ; Error
 res -1, (iy-128), a            ; Error
 res -1, (iy-128), a            ; Error
 res -1, (iy-128), b            ; Error
 res -1, (iy-128), b            ; Error
 res -1, (iy-128), c            ; Error
 res -1, (iy-128), c            ; Error
 res -1, (iy-128), d            ; Error
 res -1, (iy-128), d            ; Error
 res -1, (iy-128), e            ; Error
 res -1, (iy-128), e            ; Error
 res -1, (iy-128), h            ; Error
 res -1, (iy-128), h            ; Error
 res -1, (iy-128), l            ; Error
 res -1, (iy-128), l            ; Error
 res -1, a                      ; Error
 res -1, a                      ; Error
 res -1, a'                     ; Error
 res -1, a'                     ; Error
 res -1, b                      ; Error
 res -1, b                      ; Error
 res -1, b'                     ; Error
 res -1, b'                     ; Error
 res -1, c                      ; Error
 res -1, c                      ; Error
 res -1, c'                     ; Error
 res -1, c'                     ; Error
 res -1, d                      ; Error
 res -1, d                      ; Error
 res -1, d'                     ; Error
 res -1, d'                     ; Error
 res -1, e                      ; Error
 res -1, e                      ; Error
 res -1, e'                     ; Error
 res -1, e'                     ; Error
 res -1, h                      ; Error
 res -1, h                      ; Error
 res -1, h'                     ; Error
 res -1, h'                     ; Error
 res -1, l                      ; Error
 res -1, l                      ; Error
 res -1, l'                     ; Error
 res -1, l'                     ; Error
 res 0, (ix), a                 ; Error
 res 0, (ix), b                 ; Error
 res 0, (ix), c                 ; Error
 res 0, (ix), d                 ; Error
 res 0, (ix), e                 ; Error
 res 0, (ix), h                 ; Error
 res 0, (ix), l                 ; Error
 res 0, (ix+127), a             ; Error
 res 0, (ix+127), b             ; Error
 res 0, (ix+127), c             ; Error
 res 0, (ix+127), d             ; Error
 res 0, (ix+127), e             ; Error
 res 0, (ix+127), h             ; Error
 res 0, (ix+127), l             ; Error
 res 0, (ix-128), a             ; Error
 res 0, (ix-128), b             ; Error
 res 0, (ix-128), c             ; Error
 res 0, (ix-128), d             ; Error
 res 0, (ix-128), e             ; Error
 res 0, (ix-128), h             ; Error
 res 0, (ix-128), l             ; Error
 res 0, (iy), a                 ; Error
 res 0, (iy), b                 ; Error
 res 0, (iy), c                 ; Error
 res 0, (iy), d                 ; Error
 res 0, (iy), e                 ; Error
 res 0, (iy), h                 ; Error
 res 0, (iy), l                 ; Error
 res 0, (iy+127), a             ; Error
 res 0, (iy+127), b             ; Error
 res 0, (iy+127), c             ; Error
 res 0, (iy+127), d             ; Error
 res 0, (iy+127), e             ; Error
 res 0, (iy+127), h             ; Error
 res 0, (iy+127), l             ; Error
 res 0, (iy-128), a             ; Error
 res 0, (iy-128), b             ; Error
 res 0, (iy-128), c             ; Error
 res 0, (iy-128), d             ; Error
 res 0, (iy-128), e             ; Error
 res 0, (iy-128), h             ; Error
 res 0, (iy-128), l             ; Error
 res 1, (ix), a                 ; Error
 res 1, (ix), b                 ; Error
 res 1, (ix), c                 ; Error
 res 1, (ix), d                 ; Error
 res 1, (ix), e                 ; Error
 res 1, (ix), h                 ; Error
 res 1, (ix), l                 ; Error
 res 1, (ix+127), a             ; Error
 res 1, (ix+127), b             ; Error
 res 1, (ix+127), c             ; Error
 res 1, (ix+127), d             ; Error
 res 1, (ix+127), e             ; Error
 res 1, (ix+127), h             ; Error
 res 1, (ix+127), l             ; Error
 res 1, (ix-128), a             ; Error
 res 1, (ix-128), b             ; Error
 res 1, (ix-128), c             ; Error
 res 1, (ix-128), d             ; Error
 res 1, (ix-128), e             ; Error
 res 1, (ix-128), h             ; Error
 res 1, (ix-128), l             ; Error
 res 1, (iy), a                 ; Error
 res 1, (iy), b                 ; Error
 res 1, (iy), c                 ; Error
 res 1, (iy), d                 ; Error
 res 1, (iy), e                 ; Error
 res 1, (iy), h                 ; Error
 res 1, (iy), l                 ; Error
 res 1, (iy+127), a             ; Error
 res 1, (iy+127), b             ; Error
 res 1, (iy+127), c             ; Error
 res 1, (iy+127), d             ; Error
 res 1, (iy+127), e             ; Error
 res 1, (iy+127), h             ; Error
 res 1, (iy+127), l             ; Error
 res 1, (iy-128), a             ; Error
 res 1, (iy-128), b             ; Error
 res 1, (iy-128), c             ; Error
 res 1, (iy-128), d             ; Error
 res 1, (iy-128), e             ; Error
 res 1, (iy-128), h             ; Error
 res 1, (iy-128), l             ; Error
 res 2, (ix), a                 ; Error
 res 2, (ix), b                 ; Error
 res 2, (ix), c                 ; Error
 res 2, (ix), d                 ; Error
 res 2, (ix), e                 ; Error
 res 2, (ix), h                 ; Error
 res 2, (ix), l                 ; Error
 res 2, (ix+127), a             ; Error
 res 2, (ix+127), b             ; Error
 res 2, (ix+127), c             ; Error
 res 2, (ix+127), d             ; Error
 res 2, (ix+127), e             ; Error
 res 2, (ix+127), h             ; Error
 res 2, (ix+127), l             ; Error
 res 2, (ix-128), a             ; Error
 res 2, (ix-128), b             ; Error
 res 2, (ix-128), c             ; Error
 res 2, (ix-128), d             ; Error
 res 2, (ix-128), e             ; Error
 res 2, (ix-128), h             ; Error
 res 2, (ix-128), l             ; Error
 res 2, (iy), a                 ; Error
 res 2, (iy), b                 ; Error
 res 2, (iy), c                 ; Error
 res 2, (iy), d                 ; Error
 res 2, (iy), e                 ; Error
 res 2, (iy), h                 ; Error
 res 2, (iy), l                 ; Error
 res 2, (iy+127), a             ; Error
 res 2, (iy+127), b             ; Error
 res 2, (iy+127), c             ; Error
 res 2, (iy+127), d             ; Error
 res 2, (iy+127), e             ; Error
 res 2, (iy+127), h             ; Error
 res 2, (iy+127), l             ; Error
 res 2, (iy-128), a             ; Error
 res 2, (iy-128), b             ; Error
 res 2, (iy-128), c             ; Error
 res 2, (iy-128), d             ; Error
 res 2, (iy-128), e             ; Error
 res 2, (iy-128), h             ; Error
 res 2, (iy-128), l             ; Error
 res 3, (ix), a                 ; Error
 res 3, (ix), b                 ; Error
 res 3, (ix), c                 ; Error
 res 3, (ix), d                 ; Error
 res 3, (ix), e                 ; Error
 res 3, (ix), h                 ; Error
 res 3, (ix), l                 ; Error
 res 3, (ix+127), a             ; Error
 res 3, (ix+127), b             ; Error
 res 3, (ix+127), c             ; Error
 res 3, (ix+127), d             ; Error
 res 3, (ix+127), e             ; Error
 res 3, (ix+127), h             ; Error
 res 3, (ix+127), l             ; Error
 res 3, (ix-128), a             ; Error
 res 3, (ix-128), b             ; Error
 res 3, (ix-128), c             ; Error
 res 3, (ix-128), d             ; Error
 res 3, (ix-128), e             ; Error
 res 3, (ix-128), h             ; Error
 res 3, (ix-128), l             ; Error
 res 3, (iy), a                 ; Error
 res 3, (iy), b                 ; Error
 res 3, (iy), c                 ; Error
 res 3, (iy), d                 ; Error
 res 3, (iy), e                 ; Error
 res 3, (iy), h                 ; Error
 res 3, (iy), l                 ; Error
 res 3, (iy+127), a             ; Error
 res 3, (iy+127), b             ; Error
 res 3, (iy+127), c             ; Error
 res 3, (iy+127), d             ; Error
 res 3, (iy+127), e             ; Error
 res 3, (iy+127), h             ; Error
 res 3, (iy+127), l             ; Error
 res 3, (iy-128), a             ; Error
 res 3, (iy-128), b             ; Error
 res 3, (iy-128), c             ; Error
 res 3, (iy-128), d             ; Error
 res 3, (iy-128), e             ; Error
 res 3, (iy-128), h             ; Error
 res 3, (iy-128), l             ; Error
 res 4, (ix), a                 ; Error
 res 4, (ix), b                 ; Error
 res 4, (ix), c                 ; Error
 res 4, (ix), d                 ; Error
 res 4, (ix), e                 ; Error
 res 4, (ix), h                 ; Error
 res 4, (ix), l                 ; Error
 res 4, (ix+127), a             ; Error
 res 4, (ix+127), b             ; Error
 res 4, (ix+127), c             ; Error
 res 4, (ix+127), d             ; Error
 res 4, (ix+127), e             ; Error
 res 4, (ix+127), h             ; Error
 res 4, (ix+127), l             ; Error
 res 4, (ix-128), a             ; Error
 res 4, (ix-128), b             ; Error
 res 4, (ix-128), c             ; Error
 res 4, (ix-128), d             ; Error
 res 4, (ix-128), e             ; Error
 res 4, (ix-128), h             ; Error
 res 4, (ix-128), l             ; Error
 res 4, (iy), a                 ; Error
 res 4, (iy), b                 ; Error
 res 4, (iy), c                 ; Error
 res 4, (iy), d                 ; Error
 res 4, (iy), e                 ; Error
 res 4, (iy), h                 ; Error
 res 4, (iy), l                 ; Error
 res 4, (iy+127), a             ; Error
 res 4, (iy+127), b             ; Error
 res 4, (iy+127), c             ; Error
 res 4, (iy+127), d             ; Error
 res 4, (iy+127), e             ; Error
 res 4, (iy+127), h             ; Error
 res 4, (iy+127), l             ; Error
 res 4, (iy-128), a             ; Error
 res 4, (iy-128), b             ; Error
 res 4, (iy-128), c             ; Error
 res 4, (iy-128), d             ; Error
 res 4, (iy-128), e             ; Error
 res 4, (iy-128), h             ; Error
 res 4, (iy-128), l             ; Error
 res 5, (ix), a                 ; Error
 res 5, (ix), b                 ; Error
 res 5, (ix), c                 ; Error
 res 5, (ix), d                 ; Error
 res 5, (ix), e                 ; Error
 res 5, (ix), h                 ; Error
 res 5, (ix), l                 ; Error
 res 5, (ix+127), a             ; Error
 res 5, (ix+127), b             ; Error
 res 5, (ix+127), c             ; Error
 res 5, (ix+127), d             ; Error
 res 5, (ix+127), e             ; Error
 res 5, (ix+127), h             ; Error
 res 5, (ix+127), l             ; Error
 res 5, (ix-128), a             ; Error
 res 5, (ix-128), b             ; Error
 res 5, (ix-128), c             ; Error
 res 5, (ix-128), d             ; Error
 res 5, (ix-128), e             ; Error
 res 5, (ix-128), h             ; Error
 res 5, (ix-128), l             ; Error
 res 5, (iy), a                 ; Error
 res 5, (iy), b                 ; Error
 res 5, (iy), c                 ; Error
 res 5, (iy), d                 ; Error
 res 5, (iy), e                 ; Error
 res 5, (iy), h                 ; Error
 res 5, (iy), l                 ; Error
 res 5, (iy+127), a             ; Error
 res 5, (iy+127), b             ; Error
 res 5, (iy+127), c             ; Error
 res 5, (iy+127), d             ; Error
 res 5, (iy+127), e             ; Error
 res 5, (iy+127), h             ; Error
 res 5, (iy+127), l             ; Error
 res 5, (iy-128), a             ; Error
 res 5, (iy-128), b             ; Error
 res 5, (iy-128), c             ; Error
 res 5, (iy-128), d             ; Error
 res 5, (iy-128), e             ; Error
 res 5, (iy-128), h             ; Error
 res 5, (iy-128), l             ; Error
 res 6, (ix), a                 ; Error
 res 6, (ix), b                 ; Error
 res 6, (ix), c                 ; Error
 res 6, (ix), d                 ; Error
 res 6, (ix), e                 ; Error
 res 6, (ix), h                 ; Error
 res 6, (ix), l                 ; Error
 res 6, (ix+127), a             ; Error
 res 6, (ix+127), b             ; Error
 res 6, (ix+127), c             ; Error
 res 6, (ix+127), d             ; Error
 res 6, (ix+127), e             ; Error
 res 6, (ix+127), h             ; Error
 res 6, (ix+127), l             ; Error
 res 6, (ix-128), a             ; Error
 res 6, (ix-128), b             ; Error
 res 6, (ix-128), c             ; Error
 res 6, (ix-128), d             ; Error
 res 6, (ix-128), e             ; Error
 res 6, (ix-128), h             ; Error
 res 6, (ix-128), l             ; Error
 res 6, (iy), a                 ; Error
 res 6, (iy), b                 ; Error
 res 6, (iy), c                 ; Error
 res 6, (iy), d                 ; Error
 res 6, (iy), e                 ; Error
 res 6, (iy), h                 ; Error
 res 6, (iy), l                 ; Error
 res 6, (iy+127), a             ; Error
 res 6, (iy+127), b             ; Error
 res 6, (iy+127), c             ; Error
 res 6, (iy+127), d             ; Error
 res 6, (iy+127), e             ; Error
 res 6, (iy+127), h             ; Error
 res 6, (iy+127), l             ; Error
 res 6, (iy-128), a             ; Error
 res 6, (iy-128), b             ; Error
 res 6, (iy-128), c             ; Error
 res 6, (iy-128), d             ; Error
 res 6, (iy-128), e             ; Error
 res 6, (iy-128), h             ; Error
 res 6, (iy-128), l             ; Error
 res 7, (ix), a                 ; Error
 res 7, (ix), b                 ; Error
 res 7, (ix), c                 ; Error
 res 7, (ix), d                 ; Error
 res 7, (ix), e                 ; Error
 res 7, (ix), h                 ; Error
 res 7, (ix), l                 ; Error
 res 7, (ix+127), a             ; Error
 res 7, (ix+127), b             ; Error
 res 7, (ix+127), c             ; Error
 res 7, (ix+127), d             ; Error
 res 7, (ix+127), e             ; Error
 res 7, (ix+127), h             ; Error
 res 7, (ix+127), l             ; Error
 res 7, (ix-128), a             ; Error
 res 7, (ix-128), b             ; Error
 res 7, (ix-128), c             ; Error
 res 7, (ix-128), d             ; Error
 res 7, (ix-128), e             ; Error
 res 7, (ix-128), h             ; Error
 res 7, (ix-128), l             ; Error
 res 7, (iy), a                 ; Error
 res 7, (iy), b                 ; Error
 res 7, (iy), c                 ; Error
 res 7, (iy), d                 ; Error
 res 7, (iy), e                 ; Error
 res 7, (iy), h                 ; Error
 res 7, (iy), l                 ; Error
 res 7, (iy+127), a             ; Error
 res 7, (iy+127), b             ; Error
 res 7, (iy+127), c             ; Error
 res 7, (iy+127), d             ; Error
 res 7, (iy+127), e             ; Error
 res 7, (iy+127), h             ; Error
 res 7, (iy+127), l             ; Error
 res 7, (iy-128), a             ; Error
 res 7, (iy-128), b             ; Error
 res 7, (iy-128), c             ; Error
 res 7, (iy-128), d             ; Error
 res 7, (iy-128), e             ; Error
 res 7, (iy-128), h             ; Error
 res 7, (iy-128), l             ; Error
 res 8, (hl)                    ; Error
 res 8, (hl)                    ; Error
 res 8, (ix)                    ; Error
 res 8, (ix)                    ; Error
 res 8, (ix), a                 ; Error
 res 8, (ix), a                 ; Error
 res 8, (ix), b                 ; Error
 res 8, (ix), b                 ; Error
 res 8, (ix), c                 ; Error
 res 8, (ix), c                 ; Error
 res 8, (ix), d                 ; Error
 res 8, (ix), d                 ; Error
 res 8, (ix), e                 ; Error
 res 8, (ix), e                 ; Error
 res 8, (ix), h                 ; Error
 res 8, (ix), h                 ; Error
 res 8, (ix), l                 ; Error
 res 8, (ix), l                 ; Error
 res 8, (ix+127)                ; Error
 res 8, (ix+127)                ; Error
 res 8, (ix+127), a             ; Error
 res 8, (ix+127), a             ; Error
 res 8, (ix+127), b             ; Error
 res 8, (ix+127), b             ; Error
 res 8, (ix+127), c             ; Error
 res 8, (ix+127), c             ; Error
 res 8, (ix+127), d             ; Error
 res 8, (ix+127), d             ; Error
 res 8, (ix+127), e             ; Error
 res 8, (ix+127), e             ; Error
 res 8, (ix+127), h             ; Error
 res 8, (ix+127), h             ; Error
 res 8, (ix+127), l             ; Error
 res 8, (ix+127), l             ; Error
 res 8, (ix-128)                ; Error
 res 8, (ix-128)                ; Error
 res 8, (ix-128), a             ; Error
 res 8, (ix-128), a             ; Error
 res 8, (ix-128), b             ; Error
 res 8, (ix-128), b             ; Error
 res 8, (ix-128), c             ; Error
 res 8, (ix-128), c             ; Error
 res 8, (ix-128), d             ; Error
 res 8, (ix-128), d             ; Error
 res 8, (ix-128), e             ; Error
 res 8, (ix-128), e             ; Error
 res 8, (ix-128), h             ; Error
 res 8, (ix-128), h             ; Error
 res 8, (ix-128), l             ; Error
 res 8, (ix-128), l             ; Error
 res 8, (iy)                    ; Error
 res 8, (iy)                    ; Error
 res 8, (iy), a                 ; Error
 res 8, (iy), a                 ; Error
 res 8, (iy), b                 ; Error
 res 8, (iy), b                 ; Error
 res 8, (iy), c                 ; Error
 res 8, (iy), c                 ; Error
 res 8, (iy), d                 ; Error
 res 8, (iy), d                 ; Error
 res 8, (iy), e                 ; Error
 res 8, (iy), e                 ; Error
 res 8, (iy), h                 ; Error
 res 8, (iy), h                 ; Error
 res 8, (iy), l                 ; Error
 res 8, (iy), l                 ; Error
 res 8, (iy+127)                ; Error
 res 8, (iy+127)                ; Error
 res 8, (iy+127), a             ; Error
 res 8, (iy+127), a             ; Error
 res 8, (iy+127), b             ; Error
 res 8, (iy+127), b             ; Error
 res 8, (iy+127), c             ; Error
 res 8, (iy+127), c             ; Error
 res 8, (iy+127), d             ; Error
 res 8, (iy+127), d             ; Error
 res 8, (iy+127), e             ; Error
 res 8, (iy+127), e             ; Error
 res 8, (iy+127), h             ; Error
 res 8, (iy+127), h             ; Error
 res 8, (iy+127), l             ; Error
 res 8, (iy+127), l             ; Error
 res 8, (iy-128)                ; Error
 res 8, (iy-128)                ; Error
 res 8, (iy-128), a             ; Error
 res 8, (iy-128), a             ; Error
 res 8, (iy-128), b             ; Error
 res 8, (iy-128), b             ; Error
 res 8, (iy-128), c             ; Error
 res 8, (iy-128), c             ; Error
 res 8, (iy-128), d             ; Error
 res 8, (iy-128), d             ; Error
 res 8, (iy-128), e             ; Error
 res 8, (iy-128), e             ; Error
 res 8, (iy-128), h             ; Error
 res 8, (iy-128), h             ; Error
 res 8, (iy-128), l             ; Error
 res 8, (iy-128), l             ; Error
 res 8, a                       ; Error
 res 8, a                       ; Error
 res 8, a'                      ; Error
 res 8, a'                      ; Error
 res 8, b                       ; Error
 res 8, b                       ; Error
 res 8, b'                      ; Error
 res 8, b'                      ; Error
 res 8, c                       ; Error
 res 8, c                       ; Error
 res 8, c'                      ; Error
 res 8, c'                      ; Error
 res 8, d                       ; Error
 res 8, d                       ; Error
 res 8, d'                      ; Error
 res 8, d'                      ; Error
 res 8, e                       ; Error
 res 8, e                       ; Error
 res 8, e'                      ; Error
 res 8, e'                      ; Error
 res 8, h                       ; Error
 res 8, h                       ; Error
 res 8, h'                      ; Error
 res 8, h'                      ; Error
 res 8, l                       ; Error
 res 8, l                       ; Error
 res 8, l'                      ; Error
 res 8, l'                      ; Error
 res a, -1, (ix)                ; Error
 res a, -1, (ix)                ; Error
 res a, -1, (ix+127)            ; Error
 res a, -1, (ix+127)            ; Error
 res a, -1, (ix-128)            ; Error
 res a, -1, (ix-128)            ; Error
 res a, -1, (iy)                ; Error
 res a, -1, (iy)                ; Error
 res a, -1, (iy+127)            ; Error
 res a, -1, (iy+127)            ; Error
 res a, -1, (iy-128)            ; Error
 res a, -1, (iy-128)            ; Error
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
 res a, 8, (ix)                 ; Error
 res a, 8, (ix)                 ; Error
 res a, 8, (ix+127)             ; Error
 res a, 8, (ix+127)             ; Error
 res a, 8, (ix-128)             ; Error
 res a, 8, (ix-128)             ; Error
 res a, 8, (iy)                 ; Error
 res a, 8, (iy)                 ; Error
 res a, 8, (iy+127)             ; Error
 res a, 8, (iy+127)             ; Error
 res a, 8, (iy-128)             ; Error
 res a, 8, (iy-128)             ; Error
 res b, -1, (ix)                ; Error
 res b, -1, (ix)                ; Error
 res b, -1, (ix+127)            ; Error
 res b, -1, (ix+127)            ; Error
 res b, -1, (ix-128)            ; Error
 res b, -1, (ix-128)            ; Error
 res b, -1, (iy)                ; Error
 res b, -1, (iy)                ; Error
 res b, -1, (iy+127)            ; Error
 res b, -1, (iy+127)            ; Error
 res b, -1, (iy-128)            ; Error
 res b, -1, (iy-128)            ; Error
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
 res b, 8, (ix)                 ; Error
 res b, 8, (ix)                 ; Error
 res b, 8, (ix+127)             ; Error
 res b, 8, (ix+127)             ; Error
 res b, 8, (ix-128)             ; Error
 res b, 8, (ix-128)             ; Error
 res b, 8, (iy)                 ; Error
 res b, 8, (iy)                 ; Error
 res b, 8, (iy+127)             ; Error
 res b, 8, (iy+127)             ; Error
 res b, 8, (iy-128)             ; Error
 res b, 8, (iy-128)             ; Error
 res c, -1, (ix)                ; Error
 res c, -1, (ix)                ; Error
 res c, -1, (ix+127)            ; Error
 res c, -1, (ix+127)            ; Error
 res c, -1, (ix-128)            ; Error
 res c, -1, (ix-128)            ; Error
 res c, -1, (iy)                ; Error
 res c, -1, (iy)                ; Error
 res c, -1, (iy+127)            ; Error
 res c, -1, (iy+127)            ; Error
 res c, -1, (iy-128)            ; Error
 res c, -1, (iy-128)            ; Error
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
 res c, 8, (ix)                 ; Error
 res c, 8, (ix)                 ; Error
 res c, 8, (ix+127)             ; Error
 res c, 8, (ix+127)             ; Error
 res c, 8, (ix-128)             ; Error
 res c, 8, (ix-128)             ; Error
 res c, 8, (iy)                 ; Error
 res c, 8, (iy)                 ; Error
 res c, 8, (iy+127)             ; Error
 res c, 8, (iy+127)             ; Error
 res c, 8, (iy-128)             ; Error
 res c, 8, (iy-128)             ; Error
 res d, -1, (ix)                ; Error
 res d, -1, (ix)                ; Error
 res d, -1, (ix+127)            ; Error
 res d, -1, (ix+127)            ; Error
 res d, -1, (ix-128)            ; Error
 res d, -1, (ix-128)            ; Error
 res d, -1, (iy)                ; Error
 res d, -1, (iy)                ; Error
 res d, -1, (iy+127)            ; Error
 res d, -1, (iy+127)            ; Error
 res d, -1, (iy-128)            ; Error
 res d, -1, (iy-128)            ; Error
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
 res d, 8, (ix)                 ; Error
 res d, 8, (ix)                 ; Error
 res d, 8, (ix+127)             ; Error
 res d, 8, (ix+127)             ; Error
 res d, 8, (ix-128)             ; Error
 res d, 8, (ix-128)             ; Error
 res d, 8, (iy)                 ; Error
 res d, 8, (iy)                 ; Error
 res d, 8, (iy+127)             ; Error
 res d, 8, (iy+127)             ; Error
 res d, 8, (iy-128)             ; Error
 res d, 8, (iy-128)             ; Error
 res e, -1, (ix)                ; Error
 res e, -1, (ix)                ; Error
 res e, -1, (ix+127)            ; Error
 res e, -1, (ix+127)            ; Error
 res e, -1, (ix-128)            ; Error
 res e, -1, (ix-128)            ; Error
 res e, -1, (iy)                ; Error
 res e, -1, (iy)                ; Error
 res e, -1, (iy+127)            ; Error
 res e, -1, (iy+127)            ; Error
 res e, -1, (iy-128)            ; Error
 res e, -1, (iy-128)            ; Error
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
 res e, 8, (ix)                 ; Error
 res e, 8, (ix)                 ; Error
 res e, 8, (ix+127)             ; Error
 res e, 8, (ix+127)             ; Error
 res e, 8, (ix-128)             ; Error
 res e, 8, (ix-128)             ; Error
 res e, 8, (iy)                 ; Error
 res e, 8, (iy)                 ; Error
 res e, 8, (iy+127)             ; Error
 res e, 8, (iy+127)             ; Error
 res e, 8, (iy-128)             ; Error
 res e, 8, (iy-128)             ; Error
 res h, -1, (ix)                ; Error
 res h, -1, (ix)                ; Error
 res h, -1, (ix+127)            ; Error
 res h, -1, (ix+127)            ; Error
 res h, -1, (ix-128)            ; Error
 res h, -1, (ix-128)            ; Error
 res h, -1, (iy)                ; Error
 res h, -1, (iy)                ; Error
 res h, -1, (iy+127)            ; Error
 res h, -1, (iy+127)            ; Error
 res h, -1, (iy-128)            ; Error
 res h, -1, (iy-128)            ; Error
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
 res h, 8, (ix)                 ; Error
 res h, 8, (ix)                 ; Error
 res h, 8, (ix+127)             ; Error
 res h, 8, (ix+127)             ; Error
 res h, 8, (ix-128)             ; Error
 res h, 8, (ix-128)             ; Error
 res h, 8, (iy)                 ; Error
 res h, 8, (iy)                 ; Error
 res h, 8, (iy+127)             ; Error
 res h, 8, (iy+127)             ; Error
 res h, 8, (iy-128)             ; Error
 res h, 8, (iy-128)             ; Error
 res l, -1, (ix)                ; Error
 res l, -1, (ix)                ; Error
 res l, -1, (ix+127)            ; Error
 res l, -1, (ix+127)            ; Error
 res l, -1, (ix-128)            ; Error
 res l, -1, (ix-128)            ; Error
 res l, -1, (iy)                ; Error
 res l, -1, (iy)                ; Error
 res l, -1, (iy+127)            ; Error
 res l, -1, (iy+127)            ; Error
 res l, -1, (iy-128)            ; Error
 res l, -1, (iy-128)            ; Error
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
 res l, 8, (ix)                 ; Error
 res l, 8, (ix)                 ; Error
 res l, 8, (ix+127)             ; Error
 res l, 8, (ix+127)             ; Error
 res l, 8, (ix-128)             ; Error
 res l, 8, (ix-128)             ; Error
 res l, 8, (iy)                 ; Error
 res l, 8, (iy)                 ; Error
 res l, 8, (iy+127)             ; Error
 res l, 8, (iy+127)             ; Error
 res l, 8, (iy-128)             ; Error
 res l, 8, (iy-128)             ; Error
 res.a -1, (hl)                 ; Error
 res.a -1, (hl)                 ; Error
 res.a -1, (ix)                 ; Error
 res.a -1, (ix)                 ; Error
 res.a -1, (ix+127)             ; Error
 res.a -1, (ix+127)             ; Error
 res.a -1, (ix-128)             ; Error
 res.a -1, (ix-128)             ; Error
 res.a -1, (iy)                 ; Error
 res.a -1, (iy)                 ; Error
 res.a -1, (iy+127)             ; Error
 res.a -1, (iy+127)             ; Error
 res.a -1, (iy-128)             ; Error
 res.a -1, (iy-128)             ; Error
 res.a -1, a                    ; Error
 res.a -1, a                    ; Error
 res.a -1, b                    ; Error
 res.a -1, b                    ; Error
 res.a -1, c                    ; Error
 res.a -1, c                    ; Error
 res.a -1, d                    ; Error
 res.a -1, d                    ; Error
 res.a -1, e                    ; Error
 res.a -1, e                    ; Error
 res.a -1, h                    ; Error
 res.a -1, h                    ; Error
 res.a -1, l                    ; Error
 res.a -1, l                    ; Error
 res.a 8, (hl)                  ; Error
 res.a 8, (hl)                  ; Error
 res.a 8, (ix)                  ; Error
 res.a 8, (ix)                  ; Error
 res.a 8, (ix+127)              ; Error
 res.a 8, (ix+127)              ; Error
 res.a 8, (ix-128)              ; Error
 res.a 8, (ix-128)              ; Error
 res.a 8, (iy)                  ; Error
 res.a 8, (iy)                  ; Error
 res.a 8, (iy+127)              ; Error
 res.a 8, (iy+127)              ; Error
 res.a 8, (iy-128)              ; Error
 res.a 8, (iy-128)              ; Error
 res.a 8, a                     ; Error
 res.a 8, a                     ; Error
 res.a 8, b                     ; Error
 res.a 8, b                     ; Error
 res.a 8, c                     ; Error
 res.a 8, c                     ; Error
 res.a 8, d                     ; Error
 res.a 8, d                     ; Error
 res.a 8, e                     ; Error
 res.a 8, e                     ; Error
 res.a 8, h                     ; Error
 res.a 8, h                     ; Error
 res.a 8, l                     ; Error
 res.a 8, l                     ; Error
 retn                           ; Error
 rim                            ; Error
 rl (ix), a                     ; Error
 rl (ix), b                     ; Error
 rl (ix), c                     ; Error
 rl (ix), d                     ; Error
 rl (ix), e                     ; Error
 rl (ix), h                     ; Error
 rl (ix), l                     ; Error
 rl (ix+127), a                 ; Error
 rl (ix+127), b                 ; Error
 rl (ix+127), c                 ; Error
 rl (ix+127), d                 ; Error
 rl (ix+127), e                 ; Error
 rl (ix+127), h                 ; Error
 rl (ix+127), l                 ; Error
 rl (ix-128), a                 ; Error
 rl (ix-128), b                 ; Error
 rl (ix-128), c                 ; Error
 rl (ix-128), d                 ; Error
 rl (ix-128), e                 ; Error
 rl (ix-128), h                 ; Error
 rl (ix-128), l                 ; Error
 rl (iy), a                     ; Error
 rl (iy), b                     ; Error
 rl (iy), c                     ; Error
 rl (iy), d                     ; Error
 rl (iy), e                     ; Error
 rl (iy), h                     ; Error
 rl (iy), l                     ; Error
 rl (iy+127), a                 ; Error
 rl (iy+127), b                 ; Error
 rl (iy+127), c                 ; Error
 rl (iy+127), d                 ; Error
 rl (iy+127), e                 ; Error
 rl (iy+127), h                 ; Error
 rl (iy+127), l                 ; Error
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
 rlc (ix), a                    ; Error
 rlc (ix), b                    ; Error
 rlc (ix), c                    ; Error
 rlc (ix), d                    ; Error
 rlc (ix), e                    ; Error
 rlc (ix), h                    ; Error
 rlc (ix), l                    ; Error
 rlc (ix+127), a                ; Error
 rlc (ix+127), b                ; Error
 rlc (ix+127), c                ; Error
 rlc (ix+127), d                ; Error
 rlc (ix+127), e                ; Error
 rlc (ix+127), h                ; Error
 rlc (ix+127), l                ; Error
 rlc (ix-128), a                ; Error
 rlc (ix-128), b                ; Error
 rlc (ix-128), c                ; Error
 rlc (ix-128), d                ; Error
 rlc (ix-128), e                ; Error
 rlc (ix-128), h                ; Error
 rlc (ix-128), l                ; Error
 rlc (iy), a                    ; Error
 rlc (iy), b                    ; Error
 rlc (iy), c                    ; Error
 rlc (iy), d                    ; Error
 rlc (iy), e                    ; Error
 rlc (iy), h                    ; Error
 rlc (iy), l                    ; Error
 rlc (iy+127), a                ; Error
 rlc (iy+127), b                ; Error
 rlc (iy+127), c                ; Error
 rlc (iy+127), d                ; Error
 rlc (iy+127), e                ; Error
 rlc (iy+127), h                ; Error
 rlc (iy+127), l                ; Error
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
 rr (ix), a                     ; Error
 rr (ix), b                     ; Error
 rr (ix), c                     ; Error
 rr (ix), d                     ; Error
 rr (ix), e                     ; Error
 rr (ix), h                     ; Error
 rr (ix), l                     ; Error
 rr (ix+127), a                 ; Error
 rr (ix+127), b                 ; Error
 rr (ix+127), c                 ; Error
 rr (ix+127), d                 ; Error
 rr (ix+127), e                 ; Error
 rr (ix+127), h                 ; Error
 rr (ix+127), l                 ; Error
 rr (ix-128), a                 ; Error
 rr (ix-128), b                 ; Error
 rr (ix-128), c                 ; Error
 rr (ix-128), d                 ; Error
 rr (ix-128), e                 ; Error
 rr (ix-128), h                 ; Error
 rr (ix-128), l                 ; Error
 rr (iy), a                     ; Error
 rr (iy), b                     ; Error
 rr (iy), c                     ; Error
 rr (iy), d                     ; Error
 rr (iy), e                     ; Error
 rr (iy), h                     ; Error
 rr (iy), l                     ; Error
 rr (iy+127), a                 ; Error
 rr (iy+127), b                 ; Error
 rr (iy+127), c                 ; Error
 rr (iy+127), d                 ; Error
 rr (iy+127), e                 ; Error
 rr (iy+127), h                 ; Error
 rr (iy+127), l                 ; Error
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
 rrc (ix), a                    ; Error
 rrc (ix), b                    ; Error
 rrc (ix), c                    ; Error
 rrc (ix), d                    ; Error
 rrc (ix), e                    ; Error
 rrc (ix), h                    ; Error
 rrc (ix), l                    ; Error
 rrc (ix+127), a                ; Error
 rrc (ix+127), b                ; Error
 rrc (ix+127), c                ; Error
 rrc (ix+127), d                ; Error
 rrc (ix+127), e                ; Error
 rrc (ix+127), h                ; Error
 rrc (ix+127), l                ; Error
 rrc (ix-128), a                ; Error
 rrc (ix-128), b                ; Error
 rrc (ix-128), c                ; Error
 rrc (ix-128), d                ; Error
 rrc (ix-128), e                ; Error
 rrc (ix-128), h                ; Error
 rrc (ix-128), l                ; Error
 rrc (iy), a                    ; Error
 rrc (iy), b                    ; Error
 rrc (iy), c                    ; Error
 rrc (iy), d                    ; Error
 rrc (iy), e                    ; Error
 rrc (iy), h                    ; Error
 rrc (iy), l                    ; Error
 rrc (iy+127), a                ; Error
 rrc (iy+127), b                ; Error
 rrc (iy+127), c                ; Error
 rrc (iy+127), d                ; Error
 rrc (iy+127), e                ; Error
 rrc (iy+127), h                ; Error
 rrc (iy+127), l                ; Error
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
 rst -1                         ; Error
 rst -1                         ; Error
 rst 10                         ; Error
 rst 10                         ; Error
 rst 11                         ; Error
 rst 11                         ; Error
 rst 12                         ; Error
 rst 12                         ; Error
 rst 13                         ; Error
 rst 13                         ; Error
 rst 14                         ; Error
 rst 14                         ; Error
 rst 15                         ; Error
 rst 15                         ; Error
 rst 17                         ; Error
 rst 17                         ; Error
 rst 18                         ; Error
 rst 18                         ; Error
 rst 19                         ; Error
 rst 19                         ; Error
 rst 20                         ; Error
 rst 20                         ; Error
 rst 21                         ; Error
 rst 21                         ; Error
 rst 22                         ; Error
 rst 22                         ; Error
 rst 23                         ; Error
 rst 23                         ; Error
 rst 25                         ; Error
 rst 25                         ; Error
 rst 26                         ; Error
 rst 26                         ; Error
 rst 27                         ; Error
 rst 27                         ; Error
 rst 28                         ; Error
 rst 28                         ; Error
 rst 29                         ; Error
 rst 29                         ; Error
 rst 30                         ; Error
 rst 30                         ; Error
 rst 31                         ; Error
 rst 31                         ; Error
 rst 33                         ; Error
 rst 33                         ; Error
 rst 34                         ; Error
 rst 34                         ; Error
 rst 35                         ; Error
 rst 35                         ; Error
 rst 36                         ; Error
 rst 36                         ; Error
 rst 37                         ; Error
 rst 37                         ; Error
 rst 38                         ; Error
 rst 38                         ; Error
 rst 39                         ; Error
 rst 39                         ; Error
 rst 41                         ; Error
 rst 41                         ; Error
 rst 42                         ; Error
 rst 42                         ; Error
 rst 43                         ; Error
 rst 43                         ; Error
 rst 44                         ; Error
 rst 44                         ; Error
 rst 45                         ; Error
 rst 45                         ; Error
 rst 46                         ; Error
 rst 46                         ; Error
 rst 47                         ; Error
 rst 47                         ; Error
 rst 49                         ; Error
 rst 49                         ; Error
 rst 50                         ; Error
 rst 50                         ; Error
 rst 51                         ; Error
 rst 51                         ; Error
 rst 52                         ; Error
 rst 52                         ; Error
 rst 53                         ; Error
 rst 53                         ; Error
 rst 54                         ; Error
 rst 54                         ; Error
 rst 55                         ; Error
 rst 55                         ; Error
 rst 57                         ; Error
 rst 57                         ; Error
 rst 58                         ; Error
 rst 58                         ; Error
 rst 59                         ; Error
 rst 59                         ; Error
 rst 60                         ; Error
 rst 60                         ; Error
 rst 61                         ; Error
 rst 61                         ; Error
 rst 62                         ; Error
 rst 62                         ; Error
 rst 63                         ; Error
 rst 63                         ; Error
 rst 64                         ; Error
 rst 64                         ; Error
 rst 9                          ; Error
 rst 9                          ; Error
 rstv                           ; Error
 sbc a, ixh                     ; Error
 sbc a, ixl                     ; Error
 sbc a, iyh                     ; Error
 sbc a, iyl                     ; Error
 sbc ixh                        ; Error
 sbc ixl                        ; Error
 sbc iyh                        ; Error
 sbc iyl                        ; Error
 set -1, (hl)                   ; Error
 set -1, (hl)                   ; Error
 set -1, (ix)                   ; Error
 set -1, (ix)                   ; Error
 set -1, (ix), a                ; Error
 set -1, (ix), a                ; Error
 set -1, (ix), b                ; Error
 set -1, (ix), b                ; Error
 set -1, (ix), c                ; Error
 set -1, (ix), c                ; Error
 set -1, (ix), d                ; Error
 set -1, (ix), d                ; Error
 set -1, (ix), e                ; Error
 set -1, (ix), e                ; Error
 set -1, (ix), h                ; Error
 set -1, (ix), h                ; Error
 set -1, (ix), l                ; Error
 set -1, (ix), l                ; Error
 set -1, (ix+127)               ; Error
 set -1, (ix+127)               ; Error
 set -1, (ix+127), a            ; Error
 set -1, (ix+127), a            ; Error
 set -1, (ix+127), b            ; Error
 set -1, (ix+127), b            ; Error
 set -1, (ix+127), c            ; Error
 set -1, (ix+127), c            ; Error
 set -1, (ix+127), d            ; Error
 set -1, (ix+127), d            ; Error
 set -1, (ix+127), e            ; Error
 set -1, (ix+127), e            ; Error
 set -1, (ix+127), h            ; Error
 set -1, (ix+127), h            ; Error
 set -1, (ix+127), l            ; Error
 set -1, (ix+127), l            ; Error
 set -1, (ix-128)               ; Error
 set -1, (ix-128)               ; Error
 set -1, (ix-128), a            ; Error
 set -1, (ix-128), a            ; Error
 set -1, (ix-128), b            ; Error
 set -1, (ix-128), b            ; Error
 set -1, (ix-128), c            ; Error
 set -1, (ix-128), c            ; Error
 set -1, (ix-128), d            ; Error
 set -1, (ix-128), d            ; Error
 set -1, (ix-128), e            ; Error
 set -1, (ix-128), e            ; Error
 set -1, (ix-128), h            ; Error
 set -1, (ix-128), h            ; Error
 set -1, (ix-128), l            ; Error
 set -1, (ix-128), l            ; Error
 set -1, (iy)                   ; Error
 set -1, (iy)                   ; Error
 set -1, (iy), a                ; Error
 set -1, (iy), a                ; Error
 set -1, (iy), b                ; Error
 set -1, (iy), b                ; Error
 set -1, (iy), c                ; Error
 set -1, (iy), c                ; Error
 set -1, (iy), d                ; Error
 set -1, (iy), d                ; Error
 set -1, (iy), e                ; Error
 set -1, (iy), e                ; Error
 set -1, (iy), h                ; Error
 set -1, (iy), h                ; Error
 set -1, (iy), l                ; Error
 set -1, (iy), l                ; Error
 set -1, (iy+127)               ; Error
 set -1, (iy+127)               ; Error
 set -1, (iy+127), a            ; Error
 set -1, (iy+127), a            ; Error
 set -1, (iy+127), b            ; Error
 set -1, (iy+127), b            ; Error
 set -1, (iy+127), c            ; Error
 set -1, (iy+127), c            ; Error
 set -1, (iy+127), d            ; Error
 set -1, (iy+127), d            ; Error
 set -1, (iy+127), e            ; Error
 set -1, (iy+127), e            ; Error
 set -1, (iy+127), h            ; Error
 set -1, (iy+127), h            ; Error
 set -1, (iy+127), l            ; Error
 set -1, (iy+127), l            ; Error
 set -1, (iy-128)               ; Error
 set -1, (iy-128)               ; Error
 set -1, (iy-128), a            ; Error
 set -1, (iy-128), a            ; Error
 set -1, (iy-128), b            ; Error
 set -1, (iy-128), b            ; Error
 set -1, (iy-128), c            ; Error
 set -1, (iy-128), c            ; Error
 set -1, (iy-128), d            ; Error
 set -1, (iy-128), d            ; Error
 set -1, (iy-128), e            ; Error
 set -1, (iy-128), e            ; Error
 set -1, (iy-128), h            ; Error
 set -1, (iy-128), h            ; Error
 set -1, (iy-128), l            ; Error
 set -1, (iy-128), l            ; Error
 set -1, a                      ; Error
 set -1, a                      ; Error
 set -1, a'                     ; Error
 set -1, a'                     ; Error
 set -1, b                      ; Error
 set -1, b                      ; Error
 set -1, b'                     ; Error
 set -1, b'                     ; Error
 set -1, c                      ; Error
 set -1, c                      ; Error
 set -1, c'                     ; Error
 set -1, c'                     ; Error
 set -1, d                      ; Error
 set -1, d                      ; Error
 set -1, d'                     ; Error
 set -1, d'                     ; Error
 set -1, e                      ; Error
 set -1, e                      ; Error
 set -1, e'                     ; Error
 set -1, e'                     ; Error
 set -1, h                      ; Error
 set -1, h                      ; Error
 set -1, h'                     ; Error
 set -1, h'                     ; Error
 set -1, l                      ; Error
 set -1, l                      ; Error
 set -1, l'                     ; Error
 set -1, l'                     ; Error
 set 0, (ix), a                 ; Error
 set 0, (ix), b                 ; Error
 set 0, (ix), c                 ; Error
 set 0, (ix), d                 ; Error
 set 0, (ix), e                 ; Error
 set 0, (ix), h                 ; Error
 set 0, (ix), l                 ; Error
 set 0, (ix+127), a             ; Error
 set 0, (ix+127), b             ; Error
 set 0, (ix+127), c             ; Error
 set 0, (ix+127), d             ; Error
 set 0, (ix+127), e             ; Error
 set 0, (ix+127), h             ; Error
 set 0, (ix+127), l             ; Error
 set 0, (ix-128), a             ; Error
 set 0, (ix-128), b             ; Error
 set 0, (ix-128), c             ; Error
 set 0, (ix-128), d             ; Error
 set 0, (ix-128), e             ; Error
 set 0, (ix-128), h             ; Error
 set 0, (ix-128), l             ; Error
 set 0, (iy), a                 ; Error
 set 0, (iy), b                 ; Error
 set 0, (iy), c                 ; Error
 set 0, (iy), d                 ; Error
 set 0, (iy), e                 ; Error
 set 0, (iy), h                 ; Error
 set 0, (iy), l                 ; Error
 set 0, (iy+127), a             ; Error
 set 0, (iy+127), b             ; Error
 set 0, (iy+127), c             ; Error
 set 0, (iy+127), d             ; Error
 set 0, (iy+127), e             ; Error
 set 0, (iy+127), h             ; Error
 set 0, (iy+127), l             ; Error
 set 0, (iy-128), a             ; Error
 set 0, (iy-128), b             ; Error
 set 0, (iy-128), c             ; Error
 set 0, (iy-128), d             ; Error
 set 0, (iy-128), e             ; Error
 set 0, (iy-128), h             ; Error
 set 0, (iy-128), l             ; Error
 set 1, (ix), a                 ; Error
 set 1, (ix), b                 ; Error
 set 1, (ix), c                 ; Error
 set 1, (ix), d                 ; Error
 set 1, (ix), e                 ; Error
 set 1, (ix), h                 ; Error
 set 1, (ix), l                 ; Error
 set 1, (ix+127), a             ; Error
 set 1, (ix+127), b             ; Error
 set 1, (ix+127), c             ; Error
 set 1, (ix+127), d             ; Error
 set 1, (ix+127), e             ; Error
 set 1, (ix+127), h             ; Error
 set 1, (ix+127), l             ; Error
 set 1, (ix-128), a             ; Error
 set 1, (ix-128), b             ; Error
 set 1, (ix-128), c             ; Error
 set 1, (ix-128), d             ; Error
 set 1, (ix-128), e             ; Error
 set 1, (ix-128), h             ; Error
 set 1, (ix-128), l             ; Error
 set 1, (iy), a                 ; Error
 set 1, (iy), b                 ; Error
 set 1, (iy), c                 ; Error
 set 1, (iy), d                 ; Error
 set 1, (iy), e                 ; Error
 set 1, (iy), h                 ; Error
 set 1, (iy), l                 ; Error
 set 1, (iy+127), a             ; Error
 set 1, (iy+127), b             ; Error
 set 1, (iy+127), c             ; Error
 set 1, (iy+127), d             ; Error
 set 1, (iy+127), e             ; Error
 set 1, (iy+127), h             ; Error
 set 1, (iy+127), l             ; Error
 set 1, (iy-128), a             ; Error
 set 1, (iy-128), b             ; Error
 set 1, (iy-128), c             ; Error
 set 1, (iy-128), d             ; Error
 set 1, (iy-128), e             ; Error
 set 1, (iy-128), h             ; Error
 set 1, (iy-128), l             ; Error
 set 2, (ix), a                 ; Error
 set 2, (ix), b                 ; Error
 set 2, (ix), c                 ; Error
 set 2, (ix), d                 ; Error
 set 2, (ix), e                 ; Error
 set 2, (ix), h                 ; Error
 set 2, (ix), l                 ; Error
 set 2, (ix+127), a             ; Error
 set 2, (ix+127), b             ; Error
 set 2, (ix+127), c             ; Error
 set 2, (ix+127), d             ; Error
 set 2, (ix+127), e             ; Error
 set 2, (ix+127), h             ; Error
 set 2, (ix+127), l             ; Error
 set 2, (ix-128), a             ; Error
 set 2, (ix-128), b             ; Error
 set 2, (ix-128), c             ; Error
 set 2, (ix-128), d             ; Error
 set 2, (ix-128), e             ; Error
 set 2, (ix-128), h             ; Error
 set 2, (ix-128), l             ; Error
 set 2, (iy), a                 ; Error
 set 2, (iy), b                 ; Error
 set 2, (iy), c                 ; Error
 set 2, (iy), d                 ; Error
 set 2, (iy), e                 ; Error
 set 2, (iy), h                 ; Error
 set 2, (iy), l                 ; Error
 set 2, (iy+127), a             ; Error
 set 2, (iy+127), b             ; Error
 set 2, (iy+127), c             ; Error
 set 2, (iy+127), d             ; Error
 set 2, (iy+127), e             ; Error
 set 2, (iy+127), h             ; Error
 set 2, (iy+127), l             ; Error
 set 2, (iy-128), a             ; Error
 set 2, (iy-128), b             ; Error
 set 2, (iy-128), c             ; Error
 set 2, (iy-128), d             ; Error
 set 2, (iy-128), e             ; Error
 set 2, (iy-128), h             ; Error
 set 2, (iy-128), l             ; Error
 set 3, (ix), a                 ; Error
 set 3, (ix), b                 ; Error
 set 3, (ix), c                 ; Error
 set 3, (ix), d                 ; Error
 set 3, (ix), e                 ; Error
 set 3, (ix), h                 ; Error
 set 3, (ix), l                 ; Error
 set 3, (ix+127), a             ; Error
 set 3, (ix+127), b             ; Error
 set 3, (ix+127), c             ; Error
 set 3, (ix+127), d             ; Error
 set 3, (ix+127), e             ; Error
 set 3, (ix+127), h             ; Error
 set 3, (ix+127), l             ; Error
 set 3, (ix-128), a             ; Error
 set 3, (ix-128), b             ; Error
 set 3, (ix-128), c             ; Error
 set 3, (ix-128), d             ; Error
 set 3, (ix-128), e             ; Error
 set 3, (ix-128), h             ; Error
 set 3, (ix-128), l             ; Error
 set 3, (iy), a                 ; Error
 set 3, (iy), b                 ; Error
 set 3, (iy), c                 ; Error
 set 3, (iy), d                 ; Error
 set 3, (iy), e                 ; Error
 set 3, (iy), h                 ; Error
 set 3, (iy), l                 ; Error
 set 3, (iy+127), a             ; Error
 set 3, (iy+127), b             ; Error
 set 3, (iy+127), c             ; Error
 set 3, (iy+127), d             ; Error
 set 3, (iy+127), e             ; Error
 set 3, (iy+127), h             ; Error
 set 3, (iy+127), l             ; Error
 set 3, (iy-128), a             ; Error
 set 3, (iy-128), b             ; Error
 set 3, (iy-128), c             ; Error
 set 3, (iy-128), d             ; Error
 set 3, (iy-128), e             ; Error
 set 3, (iy-128), h             ; Error
 set 3, (iy-128), l             ; Error
 set 4, (ix), a                 ; Error
 set 4, (ix), b                 ; Error
 set 4, (ix), c                 ; Error
 set 4, (ix), d                 ; Error
 set 4, (ix), e                 ; Error
 set 4, (ix), h                 ; Error
 set 4, (ix), l                 ; Error
 set 4, (ix+127), a             ; Error
 set 4, (ix+127), b             ; Error
 set 4, (ix+127), c             ; Error
 set 4, (ix+127), d             ; Error
 set 4, (ix+127), e             ; Error
 set 4, (ix+127), h             ; Error
 set 4, (ix+127), l             ; Error
 set 4, (ix-128), a             ; Error
 set 4, (ix-128), b             ; Error
 set 4, (ix-128), c             ; Error
 set 4, (ix-128), d             ; Error
 set 4, (ix-128), e             ; Error
 set 4, (ix-128), h             ; Error
 set 4, (ix-128), l             ; Error
 set 4, (iy), a                 ; Error
 set 4, (iy), b                 ; Error
 set 4, (iy), c                 ; Error
 set 4, (iy), d                 ; Error
 set 4, (iy), e                 ; Error
 set 4, (iy), h                 ; Error
 set 4, (iy), l                 ; Error
 set 4, (iy+127), a             ; Error
 set 4, (iy+127), b             ; Error
 set 4, (iy+127), c             ; Error
 set 4, (iy+127), d             ; Error
 set 4, (iy+127), e             ; Error
 set 4, (iy+127), h             ; Error
 set 4, (iy+127), l             ; Error
 set 4, (iy-128), a             ; Error
 set 4, (iy-128), b             ; Error
 set 4, (iy-128), c             ; Error
 set 4, (iy-128), d             ; Error
 set 4, (iy-128), e             ; Error
 set 4, (iy-128), h             ; Error
 set 4, (iy-128), l             ; Error
 set 5, (ix), a                 ; Error
 set 5, (ix), b                 ; Error
 set 5, (ix), c                 ; Error
 set 5, (ix), d                 ; Error
 set 5, (ix), e                 ; Error
 set 5, (ix), h                 ; Error
 set 5, (ix), l                 ; Error
 set 5, (ix+127), a             ; Error
 set 5, (ix+127), b             ; Error
 set 5, (ix+127), c             ; Error
 set 5, (ix+127), d             ; Error
 set 5, (ix+127), e             ; Error
 set 5, (ix+127), h             ; Error
 set 5, (ix+127), l             ; Error
 set 5, (ix-128), a             ; Error
 set 5, (ix-128), b             ; Error
 set 5, (ix-128), c             ; Error
 set 5, (ix-128), d             ; Error
 set 5, (ix-128), e             ; Error
 set 5, (ix-128), h             ; Error
 set 5, (ix-128), l             ; Error
 set 5, (iy), a                 ; Error
 set 5, (iy), b                 ; Error
 set 5, (iy), c                 ; Error
 set 5, (iy), d                 ; Error
 set 5, (iy), e                 ; Error
 set 5, (iy), h                 ; Error
 set 5, (iy), l                 ; Error
 set 5, (iy+127), a             ; Error
 set 5, (iy+127), b             ; Error
 set 5, (iy+127), c             ; Error
 set 5, (iy+127), d             ; Error
 set 5, (iy+127), e             ; Error
 set 5, (iy+127), h             ; Error
 set 5, (iy+127), l             ; Error
 set 5, (iy-128), a             ; Error
 set 5, (iy-128), b             ; Error
 set 5, (iy-128), c             ; Error
 set 5, (iy-128), d             ; Error
 set 5, (iy-128), e             ; Error
 set 5, (iy-128), h             ; Error
 set 5, (iy-128), l             ; Error
 set 6, (ix), a                 ; Error
 set 6, (ix), b                 ; Error
 set 6, (ix), c                 ; Error
 set 6, (ix), d                 ; Error
 set 6, (ix), e                 ; Error
 set 6, (ix), h                 ; Error
 set 6, (ix), l                 ; Error
 set 6, (ix+127), a             ; Error
 set 6, (ix+127), b             ; Error
 set 6, (ix+127), c             ; Error
 set 6, (ix+127), d             ; Error
 set 6, (ix+127), e             ; Error
 set 6, (ix+127), h             ; Error
 set 6, (ix+127), l             ; Error
 set 6, (ix-128), a             ; Error
 set 6, (ix-128), b             ; Error
 set 6, (ix-128), c             ; Error
 set 6, (ix-128), d             ; Error
 set 6, (ix-128), e             ; Error
 set 6, (ix-128), h             ; Error
 set 6, (ix-128), l             ; Error
 set 6, (iy), a                 ; Error
 set 6, (iy), b                 ; Error
 set 6, (iy), c                 ; Error
 set 6, (iy), d                 ; Error
 set 6, (iy), e                 ; Error
 set 6, (iy), h                 ; Error
 set 6, (iy), l                 ; Error
 set 6, (iy+127), a             ; Error
 set 6, (iy+127), b             ; Error
 set 6, (iy+127), c             ; Error
 set 6, (iy+127), d             ; Error
 set 6, (iy+127), e             ; Error
 set 6, (iy+127), h             ; Error
 set 6, (iy+127), l             ; Error
 set 6, (iy-128), a             ; Error
 set 6, (iy-128), b             ; Error
 set 6, (iy-128), c             ; Error
 set 6, (iy-128), d             ; Error
 set 6, (iy-128), e             ; Error
 set 6, (iy-128), h             ; Error
 set 6, (iy-128), l             ; Error
 set 7, (ix), a                 ; Error
 set 7, (ix), b                 ; Error
 set 7, (ix), c                 ; Error
 set 7, (ix), d                 ; Error
 set 7, (ix), e                 ; Error
 set 7, (ix), h                 ; Error
 set 7, (ix), l                 ; Error
 set 7, (ix+127), a             ; Error
 set 7, (ix+127), b             ; Error
 set 7, (ix+127), c             ; Error
 set 7, (ix+127), d             ; Error
 set 7, (ix+127), e             ; Error
 set 7, (ix+127), h             ; Error
 set 7, (ix+127), l             ; Error
 set 7, (ix-128), a             ; Error
 set 7, (ix-128), b             ; Error
 set 7, (ix-128), c             ; Error
 set 7, (ix-128), d             ; Error
 set 7, (ix-128), e             ; Error
 set 7, (ix-128), h             ; Error
 set 7, (ix-128), l             ; Error
 set 7, (iy), a                 ; Error
 set 7, (iy), b                 ; Error
 set 7, (iy), c                 ; Error
 set 7, (iy), d                 ; Error
 set 7, (iy), e                 ; Error
 set 7, (iy), h                 ; Error
 set 7, (iy), l                 ; Error
 set 7, (iy+127), a             ; Error
 set 7, (iy+127), b             ; Error
 set 7, (iy+127), c             ; Error
 set 7, (iy+127), d             ; Error
 set 7, (iy+127), e             ; Error
 set 7, (iy+127), h             ; Error
 set 7, (iy+127), l             ; Error
 set 7, (iy-128), a             ; Error
 set 7, (iy-128), b             ; Error
 set 7, (iy-128), c             ; Error
 set 7, (iy-128), d             ; Error
 set 7, (iy-128), e             ; Error
 set 7, (iy-128), h             ; Error
 set 7, (iy-128), l             ; Error
 set 8, (hl)                    ; Error
 set 8, (hl)                    ; Error
 set 8, (ix)                    ; Error
 set 8, (ix)                    ; Error
 set 8, (ix), a                 ; Error
 set 8, (ix), a                 ; Error
 set 8, (ix), b                 ; Error
 set 8, (ix), b                 ; Error
 set 8, (ix), c                 ; Error
 set 8, (ix), c                 ; Error
 set 8, (ix), d                 ; Error
 set 8, (ix), d                 ; Error
 set 8, (ix), e                 ; Error
 set 8, (ix), e                 ; Error
 set 8, (ix), h                 ; Error
 set 8, (ix), h                 ; Error
 set 8, (ix), l                 ; Error
 set 8, (ix), l                 ; Error
 set 8, (ix+127)                ; Error
 set 8, (ix+127)                ; Error
 set 8, (ix+127), a             ; Error
 set 8, (ix+127), a             ; Error
 set 8, (ix+127), b             ; Error
 set 8, (ix+127), b             ; Error
 set 8, (ix+127), c             ; Error
 set 8, (ix+127), c             ; Error
 set 8, (ix+127), d             ; Error
 set 8, (ix+127), d             ; Error
 set 8, (ix+127), e             ; Error
 set 8, (ix+127), e             ; Error
 set 8, (ix+127), h             ; Error
 set 8, (ix+127), h             ; Error
 set 8, (ix+127), l             ; Error
 set 8, (ix+127), l             ; Error
 set 8, (ix-128)                ; Error
 set 8, (ix-128)                ; Error
 set 8, (ix-128), a             ; Error
 set 8, (ix-128), a             ; Error
 set 8, (ix-128), b             ; Error
 set 8, (ix-128), b             ; Error
 set 8, (ix-128), c             ; Error
 set 8, (ix-128), c             ; Error
 set 8, (ix-128), d             ; Error
 set 8, (ix-128), d             ; Error
 set 8, (ix-128), e             ; Error
 set 8, (ix-128), e             ; Error
 set 8, (ix-128), h             ; Error
 set 8, (ix-128), h             ; Error
 set 8, (ix-128), l             ; Error
 set 8, (ix-128), l             ; Error
 set 8, (iy)                    ; Error
 set 8, (iy)                    ; Error
 set 8, (iy), a                 ; Error
 set 8, (iy), a                 ; Error
 set 8, (iy), b                 ; Error
 set 8, (iy), b                 ; Error
 set 8, (iy), c                 ; Error
 set 8, (iy), c                 ; Error
 set 8, (iy), d                 ; Error
 set 8, (iy), d                 ; Error
 set 8, (iy), e                 ; Error
 set 8, (iy), e                 ; Error
 set 8, (iy), h                 ; Error
 set 8, (iy), h                 ; Error
 set 8, (iy), l                 ; Error
 set 8, (iy), l                 ; Error
 set 8, (iy+127)                ; Error
 set 8, (iy+127)                ; Error
 set 8, (iy+127), a             ; Error
 set 8, (iy+127), a             ; Error
 set 8, (iy+127), b             ; Error
 set 8, (iy+127), b             ; Error
 set 8, (iy+127), c             ; Error
 set 8, (iy+127), c             ; Error
 set 8, (iy+127), d             ; Error
 set 8, (iy+127), d             ; Error
 set 8, (iy+127), e             ; Error
 set 8, (iy+127), e             ; Error
 set 8, (iy+127), h             ; Error
 set 8, (iy+127), h             ; Error
 set 8, (iy+127), l             ; Error
 set 8, (iy+127), l             ; Error
 set 8, (iy-128)                ; Error
 set 8, (iy-128)                ; Error
 set 8, (iy-128), a             ; Error
 set 8, (iy-128), a             ; Error
 set 8, (iy-128), b             ; Error
 set 8, (iy-128), b             ; Error
 set 8, (iy-128), c             ; Error
 set 8, (iy-128), c             ; Error
 set 8, (iy-128), d             ; Error
 set 8, (iy-128), d             ; Error
 set 8, (iy-128), e             ; Error
 set 8, (iy-128), e             ; Error
 set 8, (iy-128), h             ; Error
 set 8, (iy-128), h             ; Error
 set 8, (iy-128), l             ; Error
 set 8, (iy-128), l             ; Error
 set 8, a                       ; Error
 set 8, a                       ; Error
 set 8, a'                      ; Error
 set 8, a'                      ; Error
 set 8, b                       ; Error
 set 8, b                       ; Error
 set 8, b'                      ; Error
 set 8, b'                      ; Error
 set 8, c                       ; Error
 set 8, c                       ; Error
 set 8, c'                      ; Error
 set 8, c'                      ; Error
 set 8, d                       ; Error
 set 8, d                       ; Error
 set 8, d'                      ; Error
 set 8, d'                      ; Error
 set 8, e                       ; Error
 set 8, e                       ; Error
 set 8, e'                      ; Error
 set 8, e'                      ; Error
 set 8, h                       ; Error
 set 8, h                       ; Error
 set 8, h'                      ; Error
 set 8, h'                      ; Error
 set 8, l                       ; Error
 set 8, l                       ; Error
 set 8, l'                      ; Error
 set 8, l'                      ; Error
 set a, -1, (ix)                ; Error
 set a, -1, (ix)                ; Error
 set a, -1, (ix+127)            ; Error
 set a, -1, (ix+127)            ; Error
 set a, -1, (ix-128)            ; Error
 set a, -1, (ix-128)            ; Error
 set a, -1, (iy)                ; Error
 set a, -1, (iy)                ; Error
 set a, -1, (iy+127)            ; Error
 set a, -1, (iy+127)            ; Error
 set a, -1, (iy-128)            ; Error
 set a, -1, (iy-128)            ; Error
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
 set a, 8, (ix)                 ; Error
 set a, 8, (ix)                 ; Error
 set a, 8, (ix+127)             ; Error
 set a, 8, (ix+127)             ; Error
 set a, 8, (ix-128)             ; Error
 set a, 8, (ix-128)             ; Error
 set a, 8, (iy)                 ; Error
 set a, 8, (iy)                 ; Error
 set a, 8, (iy+127)             ; Error
 set a, 8, (iy+127)             ; Error
 set a, 8, (iy-128)             ; Error
 set a, 8, (iy-128)             ; Error
 set b, -1, (ix)                ; Error
 set b, -1, (ix)                ; Error
 set b, -1, (ix+127)            ; Error
 set b, -1, (ix+127)            ; Error
 set b, -1, (ix-128)            ; Error
 set b, -1, (ix-128)            ; Error
 set b, -1, (iy)                ; Error
 set b, -1, (iy)                ; Error
 set b, -1, (iy+127)            ; Error
 set b, -1, (iy+127)            ; Error
 set b, -1, (iy-128)            ; Error
 set b, -1, (iy-128)            ; Error
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
 set b, 8, (ix)                 ; Error
 set b, 8, (ix)                 ; Error
 set b, 8, (ix+127)             ; Error
 set b, 8, (ix+127)             ; Error
 set b, 8, (ix-128)             ; Error
 set b, 8, (ix-128)             ; Error
 set b, 8, (iy)                 ; Error
 set b, 8, (iy)                 ; Error
 set b, 8, (iy+127)             ; Error
 set b, 8, (iy+127)             ; Error
 set b, 8, (iy-128)             ; Error
 set b, 8, (iy-128)             ; Error
 set c, -1, (ix)                ; Error
 set c, -1, (ix)                ; Error
 set c, -1, (ix+127)            ; Error
 set c, -1, (ix+127)            ; Error
 set c, -1, (ix-128)            ; Error
 set c, -1, (ix-128)            ; Error
 set c, -1, (iy)                ; Error
 set c, -1, (iy)                ; Error
 set c, -1, (iy+127)            ; Error
 set c, -1, (iy+127)            ; Error
 set c, -1, (iy-128)            ; Error
 set c, -1, (iy-128)            ; Error
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
 set c, 8, (ix)                 ; Error
 set c, 8, (ix)                 ; Error
 set c, 8, (ix+127)             ; Error
 set c, 8, (ix+127)             ; Error
 set c, 8, (ix-128)             ; Error
 set c, 8, (ix-128)             ; Error
 set c, 8, (iy)                 ; Error
 set c, 8, (iy)                 ; Error
 set c, 8, (iy+127)             ; Error
 set c, 8, (iy+127)             ; Error
 set c, 8, (iy-128)             ; Error
 set c, 8, (iy-128)             ; Error
 set d, -1, (ix)                ; Error
 set d, -1, (ix)                ; Error
 set d, -1, (ix+127)            ; Error
 set d, -1, (ix+127)            ; Error
 set d, -1, (ix-128)            ; Error
 set d, -1, (ix-128)            ; Error
 set d, -1, (iy)                ; Error
 set d, -1, (iy)                ; Error
 set d, -1, (iy+127)            ; Error
 set d, -1, (iy+127)            ; Error
 set d, -1, (iy-128)            ; Error
 set d, -1, (iy-128)            ; Error
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
 set d, 8, (ix)                 ; Error
 set d, 8, (ix)                 ; Error
 set d, 8, (ix+127)             ; Error
 set d, 8, (ix+127)             ; Error
 set d, 8, (ix-128)             ; Error
 set d, 8, (ix-128)             ; Error
 set d, 8, (iy)                 ; Error
 set d, 8, (iy)                 ; Error
 set d, 8, (iy+127)             ; Error
 set d, 8, (iy+127)             ; Error
 set d, 8, (iy-128)             ; Error
 set d, 8, (iy-128)             ; Error
 set e, -1, (ix)                ; Error
 set e, -1, (ix)                ; Error
 set e, -1, (ix+127)            ; Error
 set e, -1, (ix+127)            ; Error
 set e, -1, (ix-128)            ; Error
 set e, -1, (ix-128)            ; Error
 set e, -1, (iy)                ; Error
 set e, -1, (iy)                ; Error
 set e, -1, (iy+127)            ; Error
 set e, -1, (iy+127)            ; Error
 set e, -1, (iy-128)            ; Error
 set e, -1, (iy-128)            ; Error
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
 set e, 8, (ix)                 ; Error
 set e, 8, (ix)                 ; Error
 set e, 8, (ix+127)             ; Error
 set e, 8, (ix+127)             ; Error
 set e, 8, (ix-128)             ; Error
 set e, 8, (ix-128)             ; Error
 set e, 8, (iy)                 ; Error
 set e, 8, (iy)                 ; Error
 set e, 8, (iy+127)             ; Error
 set e, 8, (iy+127)             ; Error
 set e, 8, (iy-128)             ; Error
 set e, 8, (iy-128)             ; Error
 set h, -1, (ix)                ; Error
 set h, -1, (ix)                ; Error
 set h, -1, (ix+127)            ; Error
 set h, -1, (ix+127)            ; Error
 set h, -1, (ix-128)            ; Error
 set h, -1, (ix-128)            ; Error
 set h, -1, (iy)                ; Error
 set h, -1, (iy)                ; Error
 set h, -1, (iy+127)            ; Error
 set h, -1, (iy+127)            ; Error
 set h, -1, (iy-128)            ; Error
 set h, -1, (iy-128)            ; Error
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
 set h, 8, (ix)                 ; Error
 set h, 8, (ix)                 ; Error
 set h, 8, (ix+127)             ; Error
 set h, 8, (ix+127)             ; Error
 set h, 8, (ix-128)             ; Error
 set h, 8, (ix-128)             ; Error
 set h, 8, (iy)                 ; Error
 set h, 8, (iy)                 ; Error
 set h, 8, (iy+127)             ; Error
 set h, 8, (iy+127)             ; Error
 set h, 8, (iy-128)             ; Error
 set h, 8, (iy-128)             ; Error
 set l, -1, (ix)                ; Error
 set l, -1, (ix)                ; Error
 set l, -1, (ix+127)            ; Error
 set l, -1, (ix+127)            ; Error
 set l, -1, (ix-128)            ; Error
 set l, -1, (ix-128)            ; Error
 set l, -1, (iy)                ; Error
 set l, -1, (iy)                ; Error
 set l, -1, (iy+127)            ; Error
 set l, -1, (iy+127)            ; Error
 set l, -1, (iy-128)            ; Error
 set l, -1, (iy-128)            ; Error
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
 set l, 8, (ix)                 ; Error
 set l, 8, (ix)                 ; Error
 set l, 8, (ix+127)             ; Error
 set l, 8, (ix+127)             ; Error
 set l, 8, (ix-128)             ; Error
 set l, 8, (ix-128)             ; Error
 set l, 8, (iy)                 ; Error
 set l, 8, (iy)                 ; Error
 set l, 8, (iy+127)             ; Error
 set l, 8, (iy+127)             ; Error
 set l, 8, (iy-128)             ; Error
 set l, 8, (iy-128)             ; Error
 set.a -1, (hl)                 ; Error
 set.a -1, (hl)                 ; Error
 set.a -1, (ix)                 ; Error
 set.a -1, (ix)                 ; Error
 set.a -1, (ix+127)             ; Error
 set.a -1, (ix+127)             ; Error
 set.a -1, (ix-128)             ; Error
 set.a -1, (ix-128)             ; Error
 set.a -1, (iy)                 ; Error
 set.a -1, (iy)                 ; Error
 set.a -1, (iy+127)             ; Error
 set.a -1, (iy+127)             ; Error
 set.a -1, (iy-128)             ; Error
 set.a -1, (iy-128)             ; Error
 set.a -1, a                    ; Error
 set.a -1, a                    ; Error
 set.a -1, b                    ; Error
 set.a -1, b                    ; Error
 set.a -1, c                    ; Error
 set.a -1, c                    ; Error
 set.a -1, d                    ; Error
 set.a -1, d                    ; Error
 set.a -1, e                    ; Error
 set.a -1, e                    ; Error
 set.a -1, h                    ; Error
 set.a -1, h                    ; Error
 set.a -1, l                    ; Error
 set.a -1, l                    ; Error
 set.a 8, (hl)                  ; Error
 set.a 8, (hl)                  ; Error
 set.a 8, (ix)                  ; Error
 set.a 8, (ix)                  ; Error
 set.a 8, (ix+127)              ; Error
 set.a 8, (ix+127)              ; Error
 set.a 8, (ix-128)              ; Error
 set.a 8, (ix-128)              ; Error
 set.a 8, (iy)                  ; Error
 set.a 8, (iy)                  ; Error
 set.a 8, (iy+127)              ; Error
 set.a 8, (iy+127)              ; Error
 set.a 8, (iy-128)              ; Error
 set.a 8, (iy-128)              ; Error
 set.a 8, a                     ; Error
 set.a 8, a                     ; Error
 set.a 8, b                     ; Error
 set.a 8, b                     ; Error
 set.a 8, c                     ; Error
 set.a 8, c                     ; Error
 set.a 8, d                     ; Error
 set.a 8, d                     ; Error
 set.a 8, e                     ; Error
 set.a 8, e                     ; Error
 set.a 8, h                     ; Error
 set.a 8, h                     ; Error
 set.a 8, l                     ; Error
 set.a 8, l                     ; Error
 setae                          ; Error
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
 sla (ix), a                    ; Error
 sla (ix), b                    ; Error
 sla (ix), c                    ; Error
 sla (ix), d                    ; Error
 sla (ix), e                    ; Error
 sla (ix), h                    ; Error
 sla (ix), l                    ; Error
 sla (ix+127), a                ; Error
 sla (ix+127), b                ; Error
 sla (ix+127), c                ; Error
 sla (ix+127), d                ; Error
 sla (ix+127), e                ; Error
 sla (ix+127), h                ; Error
 sla (ix+127), l                ; Error
 sla (ix-128), a                ; Error
 sla (ix-128), b                ; Error
 sla (ix-128), c                ; Error
 sla (ix-128), d                ; Error
 sla (ix-128), e                ; Error
 sla (ix-128), h                ; Error
 sla (ix-128), l                ; Error
 sla (iy), a                    ; Error
 sla (iy), b                    ; Error
 sla (iy), c                    ; Error
 sla (iy), d                    ; Error
 sla (iy), e                    ; Error
 sla (iy), h                    ; Error
 sla (iy), l                    ; Error
 sla (iy+127), a                ; Error
 sla (iy+127), b                ; Error
 sla (iy+127), c                ; Error
 sla (iy+127), d                ; Error
 sla (iy+127), e                ; Error
 sla (iy+127), h                ; Error
 sla (iy+127), l                ; Error
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
 sra (ix), a                    ; Error
 sra (ix), b                    ; Error
 sra (ix), c                    ; Error
 sra (ix), d                    ; Error
 sra (ix), e                    ; Error
 sra (ix), h                    ; Error
 sra (ix), l                    ; Error
 sra (ix+127), a                ; Error
 sra (ix+127), b                ; Error
 sra (ix+127), c                ; Error
 sra (ix+127), d                ; Error
 sra (ix+127), e                ; Error
 sra (ix+127), h                ; Error
 sra (ix+127), l                ; Error
 sra (ix-128), a                ; Error
 sra (ix-128), b                ; Error
 sra (ix-128), c                ; Error
 sra (ix-128), d                ; Error
 sra (ix-128), e                ; Error
 sra (ix-128), h                ; Error
 sra (ix-128), l                ; Error
 sra (iy), a                    ; Error
 sra (iy), b                    ; Error
 sra (iy), c                    ; Error
 sra (iy), d                    ; Error
 sra (iy), e                    ; Error
 sra (iy), h                    ; Error
 sra (iy), l                    ; Error
 sra (iy+127), a                ; Error
 sra (iy+127), b                ; Error
 sra (iy+127), c                ; Error
 sra (iy+127), d                ; Error
 sra (iy+127), e                ; Error
 sra (iy+127), h                ; Error
 sra (iy+127), l                ; Error
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
 srl (ix), a                    ; Error
 srl (ix), b                    ; Error
 srl (ix), c                    ; Error
 srl (ix), d                    ; Error
 srl (ix), e                    ; Error
 srl (ix), h                    ; Error
 srl (ix), l                    ; Error
 srl (ix+127), a                ; Error
 srl (ix+127), b                ; Error
 srl (ix+127), c                ; Error
 srl (ix+127), d                ; Error
 srl (ix+127), e                ; Error
 srl (ix+127), h                ; Error
 srl (ix+127), l                ; Error
 srl (ix-128), a                ; Error
 srl (ix-128), b                ; Error
 srl (ix-128), c                ; Error
 srl (ix-128), d                ; Error
 srl (ix-128), e                ; Error
 srl (ix-128), h                ; Error
 srl (ix-128), l                ; Error
 srl (iy), a                    ; Error
 srl (iy), b                    ; Error
 srl (iy), c                    ; Error
 srl (iy), d                    ; Error
 srl (iy), e                    ; Error
 srl (iy), h                    ; Error
 srl (iy), l                    ; Error
 srl (iy+127), a                ; Error
 srl (iy+127), b                ; Error
 srl (iy+127), c                ; Error
 srl (iy+127), d                ; Error
 srl (iy+127), e                ; Error
 srl (iy+127), h                ; Error
 srl (iy+127), l                ; Error
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
 stop                           ; Error
 sub a, ixh                     ; Error
 sub a, ixl                     ; Error
 sub a, iyh                     ; Error
 sub a, iyl                     ; Error
 sub ixh                        ; Error
 sub ixl                        ; Error
 sub iyh                        ; Error
 sub iyl                        ; Error
 swap (hl)                      ; Error
 swap a                         ; Error
 swap b                         ; Error
 swap c                         ; Error
 swap d                         ; Error
 swap e                         ; Error
 swap h                         ; Error
 swap l                         ; Error
 swapnib                        ; Error
 test (hl)                      ; Error
 test (ix)                      ; Error
 test (ix+127)                  ; Error
 test (ix-128)                  ; Error
 test (iy)                      ; Error
 test (iy+127)                  ; Error
 test (iy-128)                  ; Error
 test -128                      ; Error
 test 127                       ; Error
 test 255                       ; Error
 test a                         ; Error
 test a, (hl)                   ; Error
 test a, (ix)                   ; Error
 test a, (ix+127)               ; Error
 test a, (ix-128)               ; Error
 test a, (iy)                   ; Error
 test a, (iy+127)               ; Error
 test a, (iy-128)               ; Error
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
 tst (ix)                       ; Error
 tst (ix+127)                   ; Error
 tst (ix-128)                   ; Error
 tst (iy)                       ; Error
 tst (iy+127)                   ; Error
 tst (iy-128)                   ; Error
 tst -128                       ; Error
 tst 127                        ; Error
 tst 255                        ; Error
 tst a                          ; Error
 tst a, (hl)                    ; Error
 tst a, (ix)                    ; Error
 tst a, (ix+127)                ; Error
 tst a, (ix-128)                ; Error
 tst a, (iy)                    ; Error
 tst a, (iy+127)                ; Error
 tst a, (iy-128)                ; Error
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
 xor a, ixh                     ; Error
 xor a, ixl                     ; Error
 xor a, iyh                     ; Error
 xor a, iyl                     ; Error
 xor ixh                        ; Error
 xor ixl                        ; Error
 xor iyh                        ; Error
 xor iyl                        ; Error
 xthl                           ; Error
