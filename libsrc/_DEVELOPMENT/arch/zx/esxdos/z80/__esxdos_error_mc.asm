SECTION code_clib
SECTION code_esxdos

PUBLIC __esxdos_error_mc

EXTERN errno_mc

   ; set errno and exit indicatig error
   ;
   ; enter : a = esxdos error code
   ;
   ; exit  : hl = -1, carry set, errno = esxdos code

defc __esxdos_error_mc = errno_mc
