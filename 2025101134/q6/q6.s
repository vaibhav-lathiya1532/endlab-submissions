.section .data
input_fmt: .asciz "%s"
output_fmt: .asciz "%lld\n"

.section .text
.globl main
.extern printf
.extern scanf
.extern malloc
.extern free

main:
    addi sp,sp,-32
    sd ra,24(sp)
    sd s0,16(sp)
    sd s1,8(sp)
    sd s2,0(sp)

    li t0,128
    mv a0,t0
    call malloc
    mv s0,a0

    la a0,input_fmt
    mv a1,s0
    call scanf

    mv s1,s0

loop:
    lb t0,0(s0)
    beqz t0,done

    li t1,42 #multiply
    beq t0,t1,multiply

    li t1,43 #addition
    beq t0,t1,addition

    li t1,45 #subtract
    beq t0,t1,subtract

    addi t0,t0,-48
    j number

number:
    addi sp,sp,-16
    sd t0,0(sp)
    j loop_plus

addition:
    ld t2,0(sp)
    addi sp,sp,16
    ld t3,0(sp)
    addi sp,sp,16

    add t2,t3,t2
    addi sp,sp,-16
    sd t2,0(sp)
    j loop_plus

subtract:
    ld t2,0(sp)
    addi sp,sp,16
    ld t3,0(sp)
    addi sp,sp,16

    sub t2,t3,t2
    addi sp,sp,-16
    sd t2,0(sp)
    j loop_plus

multiply:
    ld t2,0(sp)
    addi sp,sp,16
    ld t3,0(sp)
    addi sp,sp,16

    mul t2,t3,t2
    addi sp,sp,-16
    sd t2,0(sp)
    j loop_plus

loop_plus:
    addi s0,s0,1
    j loop

done:
    ld t6,0(sp)
    addi sp,sp,16

    la a0,output_fmt
    mv a1,t6
    call printf

    mv a0,s1
    call free

    ld ra,24(sp)
    ld s0,16(sp)
    ld s1,8(sp)
    ld s2,0(sp)
    addi sp,sp,32

    ret

