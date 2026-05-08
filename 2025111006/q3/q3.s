.section .rodata
fat1:
    .string "%d"
fat2:
    .string "%d\n"

.section .data
n:
    .space 8

.section .text
.globl main

main:
    addi sp, sp -
    sd, ra, 0(sp)
    sd, s1, 8(sp)
    sd, s2, 16(sp)
    sd, s3, 24(sp)
    sd, s4, 32(sp)
    sd, s5, 40(sp)

    lla a0, fat1
    lla, a1, n
    call scanf

    mv s3, a0
    slli a0, a0, 3
    call malloc

    mv s1, a0

    li s2, 0
    li s5, 0
    addi s4, s3, -1

input:
    ble s2, s3, olop
    lla, a0, fat1
    add a0, s0, s2
    call scanf

    ld t0, 0(a1)

    