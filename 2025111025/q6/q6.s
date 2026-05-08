.section .rodata
input_fmt: .string "%lld"
output_fmt: .string "%s"

.section .bss
temp: .space 101

.section .text
.globl main

main:
    addi sp,sp,-8
    sd ra,0(sp)

    la a0,input_fmt
    la a1,temp
    call scanf

    la s0,temp
    addi s1,x0,0
   # addi s2, x0,0
    addi s3,x0 ,43
    addi s4,x0,45
    addi s5,x0,42
    addi s6,x0,47

loop_back:
    lb t0,0(s0)
    beq t0,x0,end
    beq t0,s3,addition
    beq t0,s4,subtract
    beq t0,s5,multiplication
    beq t0,s6,division
    j else

addition:
    ld t1,0(sp)
    addi sp, sp ,8
    ld t2,0(sp)
    addi sp,sp,8
    add t3,t2,t1
    addi sp,sp,-8
    sd t3,0(sp)
    addi s1,s1,-8
    j stack_loop

subtract:
    ld t1,0(sp)
    addi sp, sp ,8
    ld t2,0(sp)
    addi sp,sp,8
    sub t3,t2,t1
    addi sp,sp,-8
    sd t3,0(sp)
    addi s1,s1,-8
    j stack_loop

multiplication:
    ld t1,0(sp)
    addi sp, sp ,8
    ld t2,0(sp)
    addi sp,sp,8
    mul t3,t2,t1
    addi sp,sp,-8
    sd t3,0(sp)
    addi s1,s1,-8
    j stack_loop

division:
    ld t1,0(sp)
    addi sp, sp ,8
    ld t2,0(sp)
    addi sp,sp,8
    div t3,t2,t1
    addi sp,sp,-8
    sd t3,0(sp)
    addi s1,s1,-8
    j stack_loop

else:
    addi sp,sp,-8
    addi s1,s1,8
    addi t0,t0,-4
    sd t0,0(sp)
    j stack_loop

stack_loop:
    addi s0,s0,1
    j loop_back

end:
    la a0,output_fmt
    ld a1,0(sp)
    call printf
    add sp,sp,s1
    ld ra,0(sp)
    addi sp,sp,8
    ret
