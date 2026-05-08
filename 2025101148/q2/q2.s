.section .rodata
input: .string "%lld %lld"
output: .string "%lld %lld\n"

.section .text
.globl main

main:
    addi sp,sp,-80
    sd ra,64(sp)
    sd s0,48(sp)
    sd s1,32(sp)
    la a0,input
    addi a1,sp,16
    mv a2,sp
    call scanf
    ld s0,16(sp)
    ld s1,0(sp)
    blt s0,s1,first_one_small
    second_one_small:
        mv t0,s1
        mv t1,s0
        j gcd_loop
    first_one_small:
        mv t0,s0
        mv t1,s1
    gcd_loop:
        li t3,1
        ble t0,t3,exit_gcd_loop
        rem t4,s0,t0
        rem t5,s1,t0
        beq t4,x0,check_next_gcd
        addi t0,t0,-1
        j gcd_loop
        check_next_gcd:
            beq t5,x0,exit_gcd_loop
            addi t0,t0,-1
            j gcd_loop
    exit_gcd_loop:
        mul t2,s0,s1
    lcm_loop:
        bge t1,t2,exit_lcm_loop
        rem t4,t1,s0
        rem t5,t1,s1
        beq t4,x0,check_next_lcm
        addi t1,t1,1
        j lcm_loop
        check_next_lcm:
            beq t5,x0,exit_lcm_loop
            addi t1,t1,1
            j lcm_loop
    exit_lcm_loop:
        la a0,output
        mv a1,t0
        mv a2,t1
        call printf
        ld ra,64(sp)
        ld s0,48(sp)
        ld s1,32(sp)
        addi sp,sp,80
        mv a0,x0
        ret