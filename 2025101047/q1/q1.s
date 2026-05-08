.section .rodata
    inputnum: .string "%lld"
    inputf: .string "%lld"
    outputf: .string "%lld\n"

.section .data
    array: .space 816

.section .text
.globl main

main:
    addi sp,sp,-80
    sd ra,0(sp)
    sd s0,8(sp)
    sd s1,16(sp)
    sd s2,24(sp)
    sd s3,32(sp)
    sd s4,40(sp)
    sd s5,48(sp)
    sd s6,56(sp)
    sd s7,64(sp)

    la a0,inputnum
    addi a1,sp,72
    call scanf
    ld s0,72(sp)    #s0=n
    li s1,0
    la s2,array     #array address

inputloop:
    beq s1,s0,main_logic
    la a0,inputf
    addi t0,s1,0
    slli t0,t0,3
    add t0,t0,s2
    mv a1,t0
    call scanf
    addi s1,s1,1
    j inputloop

main_logic:
    li s6,-10000000
    li s7,-10000000
    li s1,0

logic:
    beq s1,s0,exit_all
    addi t0,s1,0
    slli t0,t0,3
    add t0,t0,s2
    ld s5,0(t0)
    addi s1,s1,1
    bgt s5,s6,greaterthanmax
    bgt s5,s7,notgreaterthanmax
    j logic

greaterthanmax:
    add s7,s6,x0
    add s6,s5,x0
    j logic

notgreaterthanmax:
    beq s5,s6,logic
    mv s7,s5
    j logic

exit_all:
    la a0,outputf
    add a1,x0,s7
    call printf
    ld ra,0(sp)
    ld s0,8(sp)
    ld s1,16(sp)
    ld s2,24(sp)
    ld s3,32(sp)
    ld s4,40(sp)
    ld s5,48(sp)
    ld s6,56(sp)
    ld s7,64(sp)
    addi sp,sp,80
    ret
