.section .rodata
input: .string "%lld"
output: .string "%lld\n"

.section .text
.globl main

main:
    addi sp,sp,-96
    sd ra,80(sp)
    sd s0,64(sp)
    sd s1,48(sp)
    sd s2,32(sp)
    addi a1,sp,16
    la a0,input
    call scanf
    ld s0,16(sp)
    mv a0,s0
    slli a0,a0,3
    call malloc
    mv s1,a0
    mv s2,x0
    input_loop:
        bge s2,s0,exit_input_loop
        mv a1,s2
        slli a1,a1,3
        add a1,a1,s1
        la a0,input
        call scanf
        addi s2,s2,1
        j input_loop
    exit_input_loop:
        la a0,input
        mv a1,sp
        call scanf
        ld s2,0(sp)
        mv t0,x0
        addi t2,s0,-1
    search_loop:
        bgt t0,t2,not_found
        sub t1,t2,t0
        srli t1,t1,1
        add t1,t1,t0
        slli t3,t0,3
        add t3,t3,s1
        ld t3,0(t3)
        slli t4,t1,3
        add t4,t4,s1
        ld t4,0(t4)
        slli t5,t2,3
        add t5,t5,s1
        ld t5,0(t5)
        beq s2,t4,found
        ble t3,t4,left_sorted
        right_sorted:
            bgt s2,t5,change_high
            ble s2,t4,change_high
            j change_low
        left_sorted:
            blt s2,t3,change_low
            bge s2,t4,change_low
            j change_high
        change_high:
            addi t2,t1,-1
            j search_loop
        change_low:
            addi t0,t1,1
            j search_loop
    not_found:
        li t1,-1
    found:
        mv a1,t1
        la a0,output
        call printf
        ld ra,80(sp)
        ld s0,64(sp)
        ld s1,48(sp)
        ld s2,32(sp)
        addi sp,sp,96
        mv a0,x0
        ret
