.section .rodata
input: .string "%s"
output: .string "%lld\n"

.section .text

.globl main

main:
    addi sp,sp,-192
    sd ra,0(sp)
    sd s0,8(sp)     # store stack
    sd s1,16(sp)    # store top
    sd s2,24(sp)    # store string

    la a0,input
    addi a1,sp,24
    call scanf
    addi s2,sp,24

    # malloc stack 800

    li a0,800
    call malloc
    mv s0,a0

    li s1,-1

loop:
    lb t0,0(s2)    # this is the character  

    beqz t0,done

    li t1,'+'
    beq t0,t1,plus

    li t1,'-'
    beq t0,t1,minus

    li t1,'*'
    beq t0,t1,multiply

    addi t0,t0,-'0'

    addi s1,s1,1

    slli t1,s1,3
    add t1,t1,s0

    sd t0,0(t1)

    addi s2,s2,1
    j loop


plus:
    slli t1,s1,3
    add t1,t1,s0
    ld t2,0(t1)

    addi s1,s1,-1

    slli t3,s1,3
    add t3,t3,s0
    ld t4,0(t3)

    add t4,t4,t2
    sd t4,0(t3)

    addi s2,s2,1
    j loop


minus:
    slli t1,s1,3
    add t1,t1,s0
    ld t2,0(t1)

    addi s1,s1,-1

    slli t3,s1,3
    add t3,t3,s0
    ld t4,0(t3)

    sub t4,t4,t2
    sd t4,0(t3)

    addi s2,s2,1
    j loop


multiply:
    slli t1,s1,3
    add t1,t1,s0
    ld t2,0(t1)

    addi s1,s1,-1

    slli t3,s1,3
    add t3,t3,s0
    ld t4,0(t3)

    mul t4,t4,t2
    sd t4,0(t3)

    addi s2,s2,1
    j loop



done:
    ld t0,0(s0)
    la a0,output
    mv a1,t0
    call printf

    ld ra,0(sp)
    ld s0,8(sp)   
    ld s1,16(sp)     
    ld s2,24(sp)   

    addi sp,sp,192

    li a0,0

    ret

