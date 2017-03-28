sdasz80 -g -o crt0.s
sdasz80 -g -o cpm.s
sdcc -c -mz80 --max-allocs-per-node200000 demo.c
sdcc -c -mz80 --max-allocs-per-node200000 aes256.c
sdcc -mz80 --no-std-crt0 crt0.rel cpm.rel demo.rel aes256.rel -o DEMO-SDCC.ihx
hex2bin DEMO-SDCC.ihx
copy /b DEMO-SDCC.bin DEMO-SDCC.COM
