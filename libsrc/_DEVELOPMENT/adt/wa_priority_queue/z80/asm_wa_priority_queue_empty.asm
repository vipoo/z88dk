
; ===============================================================
; Mar 2014
; ===============================================================
; 
; int wa_priority_queue_empty(wa_priority_queue_t *q)
;
; Return non-zero if the queue is empty.
;
; ===============================================================

SECTION code_adt_wa_priority_queue

PUBLIC asm_wa_priority_queue_empty

EXTERN l_testword_hl

defc asm_wa_priority_queue_empty = l_testword_hl - 4

   ; enter : hl = priority_queue *
   ;
   ; exit  : if queue is empty
   ;
   ;           hl = 1
   ;           z flag set
   ;
   ;         if queue is not empty
   ;
   ;           hl = 0
   ;           nz flag set
   ;
   ; uses  : af, hl
