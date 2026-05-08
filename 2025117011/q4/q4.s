.data
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld "

.text
.globl main
.extern exit
.extern printf
.extern scanf

main:
    addi sp, sp, -16

    la a0, fmt_in
    mv a1, sp
    call scanf
    ld s1, 0(sp) # money

    la a0, fmt_in
    mv a1, sp
    call scanf
    ld s2, 0(sp) # total money you gave
    
    sub s0, s2, s1 # money you have to give

    li t0, 25
    li t1, 10
    li t2, 5
    li t3, 1

    li s4, 0
    li s5, 0
    li s6, 0
    li s7, 0

loop1:
    blt s0, t0, loop2
    sub s0, s0, t0
    addi s4, s4, 1
    j loop1

loop2:
    blt s0, t1, loop3
    sub s0, s0, t1
    addi s5, s5, 1
    j loop2

loop3:
    blt s0, t2, loop4
    sub s0, s0, t2
    addi s6, s6, 1
    j loop3

loop4:
    blt s0, t3, done
    sub s0, s0, t3
    addi s7, s7, 1
    j loop4

done:
    la a0, fmt_out
    mv a1, s4
    call printf

    la a0, fmt_out
    mv a1, s5
    call printf

    la a0, fmt_out
    mv a1, s6
    call printf

    la a0, fmt_out
    mv a1, s7
    call printf
    addi sp, sp, 16
    call exit