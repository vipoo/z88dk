;; Optimised Drawing library 
;; By Jon Fuge (jonny@q-continuum.demon.co.uk) based on original file
;; Updates
;;   990223 Michael	Removed mod_col, splitting it up into 
;;			fg_colour, bg_colour, and draw_mode
;; Note: some optimisations are available with unneded PUSH DE/POP DE's

	;; BANKED: checked

        INCLUDE "target/gb/def/gb_globals.def"

	PUBLIC	gmode

	GLOBAL  init_vram
	GLOBAL  copy_vram
	GLOBAL	__mode
	GLOBAL display_off
	GLOBAL	add_VBL
	GLOBAL	add_LCD
	GLOBAL	lcd
	GLOBAL	y_table

	defc M_SOLID	=	0x00
	defc M_OR	=	0x01
	defc M_XOR	=	0x02
	defc M_AND	=	0x03

	if	0
	defc M_SOLID	=	0x10
	defc M_OR	=	0x20
	defc M_XOR	=	0x40
	defc M_AND	=	0x80
	endif

	;;  Format of mod_col
	;; 7 6 5 4 3 2 1 0
	;;   mode  fg  bg



	;; Data
	SECTION	bss_driver
	GLOBAL	fg_colour
	GLOBAL	bg_colour
	;; Drawing mode (SOILD etc)
draw_mode:
	defs	1
	;; Fill style
style:	
	defs	0x01
	;; Various varibles
x_s:	
	defs	2
y_s:	
	defs	2
delta_x:	
	defs	1
delta_y:	
	defs	1
l_inc:	
	defs	1
l_d:	
	defs	2
dinc1:	
	defs	2
dinc2:	
	defs	2
	

	SECTION	code_driver
	;; Enter graphic mode
gmode:
	DI			; Disable interrupts

	;; Turn the screen off
	LDH	A,(LCDC)
	BIT	7,A
	JR	Z,gmode_1

	;; Turn the screen off
	CALL	display_off
gmode_1:
	LD	HL,0x8000+0x10*0x10
	LD	DE,0x1800-0x18*0x10
	LD	B,0x00
	CALL	init_vram	; Init the charset at 0x8000

	;; Install interrupt routines
	LD	BC,vbl
	CALL	add_VBL
	LD	BC,lcd
	CALL	add_LCD

	LD	A,72		; Set line at which LCD interrupt occurs
	LDH	(LYC),A

	LD	A,@01000100	; Set LCD interrupt to occur when LY = LCY
	LDH	(STAT),A

	LDH	A,(IE)
	OR	@00000010	; Enable LCD interrupt
	LDH	(IE),A

	;; (9*20) = 180 tiles are used in the upper part of the screen
	;; (9*20) = 180 tiles are used in the lower part of the screen
	;; => We have 24 tiles free
	;; We keep 16 at 0x8000->0x80FF, and 8 at 0x9780->97FF

	LD	HL,0x9800
	LD	A,0x10		; Keep 16 tiles free
	LD	BC,12		; 12 unused columns
	LD	E,18		; 18 lines
gmode_2:
	LD	D,20		; 20 used columns
gmode_3:
	LD	(HL+),A
	INC	A
	DEC	D
	JR	NZ,gmode_3
	ADD	HL,BC
	DEC	E
	JR	NZ,gmode_2

	;; Turn the screen on
	LDH	A,(LCDC)
	OR	@10010001	; LCD		= On
				; BG Chr	= 0x8000
				; BG		= On
	AND	@11110111	; BG Bank	= 0x9800
	LDH	(LCDC),A

	LD	A,G_MODE
	LD	(__mode),A

	;; Setup the default colours and draw modes
	LD	A,M_SOLID
	LD	(draw_mode),A
	LD	A,0x03		; Black
	LD	(fg_colour),A
	LD	A,0x00		; White
	LD	(bg_colour),A
	
	EI			; Enable interrupts

	RET

vbl:
	LDH	A,(LCDC)
	OR	@00010000	; Set BG Chr to 0x8000
	LDH	(LCDC),A

	LD	A,72		; Set line at which LCD interrupt occurs
	LDH	(LYC),A

	RET




	;; Draw a circle from (B,C) with radius D
