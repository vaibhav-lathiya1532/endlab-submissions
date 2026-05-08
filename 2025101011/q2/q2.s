.section .rodata
fmt_test:
    .string "%lld"
fmt_input:
    .string "%lld%lld"
.text

.globl main

main:
    la a0, fmt_test
    li a1, 8
    call printf
    


