.data
N:.dword 0
L:.dword 0
fmt_inp: .asciz "%lld"
fmt_op: .asciz "%lld"
fmt_nl: .asciz "\n"
fmt_sp: .asciz " "
array: .space 8000000

.text
    ld s0, N 
.globl main
.extern scanf
.extern printf

main:
    addi sp, sp, -80
    sd ra, 0(sp)
    sd s0, 8(sp) # N
    sd s1, 16(sp) # n*n 
    sd s2, 24(sp) # array ptr/(base address)
    sd s3, 32(sp) # j
    sd s4, 40(sp) # i
    sd s5, 48(sp) 

    la a0, fmt_inp
    la a1, N 
    call scanf

    mv s0, N 


    la a0, fmt_op
    la a1, L
    call scanf

    mv s1, L 

    la s2, array


    li s4, 0

loop_inp:
    beq s4, s0, done_inp
    slli t0, s2, 8
    add t0, t0, s2

    la a0, fmt_inp
    mv t0, a1
    call scanf

    addi s2, s2, 1
    j loop_inp

done_inp:
    li s2, 1
    li s5, 0

cap_countr:
    # calc address ie, i*N + base

    mul t0, s2, s0
    add t0, t0, s2

    #val
    ld t2, 0(t0)
    
    srai s2, s2, 3 # move 3 bytes

    mul t0 s2, s0
    add t0, t0, s2

    #val
    ld t3, 0(t0)

    add t2, t2, t3
    bgt 

    