__circle:
	LD	A,B	;Store center values
	LD	(x_s),A
	LD	A,C
	LD	(y_s),A

	XOR	A
	LD	(x_s+1),A 
	LD	A,D
	LD	(y_s+1),A 
	CPL
	LD	L,A
	LD	H,0xFF
	INC	HL
	LD	BC,0
	ADD	HL,BC
	LD	A,L
	LD	(l_d+1),A
	LD	A,H
	LD	(l_d),A

cloop:
	LD	A,(x_s+1)
	LD	B,A
	LD	A,(y_s+1)
	SUB	B
	RET	C

	LD	A,(style)
	OR	A
	CALL	Z,__circplot

	LD	A,(l_d)
	BIT	7,A
	JR	Z,ycirc

	LD	A,(style)
	OR	A
	CALL	NZ,horlin
	LD	A,(x_s+1)
	INC	A
	LD	(x_s+1),A
	LD	A,(l_d)
	LD	B,A
	LD	A,(l_d+1)
	LD	C,A
	LD	H,0
	LD	A,(x_s+1)
	LD	L,A
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,BC
	LD	BC,6
	ADD	HL,BC
	LD	A,H
	LD	(l_d),A
	LD	A,L
	LD	(l_d+1),A
	JR	cloop
ycirc:	
	LD	A,(style)
	OR	A
	CALL	NZ,verlin
	LD	A,(x_s+1)
	INC	A
	LD	(x_s+1),A
	LD	B,0
	LD	A,(x_s+1)
	LD	C,A
	LD	H,0xFF
	LD	A,(y_s+1)
	CPL
	LD	L,A
	INC	HL
	ADD	HL,BC
	LD	A,(l_d)
	LD	B,A
	LD	A,(l_d+1)
	LD	C,A
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,BC
	LD	BC,10
	ADD	HL,BC
	LD	A,H
	LD	(l_d),A
	LD	A,L
	LD	(l_d+1),A
	LD	A,(y_s+1)
	DEC	A
	LD	(y_s+1),A
	JP	cloop

horlin:
	LD	A,(x_s)
	LD	B,A
	LD	A,(y_s)
	LD	C,A
	LD	A,(x_s+1)
	LD	D,A
	LD	A,(y_s+1)
	LD	E,A
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	E
	LD	H,A
	LD	A,B
	ADD	E
	LD	B,A
	LD	A,C
	ADD	D
	LD	C,A
	LD	D,H
	LD	E,C
	CALL	line
	POP	DE
	POP	BC
	LD	A,D
	OR	A
	RET	Z
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	E
	LD	H,A
	LD	A,B
	ADD	E
	LD	B,A
	LD	A,C
	SUB	D
	LD	C,A
	LD	D,H
	LD	E,C
	CALL	line
	POP	DE
	POP	BC
	RET

verlin:
	LD	A,(x_s)
	LD	B,A
	LD	A,(y_s)
	LD	C,A
	LD	A,(x_s+1)
	LD	D,A
	LD	A,(y_s+1)
	LD	E,A
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	E
	LD	H,A
	LD	A,B
	ADD	E
	LD	B,A
	LD	A,C
	ADD	D
	LD	C,A
	LD	D,H
	LD	E,C
	CALL	line
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	E
	LD	H,A
	LD	A,B
	ADD	E
	LD	B,A
	LD	A,C
	SUB	D
	LD	C,A
	LD	D,H
	LD	E,C
	CALL	line
	POP	DE
	POP	BC
	LD	A,D
	SUB	E
	RET	Z
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	D
	LD	H,A
	LD	A,B
	ADD	D
	LD	B,A
	LD	A,C
	SUB	E
	LD	C,A
	LD	D,H
	LD	E,C
	CALL	line
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	D
	LD	H,A
	LD	A,B
	ADD	D
	LD	B,A
	LD	A,C
	ADD	E
	LD	C,A
	LD	D,H
	LD	E,C
	CALL	line
	POP	DE
	POP	BC
	RET

