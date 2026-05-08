.globl main
.section .data

inp_fmt: .string "%ld %ld"
out_fmt: .string "%ld %ld %ld %ld\n"
price: .space 8
inserted: .space 8

.section .text

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    sd s5, 8(sp)
    sd s6, 0(sp)

    la a0, inp_fmt
    la a1, price
    la a2, inserted
    call scanf
    la t0, price
    ld s0, 0(t0)
    la t0, inserted
    ld s1, 0(t0)

    sub s2, s1, s0
    li t0, 25
    addi s3, t0, -25
twofives:
    blt s2, t0, buf1
    sub s2, s2, t0
    addi s3, s3, 1
    j twofives
buf1:
    li t0, 10
    addi s4, t0, -10
tens:
    blt s2, t0, buf2
    sub s2, s2, t0
    addi s4, s4, 1
    j tens

buf2:
    li t0, 5
    addi s5, t0, -5
fives:
    blt s2, t0, buf3
    sub s2, s2, t0
    addi s5, s5, 1
    j fives
buf3:
    addi s6, t0, -5
    mv s6, s2
    la a0, out_fmt
    mv a1, s3
    mv a2, s4
    mv a3, s5
    mv a4, s6
    call printf
end:
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)
    ld s5, 8(sp)
    ld s6, 0(sp)
    addi sp, sp, 64
    ret