.data
    n: .quad
    fmt_in: .asciz "%ld"
    fmt_out: .asciz "%ld\n"
    printzero: .asciz "0\n"
    printone: .asciz "1\n"

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmt_in
    la a1, n
    call scanf
    lw s1, n

    li s4, 100
    li s6, 1
    li s5, 10

start_h:
    mv s1, s0
    li s3, 0
    addi s4, s4, -1
    beqz s4, print_zero

count_loop:
    rem t2, s1, s5
    div s1, s1, s5

    mul t2, t2, t2
    add s3, t2, s3
    addi s0, s3, 0

    beq s6, s0, print_one
    beqz s1, start_h
    j count_loop

print_zero:
    la a0, printzero
    call printf
    j cleanup

print_one:
    la a0, printone
    call printf
    j cleanup

cleanup:
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
