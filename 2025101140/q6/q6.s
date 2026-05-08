.section .rodata
fmt1:
    .string "%s"
fmt2:
    .string "%lld\n"

.section .data
str:
    .space 105

.section .text
.globl main
main:
    addi sp, sp, -32
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)

    lla a0, fmt1
    lla a1, str
    call scanf

    lla s0, str
    li s1, 0

parsing:
    add t0, s0, s1
    lbu t0, 0(t0)
    beq t0, zero, EXIT

    li t1, '0'
    li t2, '9'

    blt t0, t1, calc
    bgt t0, t2, calc

    addi sp, sp, -8
    addi t0, t0, -48
    sd t0, 0(sp)

    addi s1, s1, 1
    j parsing

calc:
    ld t2, 0(sp)
    addi sp, sp, 8

    ld t1, 0(sp)
    addi sp, sp, 8

    li t3, '+'
    beq t0, t3, addition

    li t3, '-'
    beq t0, t3, subtraction

    mul t3, t1, t2
    
    addi sp, sp, -8
    sd t3, 0(sp)
    
    addi s1, s1, 1
    j parsing

addition:
    add t3, t1, t2

    addi sp, sp, -8
    sd t3, 0(sp)

    addi s1, s1, 1
    j parsing

subtraction:
    sub t3, t1, t2

    addi sp, sp, -8
    sd t3, 0(sp)

    addi s1, s1, 1
    j parsing

EXIT:
    lla a0, fmt2
    ld a1, 0(sp)
    addi sp, sp, 8
    call printf

    ld s1, 16(sp)
    ld s0, 8(sp)
    ld ra, 0(sp)
    addi sp, sp, 32

    ret
