.section .data
fmt: .string "%d"

.section .bss
.align 3
A: .size 800000

.section .text
.global main

main:
    addi sp sp -16
    ld ra 8(sp)

    la a0 fmt
    la a1 0(sp)
    call scanf

    la t0 0(sp)

    loop:
        blt t0 a0

    

