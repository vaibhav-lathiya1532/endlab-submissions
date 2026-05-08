.global main

.section .data
fmt_in: .string "%s"
fmt_out: .string "%ld\n"
buff: .space 104

.section .text

main:
    addi sp,sp,-24
    sd ra, 16(sp)
    sd s0, 8(sp)
    sd s1, 0(sp)

    la a0, fmt_in
    la a1, buff
    call scanf
    la s0, buff

loop:
    lb s1, 0(s0)
    addi s0, s0, 1
    beq s1, zero, done
    li t1, 42
    beq s1, t1, is_operator
    li t1, 43
    beq s1, t1, is_operator
    li t1, 45
    beq s1, t1, is_operator

digit:
    addi sp,sp,-8
    addi s1,s1,-48
    sd s1, 0(sp)
    j loop

is_operator:
    ld t1, 0(sp)
    ld t2, 8(sp)
    addi sp,sp,16
    li t0, 42
    beq s1, t0, multop
    li t0, 43
    beq s1, t0, addop
    sub t3, t2, t1
    addi sp,sp,-8
    sd t3, 0(sp)
    j loop

multop:
    addi sp,sp,-8
    mul t3, t2, t1
    sd t3, 0(sp)
    j loop

addop:
    addi sp,sp,-8
    add t3, t2, t1
    sd t3, 0(sp)
    j loop

done:
    la a0, fmt_out
    ld a1, 0(sp)
    addi sp,sp,8
    call printf

    ld ra, 16(sp)
    ld s0, 8(sp)
    ld s1, 0(sp)
    addi sp,sp,16

    ret
