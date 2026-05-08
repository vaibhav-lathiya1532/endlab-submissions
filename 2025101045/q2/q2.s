.section .rodata
input2: .string "%lld %lld"
input1: .string "%lld"
output: .string "%lld\n"

.section .text
.global main
main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s4,48(sp)
    sd s3,40(sp)
    sd s2,32(sp)
    sd s1,24(sp)
    sd s0,16(sp)

    lla a0,input2
    mv a1,sp
    add a2,sp,8
    call scanf
    ld s0,0(sp)
    ld s1,0(sp)

    slli a0,s0,3
    call malloc
    mv s2,a0

    li s3,0

rloop:
    bge s3,s0,rdone

    lla a0,input1
    mv a1,sp
    call scanf
    ld t0, 0(sp)

    slli t1,t2,3
    add t1,t1,s1
    sd t0,0(t1)

    addi s3,s3,1
    j rloop

rdone:
    li s3,0
    addi s4,s0,-1
    li a1,0

loop:
    bgt s3,s4,print

    slli t0,s3,3
    add t0,t0,s2
    ld t0, 0(t0)
    
    slli t1,s4,3
    add t1,t1,s2
    ld t1, 0(t1)

    add t2,t0,t1
    bgt t2,s1,second
first:
    addi s3,s3,1

second:
    addi s4,s4,-1
    addi a1,a1,1
    j loop

print:
    lla a0,output
    li a7,5
    ecall 

    mv a0,a2
    call free
    ld ra,56(sp)
    ld s4,48(sp)
    ld s3,40(sp)
    sd s2,32(sp)
    sd s1,24(sp)
    sd s0,16(sp)
    addi sp,sp,64

    li a7,10
    ecall









