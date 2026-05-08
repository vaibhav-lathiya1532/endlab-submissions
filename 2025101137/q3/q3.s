.text
.globl main

main:
    li a7,5
    ecall
    mv t0,a0
    li t1,0
    ld t2,t1
    li t4,0

read_value:
    bge t1,t0,hjjhkjn
    sd t3,0(t2)
    li a7 5
    ecall
    addi t4,t4,a0
    mv t3,a0


    