.data
    str: .space 128
    fmt: .string "%s"
    fmtout: .string "%ld\n"

.text

.globl main

main:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)
    sd s6, 56(sp)

    la a0, fmt
    la a1, str
    call scanf

    la s0, str

loop:
    lb s1, 0(s0)
    beqz s1, end
    addi s0, s0, 1
    li t0, '0'
    li t1, '9'
    blt s1, t0, not_num
    bgt s1, t1, not_num

    sub s1, s1, t0
    addi sp, sp, -8
    sd s1, 0(sp)
    j loop

not_num:
    li t0, '+'
    li t1, '-'
    li t2, '*'

    ld s2, 0(sp)
    addi sp, sp, 8
    ld s3, 0(sp)
    addi sp, sp, 8
    beq s1, t0, addem
    beq s1, t1, subem
    beq s1, t2, multem

addem:
    add s2, s3, s2
    addi sp, sp, -8
    sd s2, 0(sp)
    j loop

subem:
    sub s2, s3, s2
    addi sp, sp, -8
    sd s2, 0(sp)
    j loop

multem:
    mul s2, s3, s2
    addi sp, sp, -8
    sd s2, 0(sp)
    j loop

end:
    ld a1, 0(sp)
    addi sp, sp, 8
    la a0, fmtout
    call printf
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    addi sp, sp, 64
    ret
