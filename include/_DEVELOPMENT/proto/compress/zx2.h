include(__link__.m4)

#ifndef __COMPRESS_ZX2_H__
#define __COMPRESS_ZX2_H__

//////////////////////////////////////////////////////////////
//                ZX2 FAMILY OF DECOMPRESSORS               //
//                 Copyright  Einar Saukas                  //
//////////////////////////////////////////////////////////////
//                                                          //
// Further information is available at:                     //
// https://github.com/einar-saukas/ZX2                      //
//                                                          //
//                                                          //
//////////////////////////////////////////////////////////////

/*

   ZX2 Decompresses data that was previously compressed using
   a PC utility; it does not provide a z80 compressor.

   Decompression of compressed zx1 data:

   * dzx2_nano()

     The smallest version of the decompressor.
   
*/

__DPROTO(,,unsigned char,*,dzx2_nano,void *src,void *dst)
__DPROTO(,,unsigned char,*,dzx2_nano_back,void *src,void *dst)


#endif
