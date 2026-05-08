.section data
fmt_in: .string "%d"
fmt_out: .string "%d\n"
N: .space 4
arr: .space 800
.section text
.globl main
.extern scanf
.extern printf

main:
    addi sp,sp,-48
    sw ra,40(sp)
    sw s0,32(sp)
    sw s1,24(sp)
    sw s2,16(sp)
    sw s3,8(sp)
    
    la a0,fmt_in
    la a1,N
    call scanf
    la t0,N
    mv s0,t0  # s0=N
    li t0,0
input_loop:
    beq t0,s0,input
    