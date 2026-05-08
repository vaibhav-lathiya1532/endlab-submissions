.section .rodata
input_fmt: .string "%s"
output_fmt: .string "%lld\n"

.bss
buffer: .space 101

.text
.globl main
main:
    addi sp, sp, -32
    sd ra, (sp)
    sd s1, 8(sp)
    sd s2, 16(sp)

    la a0, input_fmt
    la a1, buffer
    call scanf

    la s1, buffer

    lb s2, (s1)

iterate:
    beq s2, x0, end_iterate

    li t0, '+'
    beq s2, t0, handle_add
    li t0, '-'
    beq s2, t0, handle_sub
    li t0, '*'
    beq s2, t0, handle_mul

    li t0, '0'
    sub s2, s2, t0

    addi sp, sp, -8
    sd s2, (sp)

    j cont_iterate


handle_add:
    ld t0, (sp)
    addi sp, sp, 8
    ld t1, (sp)

    add t0, t0, t1

    sd t0, (sp)

    j cont_iterate

handle_sub:
    ld t0, (sp)
    addi sp, sp, 8
    ld t1, (sp)

    sub t0, t1, t0

    sd t0, (sp)

    j cont_iterate

handle_mul:
    ld t0, (sp)
    addi sp, sp, 8
    ld t1, (sp)

    mul t0, t1, t0

    sd t0, (sp)

    j cont_iterate


cont_iterate:
    addi s1, s1, 1
    lb s2, (s1)
    j iterate

end_iterate:
    ld a1, (sp)
    addi sp, sp, 8

    la a0, output_fmt

    call printf

return:
    ld ra, (sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    addi sp, sp, 32
    li a0, 0
    ret
