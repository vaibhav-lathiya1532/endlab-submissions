.data
fmt1: .string "%lld %lld"
fms0: .string "%lld %lld\n"

.globl main

.text

main:

addi sp, sp, -72
sd s0, 64(sp)
sd s1, 56(sp)
sd s2, 48(sp)
sd s3, 40(sp)
sd s4, 32(sp)
sd s5, 24(sp)
sd s6, 16(sp)

la a0, fmt1

addi a1, sp, 0
addi a2, sp, 8

call scanf

ld s0, 0(sp)
ld s1, 8(sp)

bgt s1, s0, no_swap

swap:
    mv t0, s0
    mv s0, s1
    mv s1, t0

prep:

    li t0, 0
    li t1, 1

    li s5, 0
    li s6, 0

    li t3, 0
    li t4, 0

    add t3, t3, s0
    add t4, t4, s1


no_swap:

    beq t1, t0, gcd_done_1

    rem t0, t4, t3

    beqz t0, gcd_done

    mv t4, t3
    mv t3, t0

    beqz s5, no_swap

gcd_done:

    mv s2, t3
    beqz s5, calc

gcd_done_1:

    li s2, 1
    beqz, s5, calc

calc:

    li t4, 1
    mul t4, s0, s1
    div t4, t4, s2

    mv s3, t4

print:



    la a0, fms0
    mv a1, s2
    mv a2, s3

    call printf

    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)

    addi sp, sp, 56
    ret

    




