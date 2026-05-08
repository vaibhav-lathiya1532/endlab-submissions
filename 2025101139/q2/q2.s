.data
n: .quad 0
m: .quad 0

fmt_in: .asciz "%d %d"
fmt_out: .asciz "%d %d\n"

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmt_in
    la a1, m
    la a2, n
    call scanf

    la s0, m
    ld s0, 0(s0)

    la s1, n
    ld s1, 0(s1)

    mv t0, s0
    mv t1, s1

euclid:
    beqz t1, lcm
    rem t3, t0, t1
    mv t0, t1
    mv t1, t3
    j euclid

lcm:
    mul t1, s0, s1
    div t1, t1, t0

exit:
    la a0, fmt_out
    mv a1, t0
    mv a2, t1
    call printf
    ld ra, 8(sp)
    addi sp, sp, 16
    ret

