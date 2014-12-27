
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                zx spectrum if2 cartridge                  ;;
;;      generated by target/zx/startup/zx_crt_1.m4           ;;
;;                                                           ;;
;;   16k ROM in 0-16k area, ram placement per pragmas        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CRT AND CLIB CONFIGURATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

include "../crt_defaults.inc"
include "crt_target_defaults.inc"
include "../crt_rules.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET UP MEMORY MODEL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

include "../crt_memory_model.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLOBAL SYMBOLS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

include "../clib_constants.inc"
include "clib_target_constants.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INSTANTIATE DRIVERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EXTERN _font_4x8_def


; When FILEs and FDSTRUCTs are instantiated labels are assigned
; to point at created structures.
;
; The label formats are:
;
; __i_stdio_file_n     = address of static FILE structure #n (0..__I_STDIO_NUM_FILE-1)
; __i_fcntl_fdstruct_n = address of static FDSTRUCT #n (0..__I_FCNTL_NUM_FD-1)
; __i_fcntl_heap_n     = address of allocation #n on heap (0..__I_FCNTL_NUM_HEAP-1)





   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ; FILE  : _stdin
   ;
   ; driver: zx_01_input_kbd_inkey
   ; fd    : 0
   ; mode  : read only
   ; type  : 001 = input terminal
   ; tie   : __i_fcntl_fdstruct_1
   ;
   ; ioctl_flags   : 0x03b0
   ; buffer size   : 64 bytes
   ; debounce      : 1 ms
   ; repeat_start  : 500 ms
   ; repeat_period : 15 ms
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      
   SECTION data_stdio
   
   ; FILE *
      
   PUBLIC _stdin
      
   _stdin:  defw __i_stdio_file_0 + 2
   
   ; FILE structure
   
   __i_stdio_file_0:
   
      ; open files link
      
      defw 0
      
      ; jump to underlying fd
      
      defb 195
      defw __i_fcntl_fdstruct_0

      ; state_flags_0
      ; state_flags_1
      ; conversion flags
      ; ungetc

      defb 0x40      ; read + stdio manages ungetc + normal file type
      defb 0x02      ; last operation was read
      defb 0
      defb 0
      
      ; mtx_recursive
      
      defb 0         ; thread owner = none
      defb 0x02      ; mtx_recursive
      defb 0         ; lock count = 0
      defb 0xfe      ; atomic spinlock
      defw 0         ; list of blocked threads
    
         
   ; fd table entry
   
   SECTION data_fcntl_fdtable_body
   defw __i_fcntl_fdstruct_0

   ; FDSTRUCT structure
   
   SECTION data_fcntl_stdio_heap_body
   
   EXTERN console_01_input_terminal_fdriver
   EXTERN zx_01_input_kbd_inkey
   
   __i_fcntl_heap_0:
   
      ; heap header
      
      defw __i_fcntl_heap_1
      defw 105
      defw 0
   
   __i_fcntl_fdstruct_0:

      ; FDSTRUCT structure
      
      ; call to first entry to driver
      
      defb 205
      defw console_01_input_terminal_fdriver
      
      ; jump to driver
      
      defb 195
      defw zx_01_input_kbd_inkey
      
      ; flags
      ; reference_count
      ; mode_byte
      
      defb 0x01      ; stdio handles ungetc + type = input terminal
      defb 2
      defb 0x01      ; read only
      
      ; ioctl_flags
      
      defw 0x03b0
      
      ; mtx_plain
      
      defb 0         ; thread owner = none
      defb 0x01      ; mtx_plain
      defb 0         ; lock count = 0
      defb 0xfe      ; atomic spinlock
      defw 0         ; list of blocked threads

      ; tied output terminal
      ; pending_char
      ; read_index
      
      defw __i_fcntl_fdstruct_1
      defb 0
      defw 0
      
      ; b_array_t edit_buffer
      
      defw __edit_buffer_0
      defw 0
      defw 64
      
      ; getk_state
      ; getk_lastk
      ; getk_debounce_ms
      ; getk_repeatbegin_ms
      ; getk_repeatperiod_ms
      
      defb 0
      defb 0
      defb 1
      defw 500
      defw 15
      
            
      ; reserve space for edit buffer
      
      __edit_buffer_0:   defs 64
      

            
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ; FILE  : _stdout
   ;
   ; driver: zx_01_output_char_64
   ; fd    : 1
   ; mode  : write only
   ; type  : 002 = output terminal
   ;
   ; ioctl_flags   : 0x2370
   ; cursor coord  : (0,0)
   ; window        : (0,64,0,24)
   ; scroll limit  : 0
   ; font address  : _font_4x8_def - 256
   ; text colour   : 56
   ; text mask     : 0
   ; background    : 56
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
      
   SECTION data_stdio
   
   ; FILE *
      
   PUBLIC _stdout
      
   _stdout:  defw __i_stdio_file_1 + 2
   
   ; FILE structure
   
   __i_stdio_file_1:
   
      ; open files link
      
      defw __i_stdio_file_0
      
      ; jump to underlying fd
      
      defb 195
      defw __i_fcntl_fdstruct_1

      ; state_flags_0
      ; state_flags_1
      ; conversion flags
      ; ungetc

      defb 0x80         ; write + normal file type
      defb 0            ; last operation was write
      defb 0
      defb 0
      
      ; mtx_recursive
      
      defb 0         ; thread owner = none
      defb 0x02      ; mtx_recursive
      defb 0         ; lock count = 0
      defb 0xfe      ; atomic spinlock
      defw 0         ; list of blocked threads
    
         
   ; fd table entry
   
   SECTION data_fcntl_fdtable_body
   defw __i_fcntl_fdstruct_1

   ; FDSTRUCT structure
   
   SECTION data_fcntl_stdio_heap_body
   
   EXTERN console_01_output_terminal_fdriver
   EXTERN zx_01_output_char_64
   
   __i_fcntl_heap_1:
   
      ; heap header
      
      defw __i_fcntl_heap_2
      defw 35
      defw __i_fcntl_heap_0

   __i_fcntl_fdstruct_1:
   
      ; FDSTRUCT structure
      
      ; call to first entry to driver
      
      defb 205
      defw console_01_output_terminal_fdriver
      
      ; jump to driver
      
      defb 195
      defw zx_01_output_char_64
      
      ; flags
      ; reference_count
      ; mode_byte
      
      defb 0x02      ; type = output terminal
      defb 2
      defb 0x02      ; write only
      
      ; ioctl_flags
      
      defw 0x2370
      
      ; mtx_plain
      
      defb 0         ; thread owner = none
      defb 0x01      ; mtx_plain
      defb 0         ; lock count = 0
      defb 0xfe      ; atomic spinlock
      defw 0         ; list of blocked threads

      ; cursor coordinate
      ; window rectangle
      ; scroll limit

      defb 0, 0
      defb 0, 64, 0, 24
      defb 0
      
      ; font address
      ; text colour
      ; text mask
      ; background colour
      
      defw _font_4x8_def - 256
      defb 56
      defb 0
      defb 56

         
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ; DUPED FILE DESCRIPTOR
   ;
   ; FILE  : _stderr
   ; flags : 0x80
   ;
   ; fd    : 2
   ; dup fd: __i_fcntl_fdstruct_1
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      
   SECTION data_stdio
      
   ; FILE *
      
   PUBLIC _stderr
      
   _stderr:  defw __i_stdio_file_2 + 2
      
   ; FILE structure
      
   __i_stdio_file_2:
   
      ; open files link
      
      defw __i_stdio_file_1
      
      ; jump to duped fd
      
      defb 195
      defw __i_fcntl_fdstruct_1

      ; state_flags_0
      ; state_flags_1
      ; conversion flags
      ; ungetc

      defb 0x80
      defb 0
      defb 0
      defb 0
      
      ; mtx_recursive
      
      defb 0         ; thread owner = none
      defb 0x02      ; mtx_recursive
      defb 0         ; lock count = 0
      defb 0xfe      ; atomic spinlock
      defw 0         ; list of blocked threads

         
   ; fd table entry
   
   SECTION data_fcntl_fdtable_body
   defw __i_fcntl_fdstruct_1
   
   ; FDSTRUCT structure
   
   defc __i_fcntl_fdstruct_2 = __i_fcntl_fdstruct_1
   
   ; adjust reference count on duped FDSTRUCT
   
   SECTION code_crt_init
   
   ld hl,__i_fcntl_fdstruct_1 + 7     ; & FDSTRUCT.ref_count
   inc (hl)
   inc (hl)

      
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; create open and closed FILE lists
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ; __clib_fopen_max   = max number of open FILEs specified by user
   ; 3 = number of static FILEs instantiated in crt
   ; __i_stdio_file_n   = address of static FILE structure #n (0..I_STDIO_FILE_NUM-1)

   SECTION data_stdio

   IF (__clib_fopen_max > 0) | (3 > 0)

      ; number of FILEs > 0

      ; construct list of open files

      IF 3 > 0
   
         ; number of FILEs statically generated > 0
      
         SECTION data_stdio
      
         PUBLIC __stdio_open_file_list
      
         __stdio_open_file_list:  defw __i_stdio_file_2
   
      ELSE
   
         ; number of FILEs statically generated = 0
   
         SECTION bss_stdio
      
         PUBLIC __stdio_open_file_list
      
         __stdio_open_file_list:  defw 0

      ENDIF
   
      ; construct list of closed / available FILEs
   
      SECTION data_stdio
  
      PUBLIC __stdio_closed_file_list
   
      __stdio_closed_file_list:   defw 0, __stdio_closed_file_list
   
      IF __clib_fopen_max > 3

         ; create extra FILE structures
     
         SECTION bss_stdio
      
         __stdio_file_extra:      defs (__clib_fopen_max - 3) * 15
      
         SECTION code_crt_init
      
            ld bc,__stdio_closed_file_list
            ld de,__stdio_file_extra
            ld l,__clib_fopen_max - 3
     
         loop:
      
            push hl
         
            EXTERN asm_p_forward_list_alt_push_front
            call asm_p_forward_list_alt_push_front
         
            ld de,15
            add hl,de
            ex de,hl
         
            pop hl
         
            dec l
            jr nz, loop

      ENDIF   

   ENDIF

   IF (__clib_fopen_max = -1) & (3 = 0)
   
      ; create empty file lists
      
      SECTION bss_stdio
      PUBLIC __stdio_open_file_list
      __stdio_open_file_list:  defw 0
      
      SECTION data_stdio
      PUBLIC __stdio_closed_file_list
      __stdio_closed_file_list:   defw 0, __stdio_closed_file_list

   ENDIF

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; create fd table
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
   ; __clib_open_max  = max number of open fds specified by user
   ; 3 = number of static file descriptors created

   PUBLIC __fcntl_fdtbl_size
   
   IF 3 > 0
   
      ; create rest of fd table in data segment
      
      SECTION data_fcntl_fdtable_body
            
      PUBLIC __fcntl_fdtbl
      
      EXTERN ASMHEAD_data_fcntl_fdtable_body
      
      defc __fcntl_fdtbl = ASMHEAD_data_fcntl_fdtable_body
      
      IF __clib_open_max > 3
      
         SECTION data_fcntl_fdtable_body
         
         defs (__clib_open_max - 3) * 2
         defc __fcntl_fdtbl_size = __clib_open_max
      
      ELSE
      
         defc __fcntl_fdtbl_size = 3
      
      ENDIF
   
   ELSE

      IF __clib_open_max > 0
   
         ; create fd table in bss segment

         SECTION bss_fcntl
         
         PUBLIC __fcntl_fdtbl
         
         __fcntl_fdtbl:        defs __clib_open_max * 2
      
      ELSE
      
         ; no fd table at all
         
         PUBLIC __fcntl_fdtbl
         
         defc __fcntl_fdtbl = 0
      
      ENDIF
   
      defc __fcntl_fdtbl_size = __clib_open_max
   
   ENDIF
   
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; finalize stdio heap
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
   ; __clib_stdio_heap_size  = desired stdio heap size in bytes
   ; 140  = byte size of static FDSTRUCTs
   ; 2   = number of heap allocations
   ; __i_fcntl_heap_n     = address of allocation #n on heap (0..__I_FCNTL_NUM_HEAP-1)

   IF 140 > 0
   
      ; static FDSTRUCTs have been allocated in the heap
      
      SECTION data_fcntl

      PUBLIC __stdio_heap
      
      __stdio_heap:            defw __stdio_block

      SECTION data_fcntl_stdio_heap_head
      
      __stdio_block:
      
         defb 0                ; no owner
         defb 0x01             ; mtx_plain
         defb 0                ; number of lock acquisitions
         defb 0xfe             ; spinlock (unlocked)
         defw 0                ; list of threads blocked on mutex
      
      IF __clib_stdio_heap_size > (140 + 14)
      
         ; expand stdio heap to desired size
         
         SECTION data_fcntl_stdio_heap_body
         
         __i_fcntl_heap_2:
          
            defw __i_fcntl_heap_3
            defw 0
            defw __i_fcntl_heap_1
            defs __clib_stdio_heap_size - 140 - 14
         
         ; terminate stdio heap
         
         SECTION data_fcntl_stdio_heap_tail
         
         __i_fcntl_heap_3:   defw 0
      
      ELSE
      
         ; terminate stdio heap
      
         SECTION data_fcntl_stdio_heap_tail
      
         __i_fcntl_heap_2:   defw 0
      
      ENDIF
      
   ELSE
   
      ; no FDSTRUCTs statically created
      
      IF __clib_stdio_heap_size > 14
      
         SECTION data_fcntl
         
         PUBLIC __stdio_heap
         
         __stdio_heap:         defw __stdio_block
         
         SECTION bss_fcntl
         
         PUBLIC __stdio_block
         
         __stdio_block:         defs __clib_stdio_heap_size
         
         SECTION code_crt_init
         
         ld hl,__stdio_block
         ld bc,__clib_stdio_heap_size
         
         EXTERN asm_heap_init
         call asm_heap_init
      
      ENDIF

   ENDIF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STARTUP ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SECTION code_crt_start

