.section .data

n: .space 8
L: .space 8

input_fmt_1: .asciz "%lld %lld"
input_fmt_2: .asciz "%lld"
output_fmt: .asciz "%lld\n"

.section .text
.global main

main:
    addi sp,sp,-32
    sd ra,0(sp)
    sd s0,8(sp)
    sd s1,16(sp)
    sd s2,24(sp)

    la a0,input_fmt_1
    la a1,n
    la a2,L

    call scanf

    la a0,n
    ld s0,0(a0)

    mv a0,s0
    slli a0,a0,3
    call malloc

    mv s1,a0

    li s2,0
    input:
        beq s2,s0,exit_input

        la a0,input_fmt_2

        slli t0,s2,3
        add t0,t0,s1


        mv a1,t0
        call scanf

        addi s2,s2,1

        beq x0,x0,input
    exit_input:


    # take two pointers ie t0->st and t1->end and see if a[t0] + a[t1] <= L if yes then move both else move only t1 and in every iteration increment answer

    mv t0,s1
    mv t1,s0
    addi t1,t1,-1
    slli t1,t1,3 # t1 = (N-1)*8
    add t1,t1,s1

    li a0,0 # this will be my answer
    la a1,L 
    ld t6,0(a1)
    mv a1,t6

    loop:
        bgt t0,t1,exit

        beq t0,t1,one_person

        ld t2,0(t0)
        ld t3,0(t1)

        add t4,t2,t3
        bgt t4,a1,one_person

        addi t0,t0,8

        one_person:
        addi t1,t1,-8

        addi a0,a0,1
        beq x0,x0,loop
    exit:

    
    mv a1,a0
    la a0,output_fmt
    call printf


    ld ra,0(sp)
    ld s0,8(sp)
    ld s1,16(sp)
    ld s2,24(sp)
    addi sp,sp,32

    ret