__circplot:
	LD	A,(x_s)
	LD	B,A
	LD	A,(y_s)
	LD	C,A
	LD	A,(x_s+1)
	LD	D,A
	LD	A,(y_s+1)
	LD	E,A
	PUSH	BC
	PUSH	DE
	LD	A,B
	ADD	D
	LD	B,A
	LD	A,C
	SUB	E
	LD	C,A
	CALL	plot
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	E
	LD	B,A
	LD	A,C
	SUB	D
	LD	C,A
	CALL	plot
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	D
	LD	B,A
	LD	A,C
	ADD	E
	LD	C,A
	CALL	plot
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,B
	ADD	E
	LD	B,A
	LD	A,C
	ADD	D
	LD	C,A
	CALL	plot
	POP	DE
	POP	BC
	
	LD	A,D
	OR	A
	RET	Z
	SUB	E
	RET	Z

	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	D
	LD	B,A
	LD	A,C
	SUB	E
	LD	C,A
	CALL	plot
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,B
	SUB	E
	LD	B,A
	LD	A,C
	ADD	D
	LD	C,A
	CALL	plot
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,B
	ADD	D
	LD	B,A
	LD	A,C
	ADD	E
	LD	C,A
	CALL	plot
	POP	DE
	POP	BC
	PUSH	BC
	PUSH	DE
	LD	A,B
	ADD	E
	LD	B,A
	LD	A,C
	SUB	D
	LD	C,A
	CALL	plot
	POP	DE
	POP	BC
	RET

	;; Draw a box between (B,C) and (D,E)
__box:
	LD	A,(x_s)
	LD	B,A
	LD	A,(x_s+1)
	LD	C,A
	SUB	B
	JR	NC,ychk
	LD	A,C
	LD	(x_s),A
	LD	A,B
	LD	(x_s+1),A
ychk:
	LD	A,(y_s)
	LD	B,A
	LD	A,(y_s+1)
	LD	C,A
	SUB	B
	JR	NC,dbox
	LD	A,C
	LD	(y_s),A
	LD	A,B
	LD	(y_s+1),A
dbox:
	LD	A,(x_s)
	LD	B,A
	LD	D,A
	LD	A,(y_s)
	LD	C,A
	LD	A,(y_s+1)
	LD	E,A
	CALL	line
	LD	A,(x_s+1)
	LD	B,A
	LD	D,A
	LD	A,(y_s)
	LD	C,A
	LD	A,(y_s+1)
	LD	E,A
	CALL	line
	LD	A,(x_s)
	INC	A
	LD	(x_s),A
	LD	A,(x_s+1)
	DEC	A
	LD	(x_s+1),A
	LD	A,(x_s)
	LD	B,A
	LD	A,(x_s+1)
	LD	D,A
	LD	A,(y_s)
	LD	C,A
	LD	E,A
	CALL	line
	LD	A,(x_s)
	LD	B,A
	LD	A,(x_s+1)
	LD	D,A
	LD	A,(y_s+1)
	LD	C,A
	LD	E,A
	CALL	line
	LD	A,(style)
	OR	A
	RET	Z
	LD	A,(x_s)
	LD	B,A
	LD	A,(x_s+1)
	SUB	B
	RET	C
	LD	A,(y_s)
	INC	A
	LD	(y_s),A
	LD	A,(y_s+1)
	DEC	A
	LD	(y_s+1),A
	LD	A,(y_s)
	LD	B,A
	LD	A,(y_s+1)
	SUB	B
	RET	C

	if	0
	LD	A,(mod_col)	;Swap fore + back colours.
	LD	D,A
	AND	0xF0
	LD	C,A		;Preserve Style
	LD	A,D
	AND	0x0C
	RRCA
	RRCA
	OR	C		;Foreground->background + style
	LD	C,A
	LD	A,D
	AND	0x03
	RLCA
	RLCA
	OR	C
	LD	(mod_col),A
	else
	LD	A,(fg_colour)
	LD	C,A
	LD	A,(bg_colour)
	LD	(fg_colour),A
	LD	A,C
	LD	(bg_colour),A
	endif 
filllp:
	LD	A,(x_s)
	LD	B,A
	LD	A,(x_s+1)
	LD	D,A
	LD	A,(y_s)
	LD	C,A
	LD	E,A
	CALL	line
	LD	A,(y_s+1)
	LD	B,A
	LD	A,(y_s)
	CP	B
	JR	Z,swap
	INC	A
	LD	(y_s),A
	JR	filllp
