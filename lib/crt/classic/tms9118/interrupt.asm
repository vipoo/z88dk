	EXTERN	VDP_STATUS

tms9118_interrupt:
	push	af
	push	hl
	ld	a, +(VDP_STATUS / 256)
	and	a
	jr	z,read_port
	ld	a,(VDP_STATUS)
	jr	done_read
read_port:
	in	a,(VDP_STATUS % 256)
done_read:
	or	a
	jp	p,int_not_VBL
	jr	int_VBL

int_not_VBL:
	pop	hl
	pop	af
	ei
	reti

int_VBL:
        ld      hl, timer
        ld      a, (hl)
        inc     a
        ld      (hl), a
        inc     hl
        ld      a, (hl)
        adc     a, 1
        ld      (hl), a         ;Increments the timer

        ld      hl, raster_procs
        call    int_handler
        pop     hl
	pop	af
	ei
        reti

