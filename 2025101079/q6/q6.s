.section .data
    fmt_in: .string "%s"
    fmt_out: .asciz "%ld\n"
    buffer: .space 128

.globl main
.extern scanf
.extern printf

.section .text
main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s0,48(sp)    #pointer to current char
    sd s1,40(sp)    #current char
    sd s2,32(sp)    #operand a
    sd s3,24(sp)    #operand b
    sd s4,16(sp)    #result
    sd s5,8(sp)     #base address

    la a0,fmt_in
    la a1,buffer
    call scanf

    la s0,buffer
    mv s5,sp

loop:
    lbu s1,0(s0)
    li t0,0
    beq s1,t0,done
    li t0,'0'
    blt s1,t0,is_op
    li t0,'9'
    bgt s1,t0,is_op

    li t0,'0'
    sub s4,s1,t0
    addi sp,sp,-8
    sd s4,0(sp)
    j next_char

is_op:
    ld s3,0(sp)
    addi sp,sp,8
    ld s2,0(sp)
    addi sp,sp,8

    li t0,'+'
    beq s1,t0,do_add
    li t0,'-'
    beq s1,t0,do_sub
    li t0,'*'
    beq s1,t0,do_mul
    j next_char

do_add:
    add s4,s2,s3
    j push_result
 
do_mul:
    mul s4,s2,s3
    j push_result

do_sub:
    sub s4,s2,s3            #recheck

push_result:
    addi sp,sp,-8
    sd s4,0(sp)

next_char:
    addi s0,s0,1
    j loop

done:
    ld s4,0(sp)
    addi sp,sp,8
    la a0,fmt_out
    mv a1,s4
    mv sp,s5
    call printf

    ld ra,56(sp)
    ld s0,48(sp)    
    ld s1,40(sp)    
    ld s2,32(sp)    
    ld s3,24(sp)    
    ld s4,16(sp)    
    ld s5,8(sp)

    li a0,0
    ret
