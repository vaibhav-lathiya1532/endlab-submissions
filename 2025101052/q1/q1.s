.section .rodata
    fmt1: .string "%lld"
    fmt2: .string "%lld\n"
    fmt3: .string "%lld %lld\n"
.section .text
.globl main
main:
    addi sp,sp,-32
    sd x1,24(sp)
    sd s0,16(sp) # s0=n
    sd s1,8(sp) # s1=base array address
    sd s2,0(sp) # s2=index for loop
    addi s2,x0,0
    lla x10,fmt1
    addi sp,sp,-16
    addi x11,sp,8
    call scanf
    ld s0,8(sp)
    addi sp,sp,16
    # s0=n
    addi x10,s0,0
    slli x10,x10,3
    call malloc
    addi s1,x10,0
    # s1 has base array address
    scanloop:
        bge s2,s0,logic
        lla x10,fmt1
        addi x30,s2,0
        slli x30,x30,3
        add x11,s1,x30
        call scanf
        addi s2,s2,1
        beq x0,x0,scanloop
    logic:
        add s2,x0,x0
        # index=s2
        ld x28,0(s1)
        addi s2,s2,1
        loop:
            bge s2,s0,exit
            add x30,s2,x0
            addi x31,x0,8
            mul x30,x30,x31
            add x30,x30,s1
            ld x30,0(x30)
            blt x28,x30,condition
            beq x28,x30,continue
            beq x0,x0,updatex29
            continue:
                addi s2,s2,1
                beq x0,x0,loop
            condition:
                add x29,x28,x0
                add x28,x30,x0
                addi s2,s2,1
                beq x0,x0,loop2
            updatex29:
                add x29,x30,x0
                addi s2,s2,1
                beq x0,x0,loop2
        loop2:
            bge s2,s0,exit
            add x30,s2,x0
            addi x31,x0,8
            mul x30,x30,x31
            add x30,x30,s1
            ld x30,0(x30)
            blt x28,x30,condition2
            beq x28,x30,loop2conti
            blt x29,x30,condition3
            bge x29,x30,loop2conti
            condition2:
                add x29,x28,x0
                add x28,x30,x0
                beq x0,x0,loop2conti
            condition3:
                add x29,x30,x0
                beq x0,x0,loop2conti
            loop2conti:
                addi s2,s2,1
                beq x0,x0,loop2
    exit:
        lla x10,fmt2
        add x11,x29,x0
        call printf
        ld x1,24(sp)
        ld s0,16(sp)
        ld s1,8(sp)
        ld s2,0(sp)
        addi sp,sp,32
        li x10,0
        ret