PUBLIC __Start, __Exit

EXTERN _main

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rst and im1 entry ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ; address = 0x0001
   
   jr __Start
   
   defs 0x0008 - ASMPC
   
   ; address = 0x0008
   
IF (__crt_enable_rst & $01)

   EXTERN _z80_rst_08h
   jp _z80_rst_08h

ELSE

   ret

ENDIF

   defs 0x0010 - ASMPC

   ; address = 0x0010

IF (__crt_enable_rst & $02)

   EXTERN _z80_rst_10h
   jp _z80_rst_10h


ELSE

   ret

ENDIF

   defs 0x0018 - ASMPC

   ; address = 0x0018
   
IF (__crt_enable_rst & $03)

   EXTERN _z80_rst_18h
   jp _z80_rst_18h

ELSE

   ret

ENDIF

   defs 0x0020 - ASMPC

   ; address = 0x0020

IF (__crt_enable_rst & $04)

   EXTERN _z80_rst_20h
   jp _z80_rst_20h

ELSE

   ret

ENDIF

   defs 0x0028 - ASMPC

   ; address = 0x0028

IF (__crt_enable_rst & $05)

   EXTERN _z80_rst_28h
   jp _z80_rst_28h

ELSE

   ret

ENDIF

   defs 0x0030 - ASMPC

   ; address = 0x0030

