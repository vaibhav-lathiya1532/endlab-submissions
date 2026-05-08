.globl main

.section .data
num: .space 8
arr: .space 808
input: .string "%ld"

.section .text
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    sd s5, 8(sp)
    sd s6, 0(sp)

    la a0, input
    la a1, num
    call scanf

    la t0, num
    ld s0, 0(t0)
    li s1, 0
    li s2, -1000000
    li s3, -1000000
    la s4, arr

loop:
    beq s1, s0, done
    slli t0, s1, 3
    add t0, t0, s4
    la a0, input
    mv a1, t0
    call scanf
    slli t0, s1, 3
    add t0, t0, s4
    ld t1, 0(t0)
    bgt t1, s2, for_first
for_second:
    beq t1, s2, inc
    bgt t1, s3, for_second_action
inc:
    addi s1, s1, 1
    j loop

for_first:
    mv s3, s2
    mv s2, t1
    j inc

for_second_action:
    mv s3, t1
    j inc

done:
    la a0, input
    mv a1, s3
    call printf
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)
    ld s5, 8(sp)
    ld s6, 0(sp)
    addi sp, sp, 64
    li a0, 0
    ret
