.section .rotate
input:
 .string "\d"
output:
    .string "\d\n"

.section .text
.global main
main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s5,48(sp)
    sd s4,40(sp)
    sd s3,40(sp)
    sd s2,32(sp)
    sd s1,24(sp)
    sd s0,16(sp)

    lla s0,input
    mv a1,s0
    call scanf
    ld s0, 0(sp)

    slli a0,s0,3
    call malloc
    mv s1,a0

    li s2,0

read_loop:
    bge s2,s0,read_done
    lla a0,input
    mv a1,sp
    call scanf
    ld t0, 0(sp)

    slli t1,t2,3
    add t1,t1,s1
    sd t0,0(t1)

    addi s2,s2,1
    j read_loop

read_done:
    lla a0,input
    mv a1,sp
    call scanf
    ld s2,0(sp)

    li s3,0
    addi s4,s0,-1
    li a1,-1


