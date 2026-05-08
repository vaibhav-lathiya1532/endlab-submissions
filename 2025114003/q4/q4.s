.section .data
input_fmt: .string "%d %d"
output_fmt: .string "%d %d %d %d"


.section .text
.globl main

main:

    addi sp, sp, -16

    addi t0, sp, 0
    addi t1, sp, 4

    mv a1, t0
    mv a2, t1

    la a0, input_fmt
    call scanf

    ld s0, 0(t0)
    ld s1, 0(t1)

    sub t2, s1, s0 

    li s6, 25
    li s7, 10
    li s8, 5
    li s9, 1

    li s2, 0
    li s3, 0
    li s4, 0
    li s5, 0

    q_loop:
    blt t2, s6, d_loop
    addi t2, t2, -25
    addi s2,s2,1 
    j q_loop

    d_loop:
    blt t2, s7, p_loop
    addi t2, t2, -10
    addi s3,s3,1 
    j d_loop

    p_loop:
    blt t2, s8, n_loop
    addi t2, t2, -5
    addi s4,s4,1 
    j p_loop

    n_loop:
    blt t2, s9, print
    addi t2, t2, -1
    addi s5,s5,1 
    j n_loop

print:
    la a0, output_fmt
    addi a1, s2, 0
    addi a2, s3, 0
    addi a3, s4, 0
    addi a4, s5, 0

    call printf
    ret