swap:	
	if	0
	LD	A,(mod_col)	;Swap fore + back colours.
	LD	D,A
	AND	0xF0
	LD	C,A		;Preserve Style
	LD	A,D
	AND	0x0C
	RRCA
	RRCA
	OR	C		;Foreground->background + style
	LD	C,A
	LD	A,D
	AND	0x03
	RLCA
	RLCA
	OR	C
	LD	(mod_col),A
	else
	LD	A,(fg_colour)
	LD	C,A
	LD	A,(bg_colour)
	LD	(fg_colour),A
	LD	A,C
	LD	(bg_colour),A
	endif
	RET

	;; Draw a line between (B,C) and (D,E)
__line:
	LD	A,C	;Calculate Delta Y
	SUB	E
	JR	NC,s1
	CPL
	INC	A
s1:	LD	(delta_y),A
	LD	H,A

	LD	A,B	;Calculate Delta X
	SUB	D
	JR	NC,s2
	CPL
	INC	A
s2:	LD	(delta_x),A

	SUB	H
	JP	C,y1

	;; Use Delta X

	LD	A,B
	SUB	D
	JP	NC,x2

	LD	A,C
	SUB	E
	JR	Z,x3
	LD	A,0x00
	JR	NC,x3
	LD	A,0xFF
	JR	x3

x2:
	LD	A,E
	SUB	C
	JR	Z,x2a
	LD	A,0x00
	JR	NC,x2a
	LD	A,0xFF

x2a:
	LD	B,D
	LD	C,E	;BC holds start X,Y
x3:
	LD	(l_inc),A	;Store Y increment
	LD	HL,y_table
	LD	D,0x00
	LD	E,C
	ADD	HL,DE
	ADD	HL,DE
	LD	A,(HL+)
	LD	H,(HL)
	LD	L,A

	LD	A,B
	AND	0xf8
	LD	E,A
	ADD	HL,DE
	ADD	HL,DE

	LD	A,(delta_y)
	OR	A
	JP	Z,xonly

	;;	Got to do it the hard way.

	;	Calculate (2*deltay) -> dinc1

	PUSH	HL
	LD	H,0x00
	LD	L,A
	ADD	HL,HL
	LD	A,H
	LD	(dinc1),A
	LD	A,L
	LD	(dinc1+1),A

	;	Calculate (2*deltay)-deltax -> d


	LD	D,H
	LD	E,L
	LD	A,(delta_x)
	CPL
	LD	L,A
	LD	H,0xFF
	INC	HL
dx1:
	ADD	HL,DE
	LD	A,H
	LD	(l_d),A
	LD	A,L
	LD	(l_d+1),A

	;	Calculate (deltay-deltax)*2 -> dinc2

	LD	A,(delta_x)
	CPL
	LD	L,A
	LD	H,0xFF
	INC	HL
	LD	A,(delta_y)
	LD	D,0x00
	LD	E,A
	ADD	HL,DE
	ADD	HL,HL

	LD	A,H
	LD	(dinc2),A
	LD	A,L
	LD	(dinc2+1),A

	POP	HL

	if	0
	LD	A,(mod_col)
	LD	D,A
	endif
	
	LD	A,(delta_x)
	LD	E,A

	LD	A,B
	AND	7
	ADD	0x10	; Table of bits is located at 0x0010
	LD	C,A
	LD	B,0x00
	LD	A,(BC)	; Get start bit
	LD	B,A
	LD	C,A

xloop:
	RRC	C
	LD	A,(l_d)
	BIT	7,A
	JR	Z,ychg
	PUSH	DE
	BIT	7,C
	JR	Z,nbit
	LD	A,B
	CPL
	LD	C,A
	CALL	wrbyte
	DEC	HL
	LD	C,0x80
	LD	B,C
nbit:
	LD	A,(l_d+1)
	LD	D,A
	LD	A,(dinc1+1)
	ADD	D
	LD	(l_d+1),A
	LD	A,(l_d)
	LD	D,A
	LD	A,(dinc1)
	ADC	D
	LD	(l_d),A
	POP	DE
	JR	nchg
