.section .data
in: .asciz "%s"
out: .asciz "%lld\n"
str: .space 10000

.section .text
.globl main
main:
    addi sp, sp, -64
    sd s0, 56(sp)
    sd ra, 48(sp)
    la a0, in
    la a1, str
    call scanf

    la t0, str
    mv s0, sp

    la a0, out
    ld a1, 0(t0)
    call printf
    ret