.data
fmt_n: .asciz "%lld"
fmt_in: .asciz "%lld"
true_s: .asciz "TRUE\n"
false_s: .asciz "FALSE\n"

num: .quad 0
arr: .space 800000
.text
.globl main

main:
    la a0,fmt_in
    la a1,num
    call scanf

    ld s0,num
    la s1,arr

    li s2,0

readloop:
    bge s2,s0,check

    la a0,fmt_in
    slli t0,s2,3
    add t0,t0,s1
    mv a1,t0
    call scanf

    addi s2,s2,1
    j readloop

check:
    li t0,1
    beq s0,t0,no
    li s2,1

loop:
    bge s2,s0,yes

    addi t0,s2,-1
    slli t0,t0,3
    add t0,t0,s1
    ld t1,0(t0)

    slli t2,s2,3
    add t2,t2,s1
    ld t3,0(t2)

    andi t4,t1,1
    andi t5,t3,1

    beq t4,t5,no

    addi s2,s2,1
    j loop

yes:
    la a0,true_s
    call printf
    j exit

no:
    la a0,false_s
    call printf

exit:
    li a7,93
    li a0,0
    ecall