ychg:
	PUSH	DE
	PUSH	BC
	LD	A,B
	CPL
	LD	C,A
	CALL	wrbyte
	LD	A,(l_inc)
	OR	A
	JR	Z,ydown
	INC	HL
	LD	A,L
	AND	0x0F
	JR	NZ,bound
	LD	DE,0x0130
	ADD	HL,DE	;Correct screen address
	JR	bound
ydown:
	DEC	HL
	DEC	HL
	DEC	HL
	LD	A,L
	AND	0x0F
	XOR	0x0E
	JR	NZ,bound
	LD	DE,0xFED0
	ADD	HL,DE	;Correct screen address
bound:
	LD	A,(l_d+1)
	LD	D,A
	LD	A,(dinc2+1)
	ADD	D
	LD	(l_d+1),A
	LD	A,(l_d)
	LD	D,A
	LD	A,(dinc2)
	ADC	D
	LD	(l_d),A
	POP	BC
	LD	B,C
	POP	DE
nchg:
	BIT	7,C
	JR	Z,nadj
	PUSH	DE
	LD	DE,0x0010
	ADD	HL,DE	;Correct screen address
	POP	DE
	LD	B,C
nadj:
	LD	A,B
	OR	C
	LD	B,A
	DEC	E
	JP	NZ,xloop
	LD	A,B
	CPL
	LD	C,A
	JP	wrbyte

xonly:
	;; Draw accelerated horizontal line
	if	0
	;; xxx needed?
	LD	A,(mod_col)	
	LD	D,A
	endif

	LD	A,(delta_x)
	LD	E,A
	INC	E

	LD	A,B	;check X
	AND	7	;just look at bottom 3 bits
	JR	Z,xonly_2
	PUSH	HL
	ADD	0x10	;Table of bits is located at 0x0010
	LD	L,A
	LD	H,0x00
	LD	C,(HL)
	POP	HL
	XOR	A	;Clear A
xonly_1:	RRCA		;Shift data right 1
	OR	C
	DEC	E
	JR	Z,xonly_3
	BIT	0,A
	JR	Z,xonly_1
	JR	xonly_3
xonly_2:
	LD	A,E
	DEC	A
	AND	0xF8
	JR	Z,xonly_4
	JR	xonly_8
xonly_3:
	LD	B,A
	CPL
	LD	C,A
	PUSH	DE
	CALL	wrbyte
	LD	DE,0x0F
	ADD	HL,DE	;Correct screen address
	POP	DE

xonly_8:	LD	A,E
	OR	A
	RET	Z
	AND	0xF8
	JR	Z,xonly_4

	XOR	A
	LD	C,A
	CPL
	LD	B,A

	PUSH	DE
	CALL	wrbyte
	LD	DE,0x0F
	ADD	HL,DE	;Correct screen address
	POP	DE
	LD	A,E
	SUB	8
	RET	Z
	LD	E,A
	JR	xonly_8

xonly_4:	LD	A,0x80
xonly_5:	DEC	E
	JR	Z,xonly_6
	SRA	A
	JR	xonly_5
xonly_6:	LD	B,A
	CPL
	LD	C,A
	JP	wrbyte

	;; Use Delta Y
y1:
	LD	A,C
	SUB	E
	JP	NC,y2

	LD	A,B
	SUB	D
	JR	Z,y3
	LD	A,0x00
	JR	NC,y3
	LD	A,0xFF
	JR	y3

y2:
	LD	A,C
	SUB	E
	JR	Z,y2a
	LD	A,0x00
	JR	NC,y2a
	LD	A,0xFF

y2a:
	LD	B,D
	LD	C,E	;BC holds start X,Y

y3:
	LD	(l_inc),A	;Store X increment
	LD	HL,y_table
	LD	D,0x00
	LD	E,C
	ADD	HL,DE
	ADD	HL,DE
	LD	A,(HL+)
	LD	H,(HL)
	LD	L,A

	LD	A,B
	AND	0xf8
	LD	E,A
	ADD	HL,DE
	ADD	HL,DE

	if	0
	;; Trashed by later instructions
	LD	A,(mod_col)
	LD	D,A
	endif
	
	LD	A,(delta_y)
	LD	E,A
	INC	E

	LD	A,(delta_x)
	OR	A
	JP	Z,yonly

	;;	Got to do it the hard way.

	;	Calculate (2*deltax) -> dinc1

	PUSH	HL
	LD	H,0x00
	LD	L,A
	ADD	HL,HL
	LD	A,H
	LD	(dinc1),A
	LD	A,L
	LD	(dinc1+1),A

	;	Calculate (2*deltax)-deltay -> d


	LD	D,H
	LD	E,L
	LD	A,(delta_y)
	CPL
	LD	L,A
	LD	H,0xFF
	INC	HL
