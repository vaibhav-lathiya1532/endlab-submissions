.section .data
fmt: .asciz "%s"
fmt_out: .asciz "%lld\n"
buffer: .space 100

.text
.globl main
main:
mv s0,ra
mv s1,sp 

la a0, fmt
la a1, buffer
call scanf
la t0,buffer

loop:
    lb t1,0(t0)
    beq t1,x0,string_done

    li t2, '0'
    blt t1,t2,not_digit
    li t2, '9'
    bgt t1,t2,not_digit

    is_digit:
    addi t1,t1,-48
    addi sp,sp,-16
    sd t1,0(sp)
    j iterate

    not_digit:
    ld t3,0(sp)
    addi sp,sp,16
    ld t4,0(sp)
    addi sp,sp,16

    li t2, '+'
    beq t1,t2,add_op

    li t2, '-'
    beq t1,t2,sub_op

    li t2, '*'
    beq t1,t2,mul_op

    add_op:
    add t5,t3,t4
    j push

    mul_op:
    mul t5,t3,t4
    j push

    sub_op:
    sub t5,t4,t3
    j push

    push:
    addi sp,sp,-16
    sd t5,0(sp)

iterate:
addi t0,t0,1
j loop

string_done:
ld a1,0(sp)
la a0,fmt_out
call printf

mv sp,s1
mv ra,s0
li a0,0
ret




