.section .rodata

input:   .string "%d"
input_arr:   .string "%d"
output:   .string "%d"

.section .text
.global main

main:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)

    la a0,input
    addi a1, sp , 48
    call scanf

    lw s0, 48(sp)
    mv s1, s0

    li s2, 0


main2:
    li t0, a0
    beq t1, t0, done   
    