dy1:
	ADD	HL,DE
	LD	A,H
	LD	(l_d),A
	LD	A,L
	LD	(l_d+1),A

	;	Calculate (deltax-deltay)*2 -> dinc2

	LD	A,(delta_y)
	CPL
	LD	L,A
	LD	H,0xFF
	INC	HL
	LD	A,(delta_x)
	LD	D,0x00
	LD	E,A
	ADD	HL,DE
	ADD	HL,HL

	LD	A,H
	LD	(dinc2),A
	LD	A,L
	LD	(dinc2+1),A

	POP	HL

	if	0
	;; xxx Not used?
	LD	A,(mod_col)
	LD	D,A
	endif

	LD	A,(delta_y)
	LD	E,A

	LD	A,B
	AND	7
	ADD	0x10	; Table of bits is located at 0x0010
	LD	C,A
	LD	B,0x00
	LD	A,(BC)	; Get start bit
	LD	B,A
	LD	C,A

yloop:
	PUSH	DE
	PUSH	BC
	LD	A,B
	CPL
	LD	C,A
	CALL	wrbyte
	INC	HL
	LD	A,L
	AND	0x0F
	JR	NZ,nybound
	LD	DE,0x0130
	ADD	HL,DE	;Correct screen address
nybound:
	POP	BC
	LD	A,(l_d)
	BIT	7,A
	JR	Z,xchg
	LD	A,(l_d+1)
	LD	D,A
	LD	A,(dinc1+1)
	ADD	D
	LD	(l_d+1),A
	LD	A,(l_d)
	LD	D,A
	LD	A,(dinc1)
	ADC	D
	LD	(l_d),A
	JR	nchgy
xchg:
	LD	A,(l_inc)
	OR	A
	JR	NZ,yright
	RLC	B
	BIT	0,B
	JR	Z,boundy
	LD	DE,0xFFF0
	ADD	HL,DE	;Correct screen address
	JR	boundy
yright:
	RRC	B
	BIT	7,B
	JR	Z,boundy
	LD	DE,0x0010
	ADD	HL,DE	;Correct screen address
boundy:
	LD	A,(l_d+1)
	LD	D,A
	LD	A,(dinc2+1)
	ADD	D
	LD	(l_d+1),A
	LD	A,(l_d)
	LD	D,A
	LD	A,(dinc2)
	ADC	D
	LD	(l_d),A
nchgy:
	POP	DE
	DEC	E
	JR	NZ,yloop
	LD	A,B
	CPL
	LD	C,A
	JP	wrbyte

yonly:
	;; Draw accelerated vertical line
	LD	A,B	;check X
	AND	7	;just look at bottom 3 bits
	PUSH	HL
	ADD	0x10	;Table of bits is located at 0x0010
	LD	L,A
	LD	H,0x00
	LD	A,(HL)	;Get mask bit
	POP	HL
	LD	B,A
	CPL
	LD	C,A

yonly_1:	PUSH	DE
	CALL	wrbyte
	INC	HL	;Correct screen address
	LD	A,L
	AND	0x0F
	JR	NZ,yonly_2
	LD	DE,0x0130
	ADD	HL,DE
yonly_2:	POP	DE
	DEC	E
	RET	Z
	JR	yonly_1

	;; Draw a point at (B,C) with mode and color D
__plot:
	LD	HL,y_table
	LD	D,0x00
	LD	E,C
	ADD	HL,DE
	ADD	HL,DE
	LD	A,(HL+)
	LD	H,(HL)
	LD	L,A

	LD	A,B
	AND	0xf8
	LD	E,A
	ADD	HL,DE
	ADD	HL,DE

	LD	A,B

	AND     7
	ADD     0x10		; Table of bits is located at 0x0010
	LD      C,A
	LD      B,0x00
	LD      A,(BC)
	LD      B,A
	CPL
	LD      C,A

