zcc +cpm -vn -clib=sdcc_iy -SO3 --max-allocs-per-node200000 demo.c aes256.c -o DEMO-Z88DK -create-app
zcc +zx -vn -startup=4 -clib=sdcc_iy -SO3 --max-allocs-per-node200000 demo.c aes256.c -o DEMOZX-Z88DK -create-app
