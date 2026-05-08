.data
fmt_in: .string "%s"
fmt_out: .string "%d\n"
yes: .string "yes\n"
no: .string "no\n"
array: .space 101

.text
.globl main

main:
    addi sp , sp , -16
    sd ra , 8(sp)
    mv s0 , sp #points to the base of the stack

    la a0 , fmt_in
    la a1 , array
    call scanf
    la s1 , array #this is the base address of the array
    mv t0 , s1 #movable array pointer

array_loop:
    lb t1 , 0(t0)
    beq t1 , zero  , end
    li t2 , '9'
    li t3 , '0'
    addi t0 , t0 , 1
    bgt t1 , t2 , operator
    blt t1 , t3 , operator
    addi t1 , t1 , -'0'
    addi sp , sp , -8
    sd t1 , 0(sp)
    j array_loop

operator:
    ld t4 , 0(sp)
    addi sp , sp , 8

    ld t5 , 0(sp)
    addi sp , sp , 8

    li s2 , '+'
    li s3 , '-'
    li s4 , '*'
    
    beq t1 , s2 , add_op
    beq t1 , s3 , sub_op
    beq t1 , s4 , mul_op

add_op:
    add s5 , t5 , t4
    j npush

sub_op:
    sub s5 , t5 , t4
    j npush

mul_op:
    mul s5 , t5 , t4
    j npush

npush:
    addi sp , sp , -8
    sd s5 , 0(sp)
    j array_loop

end:
    ld t1 , 0(sp)
    addi sp , sp, 8
    la a0 , fmt_out
    mv a1 , t1
    call printf
    ld ra , 8(sp)
    addi sp , sp , 16
    ret
