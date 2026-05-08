.section .rodata
fmtin: .string "%lld %lld"
fmtout: .string "%lld %lld %lld %lld\n"

.section .text
.global main
main:
    addi sp,sp,-48
    sd ra,0(sp)
    sd s0,8(sp)    #change
    sd s1,16(sp)   #25
    sd s2,24(sp)   #10
    sd s3,32(sp)   #5

    la a0,fmtin
    addi sp,sp,-8
    addi a1,sp,0
    addi sp,sp,-8
    addi a2,sp,0
    call scanf
    ld t0,0(sp)
    ld t1,8(sp)
    addi sp,sp,16

    sub s0,t0,t1

    li s1,0
    li s2,0
    li s3,0

loop25:
    li t0,25
    blt s0,t0,loop10
    sub s0,s0,t0
    addi s1,s1,1
    j loop25

loop10:
    li t0,10
    blt s0,t0,loop5
    sub s0,s0,t0
    addi s2,s2,1
    j loop10

loop5: 
    li t0,5
    blt s0,t0,done
    sub s0,s0,t0
    addi s3,s3,1
    j loop5

done:
    la a0,fmtout
    mv a1,s1
    mv a2,s2
    mv a3,s3
    mv a4,s0
    call printf

    li a0,0
    ld ra,0(sp)
    ld s0,8(sp)    #change
    ld s1,16(sp)   #25
    ld s2,24(sp)   #10
    ld s3,32(sp)   #5
    addi sp,sp,48
    ret
