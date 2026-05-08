.section .rodata
    fmt1: .string "%lld"
    fmt2: .string "%lld %lld %lld %lld\n"
.section .text
.globl main
main:
    addi sp,sp,-32
    sd x1,24(sp)
    sd s0,16(sp) # s0=n1
    sd s1,8(sp) # s1=n2
    lla x10,fmt1
    addi x11,sp,0
    call scanf
    ld s0,0(sp)
    lla x10,fmt1
    addi x11,sp,0
    call scanf
    ld s1,0(sp)
    sub s1,s1,s0
    # s1=s1-s0
    addi x5,x0,25
    addi x6,x0,10
    addi x7,x0,5
    addi x11,x0,1
    addi x28,x0,0
    addi x29,x0,0
    addi x30,x0,0
    addi x31,x0,0
    loop1:
        blt s1,x5,loop2
        sub s1,s1,x5
        addi x28,x28,1
        beq x0,x0,loop1
    loop2:
        blt s1,x6,loop3
        sub s1,s1,x6
        addi x29,x29,1
        beq x0,x0,loop2
    loop3:
        blt s1,x7,loop4
        sub s1,s1,x7
        addi x30,x30,1
        beq x0,x0,loop3
    loop4:
        blt s1,x11,exit
        sub s1,s1,x11
        addi x31,x31,1
        beq x0,x0,loop4
    exit:   
        lla x10,fmt2
        addi x11,x28,0
        addi x12,x29,0
        addi x13,x30,0
        addi x14,x31,0
        call printf 
        ld x1,24(sp)
        ld s0,16(sp)
        ld s1,8(sp)
        addi sp,sp,32
        li x10,0
        ret   