.section .data
    fmt_in : .string "%d"
    fmt_true : .string "TRUE"
    fmt_false : .string "FALSE"

.section .bss
    n : .word 0
    x : .word 0

.section .text
.globl main

main:
    addi sp,sp,-80
    sd ra, 72(sp)
    sd s7, 64(sp)
    sd s6, 56(sp)
    sd s5, 48(sp)
    sd s4, 40(sp)
    sd s3, 32(sp)
    sd s2, 24(sp)
    sd s1, 16(sp)
    sd s0, 8(sp)

    la a0, fmt_in
    la a1, n
    call scanf
    lw s0, n                  # s0 = n
    li s1, 0                  # s1 = even
    li s2, 1                  # s2 = i

    la a0, fmt_in
    la a1, x
    call scanf
    lw s3, x 

    li t0, 2
    rem t1, s3, t0
    beqz t1, startup

    j for_loop

startup:
    li s1, 1

for_loop:
    bge s2, s0, print_true
    addi s2,s2,1

    la a0, fmt_in
    la a1, x
    call scanf
    lw s3, x            # s3 = x

    li t0, 2
    rem t1, s3, t0
    beqz t1, first_if
    j second_if

first_if:
    beqz s1, first_sub_if
    j print_false

first_sub_if:
    li s1, 1
    j for_loop

second_if:
    beqz s1, print_false
    li s1, 0
    j for_loop

print_false:
    la a0, fmt_false
    call printf
    j return

print_true:
    la a0, fmt_true
    call printf


return:
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    ld s7, 64(sp)
    ld ra, 72(sp)
    addi sp,sp,80

    li a0, 0
    ret

    