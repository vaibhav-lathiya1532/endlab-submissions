.section .rodata
fmt_d:
    .string "%s"
fmt_out:
    .string "%ld\n"

.section .text
.globl main

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)
    sd s7, 8(sp)

    addi a0, x0, 101
    call malloc
    add s0, a0, x0

    la a0, fmt_d
    addi a1, s0, 0
    call scanf

    li t0, 0

oloop:
    add t1, s0, t0
    lbu t2, 0(t1)
    beqz t2, done

    li t3, '+'
    beq t2, t3, do_add
    li t3, '-'
    beq t2, t3, do_sub
    li t3, '*'
    beq t2, t3, do_mul

push_num:
    addi s1, t2, -48

    addi sp, sp, -8
    sd s1, 0(sp)

    j incre

do_add:
    ld t4, 0(sp)
    addi sp, sp, 8
    ld t5, 0(sp)
    addi sp, sp, 8
    add t4, t4, t5
    addi sp, sp, -8
    sd t4, 0(sp)

    j incre

do_mul:
    ld t4, 0(sp)
    addi sp, sp, 8
    ld t5, 0(sp)
    addi sp, sp, 8
    addi sp, sp, -8
    mul t4, t4, t5
    sd t4, 0(sp)

    j incre

do_sub:
    ld t4, 0(sp)
    addi sp, sp, 8
    ld t5, 0(sp)
    addi sp, sp, 8
    addi sp, sp, -8
    sub t4, t5, t4
    sd t4, 0(sp)

    j incre

incre:
    addi t0, t0, 1
    j oloop

done:
    ld a1, 0(sp)
    addi sp, sp, 8

    la a0, fmt_out
    call printf

    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    ld s6, 16(sp)
    ld s7, 8(sp)
    addi sp, sp, 80

    ret
