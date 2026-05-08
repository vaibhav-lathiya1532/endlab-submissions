.globl main

.section .rodata
fmt_num: .string "%lld"

.section .text
main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    sd s4, 0(sp)

    ld s0, 0(a1)          #address of argv
    mv t0, s0

loop:
    lb a0, 0(t0)
    call atoi
    mv s0, a0

    beqz a0, loop_done      #null char
    mv t1, s0
    li t1, '0'
    li t2, '9'
    blt s1, t1, is_op
    bgt s1, t2, is_op

is_digit:
    addi sp, sp, -8
    sd s1, 0(sp)
    addi t0, t0, 1
    j loop

is_op:
    sd s2, 0(sp)
    addi sp, sp, 8
    sd s3, 0(sp)
    addi sp, sp, 8

    li t4, '+'
    li t3, '-'

    beq s1, t4, is_add
    beq s1, t3, is_sub

is_mul:
    mul s4, s3, s2
    addi t0, t0, 1
    addi sp, sp, -8
    sd s4, 0(sp)
    j loop

is_add:
    add s4, s3, s2
    addi t0, t0, 1
    addi sp, sp, -8
    sd s4, 0(sp)
    j loop

is_sub:
    sub s4, s3, s2
    addi t0, t0, 1
    addi sp, sp, -8
    sd s4, 0(sp)
    j loop

loop_done:
    la a0, fmt_num
    mv a1, s4
    addi sp, sp, 8
    call printf

final:
    ld s4, 0(sp)
    ld s3, 8(sp)
    ld s2, 16(sp)
    ld s1, 24(sp)
    ld s0, 32(sp)
    ld ra, 40(sp)
    addi sp, sp, 48

    li a0, 0
    ret