wrbyte:
	if	0
	LD	A,(mod_col)	; Restore color and mode
	LD	D,A

	BIT	5,D
	JR	NZ,wrbyte_10
	BIT	6,D
	JR	NZ,wrbyte_20
	BIT	7,D
	JR	NZ,wrbyte_30
	else
	LD	A,(fg_colour)
	LD	D,A
	LD	A,(draw_mode)
	CP	M_OR
	JR	Z,wrbyte_10
	CP	M_XOR
	JR	Z,wrbyte_20
	CP	M_AND
	JR	Z,wrbyte_30	
	endif

	; Fall through to SOLID by default
wrbyte_1:
	;; Solid
	LD	E,B
	if	0
	BIT	2,D
	else
	BIT	0,D
	endif
	JR	NZ,wrbyte_2
	PUSH	BC
	LD	B,0x00
wrbyte_2:
	if	0
	BIT	3,D
	else
	BIT	1,D
	endif
	JR	NZ,wrbyte_3
	LD	E,0x00
wrbyte_3:
	LDH	A,(STAT)
	BIT	1,A
	JR	NZ,wrbyte_3

	LD	A,(HL)
	AND	C
	OR	B
	LD	(HL+),A

	LD	A,(HL)
	AND	C
	OR	E
	LD	(HL),A
	LD	A,B
	OR	A
	RET	NZ
	POP	BC
	RET

wrbyte_10:
	;; Or
	LD      C,B
	if	0
	BIT     2,D
	else
	BIT	0,D
	endif
	JR      NZ,wrbyte_11
	LD      B,0x00
wrbyte_11:
	if	0
	BIT     3,D
	else
	BIT	1,D
	endif
	JR      NZ,wrbyte_12
	LD      C,0x00
wrbyte_12:
	LDH     A,(STAT)
	BIT     1,A
	JR      NZ,wrbyte_12

	LD      A,(HL)
	OR      B
	LD      (HL+),A

	LD      A,(HL)
	OR      C
	LD      (HL),A
	RET

wrbyte_20:
	;; Xor
	LD      C,B
	if	0
	BIT     2,D
	else
	BIT	0,D
	endif
	JR      NZ,wrbyte_21
	LD      B,0x00
wrbyte_21:
	if	0
	BIT     3,D
	else
	BIT	1,D
	endif
	JR      NZ,wrbyte_22
	LD      C,0x00
wrbyte_22:
	LDH     A,(STAT)
	BIT     1,A
	JR      NZ,wrbyte_22

	LD      A,(HL)
	XOR     B
	LD      (HL+),A

	LD      A,(HL)
	XOR     C
	LD      (HL),A
	RET

wrbyte_30:
	;; And
	LD      B,C
	if	0
	BIT     2,D
	else
	BIT	0,D
	endif
	JR      Z,wrbyte_31
	LD      B,0xFF
wrbyte_31:
	if	0
	BIT     3,D
	else
	BIT	1,D
	endif
	JR      Z,wrbyte_32
	LD      C,0xFF
wrbyte_32:
	LDH     A,(STAT)
	BIT     1,A
	JR      NZ,wrbyte_32

	LD      A,(HL)
	AND     B
	LD      (HL+),A

	LD      A,(HL)
	AND     C
	LD      (HL),A
	RET

	;; Get color of pixel at point (B,C) returns in A
__getpix:
	LD	HL,y_table
	LD	D,0x00
	LD	E,C
	ADD	HL,DE
	ADD	HL,DE
	LD	A,(HL+)
	LD	H,(HL)
	LD	L,A

	LD	A,B
	AND	0xf8
	LD	E,A
	ADD	HL,DE
	ADD	HL,DE

	LD	A,B

	AND     7
	ADD     0x10		; Table of bits is located at 0x0010
	LD      C,A
	LD      B,0x00
	LD      A,(BC)
	LD      C,A

gp:
	LDH	A,(STAT)
	BIT	1,A
	JR	NZ,gp

	LD	A,(HL+)
	LD	D,A
	LD	A,(HL+)
	LD	E,A
	LD	B,0
	LD	A,D
	AND	C
	JR	Z,npix
	SET	0,B