IF (__crt_enable_rst & $06)

   EXTERN _z80_rst_30h
   jp _z80_rst_30h

ELSE

   ret

ENDIF

   defs 0x0038 - ASMPC

   ; address = 0x0038
   ; im 1 isr

IF (__crt_enable_rst & $07)

   EXTERN _z80_rst_38h
   call _z80_rst_38h

ENDIF

   ei
   reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; crt startup part 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

__Start:

   di                          ; if warm reset

   ; set stack address
   
   IF __register_sp = -1
   
      ld sp,0
   
   ELSE
   
      ld sp,__register_sp
   
   ENDIF
   
   ; commandline
   
   IF __crt_enable_commandline = 1
      
      IF __SDCC | __SDCC_IX | __SDCC_IY
      
         ld hl,0
         push hl               ; char *argv[]
         push hl               ; int argc

      ELSE
            
         ld hl,0
         push hl               ; int argc
         push hl               ; char *argv[]
   
      ENDIF
   
   ENDIF

   ; initialize sections
   
   include "../clib_init_bss.inc"
   include "../clib_init_data.inc"

   jr __Start_2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nmi entry ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   defs 0x0066 - ASMPC

   ; address = 0x0066

IF __crt_enable_nmi

   EXTERN _z80_nmi
   call _z80_nmi

ENDIF

   retn

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; crt startup part 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

__Start_2:

SECTION code_crt_init          ; user and library initialization
SECTION code_crt_main

   ; call user program
   
   call _main                  ; hl = return status

   ; run exit stack

   IF __clib_exit_stack_size > 0
   
      EXTERN asm_exit
      jp asm_exit              ; exit function jumps to __Exit
   
   ENDIF

__Exit:

SECTION code_crt_exit          ; user and library cleanup
SECTION code_crt_return

   ; close files
   
   include "../clib_close.inc"

   ; restart program
   
   jp __Start

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RUNTIME VARS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

include "../clib_variables.inc"
include "clib_target_variables.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CLIB STUBS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

include "../clib_stubs.inc"
