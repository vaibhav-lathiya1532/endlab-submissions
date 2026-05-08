.section .rodata
fmt1:
.string "%lld %lld"
fmt2:
.string "%lld %lld %lld %lld\n"

.section .bss
price:
.skip 8
inserted:
.skip 8

.section .text
.globl main
main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s0,48(sp)
    sd s1,40(sp)
    sd s2,32(sp)
    sd s3,24(sp)
    sd s4,16(sp)
    sd s5,8(sp)
    sd s6,0(sp)


    la a0,fmt1
    la a1,price
    la a2,inserted
    call scanf

    la t0,price
    la t1,inserted

    ld s0,0(t0)
    ld s1,0(t1)

    li t0,25
    li t1,10
    li t2,5
    li t3,1

    li s3,0
    li s4,0
    li s5,0
    li s6,0

    sub s2,s1,s0

loop1:
    blt s2,t0,loop2
    sub s2,s2,t0
    addi s3,s3,1
    j loop1

loop2:
    blt s2,t1,loop3
    sub s2,s2,t1
    addi s4,s4,1
    j loop2

loop3:
    blt s2,t2,loop4
    sub s2,s2,t2
    addi s5,s5,1
    j loop3

loop4:
    blt s2,t3,fin
    sub s2,s2,t3
    addi s6,s6,1
    j loop4

fin:
    la a0,fmt2
    mv a1,s3
    mv a2,s4
    mv a3,s5
    mv a4,s6
    call printf

li a0,0
ld ra,56(sp)
ld s0,48(sp)
ld s1,40(sp)
ld s2,32(sp)
ld s3,24(sp)
ld s4,16(sp)
ld s5,8(sp)
ld s6,0(sp)

ret


