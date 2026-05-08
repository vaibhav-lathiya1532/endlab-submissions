.section .bss
    buffer: .space 101

.section .data
    fmt_in: .string "%s"
    fmt_out: .string "%lld\n"

.section .text
.globl main

main:
    addi sp, sp, -16
    sd ra, 0(sp)
    sd s0, 8(sp)

    la a0, fmt_in
    la a1, buffer
    call scanf

    la s0, buffer               #s0 = string
    j loop

loop:
    lb t0, 0(s0)
    beq t0, zero, done
    li t1, '+'
    beq t0, t1, addops
    li t1, '*'
    beq t0, t1, mulops
    li t1, '-'
    beq t0, t1, subops
    addi t0, t0, -48
    j digit

digit:
    addi sp, sp, -8
    sd t0, 0(sp)
    addi s0, s0, 1
    j loop

addops:
    ld t1, 0(sp)
    ld t2, 8(sp)
    addi sp, sp, 16
    add t3, t1, t2
    addi sp, sp, -8
    sd t3, 0(sp)
    addi s0, s0, 1
    j loop

mulops:
    ld t1, 0(sp)
    ld t2, 8(sp)
    addi sp, sp, 16
    mul t3, t1, t2
    addi sp, sp, -8
    sd t3, 0(sp)
    addi s0, s0, 1
    j loop

subops:
    ld t1, 0(sp)
    ld t2, 8(sp)
    addi sp, sp, 16
    sub t3, t2, t1
    addi sp, sp, -8
    sd t3, 0(sp)
    addi s0, s0, 1
    j loop

done:
    la a0, fmt_out
    ld a1, 0(sp)
    call printf
    addi sp, sp, 8
    ld ra, 0(sp)
    ld s0, 8(sp)
    addi sp, sp, 16
    ret

