# z80asm2 TO-DO list

## Short term

[ ] do not process preprocessor directives in the false branch of IF  
    fails building z88dk because INCLUDE of unexistent file guarded by 
    IF FALSE is processed and assembly fails
[ ] process C_LINE  
[ ] fix list files when parsing a .i

## Medium term

[ ] move all directives from z80asm to z80asm2  
[ ] handle -m for architecture specific code  
[ ] handle -D and -U for top-level defines

## Back-log

## Done

[x] process INCLUDE  
[x] generate .i file
[x] indicate syntax error location  
[x] process labels  
