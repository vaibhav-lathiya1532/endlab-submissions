.data

in: .string "%lld %lld"
out: .string "%lld %lld %lld %lld\n"

.text
.globl main

main: 
    addi sp,sp,-32
    sd ra,24(sp)

    la a0,in
    addi a1,sp,0
    addi a2,sp,8
    call scanf
    ld s1,0(sp)
    ld s2,8(sp)

    sub s3,s2,s1
    li s4,0

q_loop:
    li t0,25
    blt s3,t0,q_done

    sub s3,s3,t0
    addi s4,s4,1
    j q_loop

q_done:
    li s5,0

d_loop:
    li t0,10
    blt s3,t0,d_done

    sub s3,s3,t0
    addi s5,s5,1
    j d_loop

d_done:
    li s6,0

n_loop:
    li t0,5
    blt s3,t0,n_done

    sub s3,s3,t0
    addi s6,s6,1
    j n_loop

n_done:

    la a0,out
    mv a1,s4
    mv a2,s5
    mv a3,s6
    mv a4,s3
    call printf

    li a0,0
    ld ra,24(sp)
    addi sp,sp,32
    ret



