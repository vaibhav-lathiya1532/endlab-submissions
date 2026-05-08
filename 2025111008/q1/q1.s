.data
    fmt_int: .asciz "%lld"
    fail_str: .string "FALSE\n"
    pass_str: .string "TRUE\n"

.text
.globl main

main:
    addi sp, sp, -32
    sd ra, 8(sp)

    la a0, fmt_int
    addi a1, sp, 16
    call scanf
    ld s0, 16(sp)

    j first

first:
    la a0, fmt_int
    addi a1, sp, 16
    call scanf
    ld s1, 16(sp)

    addi s0, s0, -1
    beqz s0, fail_print

    li t0, 2
    rem s2, s1, t0
    beqz s2, odd_check
    j even_check

odd_check:
    beqz s0, pass

    la a0, fmt_int
    addi a1, sp, 16
    call scanf
    ld s1, 16(sp)

    addi s0, s0, -1

    li t0, 2
    rem s2, s1, t0
    beqz s2, fail
    j even_check

even_check:
    beqz s0, pass

    la a0, fmt_int
    addi a1, sp, 16
    call scanf
    ld s1, 16(sp)

    addi s0, s0, -1

    li t0, 2
    rem s2, s1, t0
    beqz s2, odd_check
    j fail

fail:
    beqz s0, fail_print

    la a0, fmt_int
    addi a1, sp, 16
    call scanf
    ld s1, 16(sp)

    addi s0, s0, -1
    j fail

fail_print:
    la a0, fail_str
    call printf

    ld ra, 8(sp)
    addi sp, sp, 32
    
    li a0, 0
    ret

pass:
    la a0, pass_str
    call printf

    ld ra, 8(sp)
    addi sp, sp, 32

    li a0, 0
    ret