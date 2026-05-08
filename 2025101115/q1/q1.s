.section .data
fmt1: .string "%lld"
fmt2: .string "%lld\n"
.section .bss
N: .space 8
arr: .space 80000
.extern scanf
.extern printf
.section .text
.global main
main:
    addi sp,sp,-40
    sd ra,32(sp)
    sd s0,24(sp)
    sd s1,16(sp)
    sd s2,8(sp)
    sd s3,0(sp)
    la a0,fmt1
    la a1,N 
    call scanf
    ld s0,N 
    li s1,0
    li s2,0
    li s3,0
read_loop:
    bge s1,s0,read_done
    slli t0,s1,3
    la s6,arr
    add s6,s6,t0
    la a0,fmt1
    mv a1,s6
    call scanf
    ld t4,0(s6)
    bgt t4,s2,inc_s2
    bgt t4,s3,inc_s3
    addi s1,s1,1
    j read_loop
inc_s2:
    bgt s2,s3,inc1_s3
    mv s2,t4
    addi s1,s1,1
    j read_loop
inc1_s3:
     mv s3,s2
     mv s2,t4
     addi s1,s1,1
     j read_loop
inc_s3:
    beq s2,t4,no_change
    mv s3,t4
    addi s1,s1,1
    j read_loop
no_change:
    addi s1,s1,1
    j read_loop
read_done:
    la a0,fmt2
    mv a1,s3
    call printf
    ld ra,32(sp)
    ld s0,24(sp)
    ld s1,16(sp)
    ld s2,8(sp)
    ld s3,0(sp)
    addi sp,sp,40
    ret