npix:	LD	A,E
	AND	C
	JR	Z,end
	SET	1,B
end:	LD	E,B
	RET




; uint8_t __LIB__ getpix(uint8_t x, uint8_t y) __smallc;
getpix:
_getpix:			; Banked
	PUSH    BC

	LD 	HL,sp+6
	LD	B,(HL)	; B = x
	ld	hl,sp+4
	LD	C,(HL)	; C = y

	CALL	__getpix

	POP	BC
	RET

;void __LIB__ color(uint8_t forecolor, uint8_t backcolor, uint8_t mode) __smallc;
color:
_color:			; Banked
	ld	hl,sp+6
	LD	A,(HL)	; A = Foreground
	LD	(fg_colour),a
	ld	hl,sp+4
	LD	A,(HL)
	LD	(bg_colour),a
	ld	hl,sp+2
	LD	A,(HL)
	LD	(draw_mode),a
	RET

; void __LIB__    circle(uint8_t x, uint8_t y, uint8_t radius, uint8_t style) __smallc;
circle:
_circle:			; Banked
	PUSH    BC

	LD	A,(__mode)
	CP	G_MODE
	CALL	NZ,gmode

	ld	hl,sp+10
	LD	B,(HL)	; B = x
	ld	hl,sp+8
	LD	C,(HL)	; C = y
	ld	hl,sp+6
	LD	D,(HL)	; D = Radius
	ld	hl,sp+4
	LD	A,(HL)
	LD	(style),A

	CALL	__circle

	POP	BC
	RET

; void __LIB__ box(uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2, uint8_t style) __smallc;
box:
_box:				; Banked
	PUSH    BC

	LD      A,(__mode)
	CP      G_MODE
	CALL	NZ,gmode

	LD 	HL,sp+12        	; Skip return address and registers
	LD	A,(HL)	; B = x1
	LD	(x_s),A
	ld	hl,sp+10
	LD	A,(HL)	; C = y1
	LD	(y_s),A
	ld	hl,sp+8
	LD	A,(HL)	; D = x2
	LD	(x_s+1),A
	ld	hl,sp+6
	LD	A,(HL)	; E = y2
	LD	(y_s+1),A
	ld	hl,sp+4
	LD	A,(HL)
	LD	(style),A
	CALL	__box
	POP	BC
	RET

; void __LIB__ line(uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2) __smallc;
_line:				; Banked
line:				; Banked
	PUSH    BC

	LD      A,(__mode)
	CP      G_MODE
	CALL	NZ,gmode

	LD 	HL,sp+10		; Skip return address and registers
	LD	B,(HL)	; B = x1
	ld	hl,sp+8
	LD	C,(HL)	; C = y1
	ld	hl,sp+6
	LD	D,(HL)	; D = x2
	ld	hl,sp+4
	LD	E,(HL)	; E = y2

	CALL	__line

	POP     BC
	RET

; void __LIB__ plot_point(uint8_t x, uint8_t y) __smallc;
_plot_point:			; Banked
plot_point:			; Banked
	PUSH    BC

	LD	A,(__mode)
	CP	G_MODE
	CALL	NZ,gmode

	LD 	HL,sp+6		; Skip return address and registers
	LD	B,(HL)	; B = x
	ld	hl,sp+4
	LD	C,(HL)	; C = y

	CALL	__plot

	POP	BC
	RET

	;; Old, compatible version of plot()
;void __LIB__ plot(uint8_t x, uint8_t y, uint8_t colour, uint8_t mode) __smallc;
	PUBLIC	plot
	PUBLIC	_plot
plot:
_plot:				; Banked
	PUSH    BC

	LD	A,(__mode)
	CP	G_MODE
	CALL	NZ,gmode

	LD 	HL,sp+10	; Skip return address and registers
	LD	B,(HL)		; B = x
	ld	hl,sp+8
	LD	C,(HL)		; C = y
	ld	hl,sp+6
	LD	A,(HL)		; colour
	LD	(fg_colour),A
	ld	hl,sp+4
	LD	A,(HL)		; mode
	LD	(draw_mode),A
	
	CALL	__plot

	POP	BC
	RET

