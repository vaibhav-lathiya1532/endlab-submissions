.extern scanf
.extern printf 

.section .rodata
fmt_int:    .string "%lld"
fmt_d:      .string "%d"

.section .bss
arr:    .space 8000000
n:      .space 4
leftsum:    .space 8000000
rightsum:   .space 8000000
.text
.globl main

main:
    addi sp, sp, -48
    sd ra, 0(sp)
    sd s0, 8(sp)    # n
    sd s1, 16(sp)   # i
    sd s2, 24(sp)   # adrarr
    sd s3, 32(sp)   # leftadr
    sd s4, 40(sp)   # rightadr
    la a0, fmt_d
    la t0, n
    la a1, t0
    call scanf
    la s2, arr
    la s3, leftsum
    la s4, rightsum
    ld s0, 0(t0)
    li s1, 0
read_loop:
    bge s1, s0, read_done
    
    slli t0, s1, 3
    add t0, t0, s2
    la a0, fmt_int
    la a1, t0
    call scanf
    beqz s1, first
    ld t5, 0(s3)
    addi s3, s3, 8
    ld t6, 0(s3)
    add t6, t6, t5
    sd t6, 0(s3)

    addi s1, s1, 1
    j read_loop
first:
    li t5, 0
    sd t5, 0(s3)
    addi s1, s1, 1
    j read_loop
read_done:
    addi s1, s1, -1
right_loop:
    li t4, 0
    blt s1, t4, right_done
    beq s1, s0, first_right
    ld t5, 0(s4)
    addi s4, s4, 8
    ld t6, 0(s4)
    add t6, t6, t5
    sd t6, 0(s4)
    j right_loop
first_right:
    li t5, 0
    sd t5, 0(s4)
    addi s1, s1, -1
    j right_loop
right_done:
    li s1, 0
loop2:
    bge s1, s0, print_neg

