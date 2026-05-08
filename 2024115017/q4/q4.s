.section .data
fmt_in: .string "%d %d"
fmt_out: .string "%d %d %d %d\n"
price: .space 4
inserted: .space 4
.section .text
.globl main
.extern scanf
.extern printf

main:
    addi sp,sp,-64
    sw ra,56(sp)
    sw s0,48(sp)
    sw s1,40(sp)
    sw s2,32(sp)
    sw s3,24(sp)
    sw s4,16(sp)

    la a0,fmt_in
    la a1,price
    la a2,inserted
    call scanf

    la t0,price 
    la t1,inserted
    lw t2,0(t0)
    lw t3,0(t1)
    sub s0,t3,t2 # s0=change
    
    
    li t6,25
    li t5,10
    li t4,5
    li t3,1

twenty_five:
    mv a0,s0
    mv a1,t6
    call div_rem
    mv s1,a0

mul a0,s1,t6
sub s0,s0,a0

ten:
    mv a0,s0
    mv a1,t5
    call div_rem
    mv s2,a0

mul a0,s2,t5
sub s0,s0,a0

five:
    mv a0,s0
    mv a1,t4
    call div_rem
    mv s3,a0

mul a0,s3,t4
sub s0,s0,a0

one:
    mv a0,s0
    mv a1,t3
    call div_rem
    mv s4,a0

mul a0,s4,t3
sub s0,s0,a0

print:
    la a0,fmt_out
    mv a1,s1
    mv a2,s2
    mv a3,s3
    mv a4,s4
    call printf

    lw s4,16(sp)
    lw s3,24(sp)
    lw s2,32(sp)
    lw s1,40(sp)
    lw s0,48(sp)
    lw ra,56(sp)
    addi sp,sp,64

    li a0,0
    ret





div_rem:
    li t0,0 # t0=quotient

div_rem_loop:
    blt a0,a1,div_rem_end # a0=change a1=coin
    sub a0,a0,a1
    addi t0,t0,1
    j div_rem_loop

div_rem_end:
    mv a0,t0
    ret