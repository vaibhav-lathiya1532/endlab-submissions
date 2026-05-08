.section .data
array: .space 8
fmt_in: .asciz "%d"
fmt_out: .asciz "1\n"
fmt_out0: .asciz "0\n"

.section .text
.globl main

main:
    #take input n
    la a0, fmt_in
    la a1, array
    call scanf
    #s1 has number
    ld s1, array
    #no of iterations
    li t0, 0

outer_loop:
    addi t1, s1, 0
    li t6, 100
    bgt t0, t6, not_happy
    li t6, 1
    beq t1, t6, happy 
    li t2, 0

digit_count:
    li t6, 0
    beq t1, t6, next_outer
    li t4, 10
    rem t3, t1, t4
    mul t3, t3, t3
    add t2, t2, t3
    div t1, t1, t4
    j digit_count

next_outer:
    addi s1, t2, 0
    addi t0, t0, 1
    j outer_loop

happy:
    #print happy
    la a0, fmt_in
    la a1, fmt_out
    call printf
    
not_happy:
    #print not happy
    la a0, fmt_in
    la a1, fmt_out0
    call printf

    