# Z80 Module Assembler Manual

# *** work in progress ***

z80asm is part of the [z88dk](http://www.z88dk.org/) project and is used as the 
back-end of the z88dk C compilers. 

## Module Assembler

z80asm supports a separate assembly and link phase, required to be used as a 
C compiler back-end. It also supports the creation of and linking from object 
libraries, to be used as the back-end for the clib.

## Sections

z80asm supports the usage of sections as a form to organize the different
modules into a run-time image memory map. In z88dk, different architecture crts
define the memory map in terms of section names that are used by user code to
locate modules in certain memory areas.

## Labels

```label     opcode```  
```  .label  opcode```  
```   label: opcode```  

Labels in z80asm are decorated with a dot ('.') prefix or a colon (':') suffix
and do not need to start on column 1. 

For compatibility with old assemblers, a label can be undecorated if it starts
on column 1.

## Preprocessing Directives

### Include text files

```[label] {#include|*include|%include|include} {"file"|'file'|<file>|file}```  

A source file can include the text of another source file at the current line
with an INCLUDE directive. The include file is searched in the include path
specified with the command line option -I.
   
The parent source file directory is added to the include path during the parse
so that any included files may be referred by a relative path.

The different available syntaxes are equivalent and exist to support source file
intended for other assemblers.


## Copyright

The original z80asm module assembler was written by Gunther Strube. 
It was converted from QL SuperBASIC version 0.956, initially ported to Lattice C,
and then to C68 on QDOS.

It has been maintained since 2011 by Paulo Custodio.

Copyright (C) Gunther Strube, InterLogic 1993-99  
Copyright (C) Paulo Custodio, 2011-2018

## Repository

Repository: https://github.com/z88dk/z88dk

## License

Artistic License 2.0 <http://www.perlfoundation.org/artistic_license_2_0>
