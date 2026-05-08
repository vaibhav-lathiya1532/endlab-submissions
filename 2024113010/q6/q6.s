.section .bss
string: .space 104

.section .rodata
fmt1: .asciz "%s"
fmt2: .asciz "%lld\n"

.section .text
.globl main
main:
    add sp, sp, -64
    sd ra, 56(sp)
    sd s4, 48(sp)
    sd s3, 40(sp)
    sd s2, 32(sp)
    sd s1, 24(sp)
    sd s0, 16(sp)

    la a0, fmt1
    la a1, string
    call scanf

    la s0, string

    li s1, '+'
    li s2, '-'
    li s3, '*'

    mv s4, sp

    li t0, 0

loop:
    add t1, t0, s0
    lb t1, 0(t1)

    beq t1, x0, print

    beq t1, s1, sign
    beq t1, s2, sign
    beq t1, s3, sign

    addi sp, sp, -8
    addi t1, t1, -48
    sd t1, 0(sp)

    addi t0, t0, 1
    j loop

sign:
    ld t2, 0(sp)
    ld t3, 8(sp)
    addi sp, sp, 16

    beq t1, s1, plus
    beq t1, s2, minus
    beq t1, s3, multiply

plus:
    add t4, t3, t2
    addi sp, sp, -8
    sd t4, 0(sp)

    addi t0, t0, 1
    j loop

minus:
    sub t4, t3, t2
    addi sp, sp, -8
    sd t4, 0(sp)

    addi t0, t0, 1
    j loop

multiply:
    mul t4, t3, t2
    addi sp, sp, -8
    sd t4, 0(sp)

    addi t0, t0, 1
    j loop

print:
    ld t5, 0(sp)
    mv sp, s4
    la a0, fmt2
    mv a1, t5
    call printf

exit:
    ld ra, 56(sp)
    ld s4, 48(sp)
    ld s3, 40(sp)
    ld s2, 32(sp)
    ld s1, 24(sp)
    ld s0, 16(sp)
    add sp, sp, 64
    ret
    