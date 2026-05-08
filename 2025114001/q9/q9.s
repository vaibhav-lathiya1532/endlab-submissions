.section .rodata
int_fmt: .string "%lld"
true: .string "1\n"
false: .string "0\n"

.section .text
.globl main

main:
    addi sp, sp, -96
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)

    addi s1, sp, 56
    addi a1, sp, 56
    la a0, int_fmt
    call scanf
    ld s0, 0(s1)
    ld t0, 0(s1)

    li s1, 100
    li s2, 10
    li s3, 1 
    mv s4, x0

numloop:
    beq t0, s3, is_true
    beqz s1, is_false
    addi s1, s1, -1
    mv s4, x0

digloop:
    bge x0, t0, numdone
    rem t1, t0, s2
    div t0, t0, s2
    mul t1, t1, t1
    add s4, s4, t1
    j digloop

numdone:
    mv t0, s4
    j numloop

is_true:
    la a0, true
    call printf
    j end

is_false:
    la a0, false
    call printf

end:
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    addi sp, sp, 100
    ret



