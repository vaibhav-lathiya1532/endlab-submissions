.globl main

.section .data
num: .space 8
input: .string "%ld"
true: .string "TRUE"
false: .string "FALSE"

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

    la a0, input
    la a1, num
    call scanf

    la t0, num
    ld s0, 0(t0)
    li s1, 0
    mv t0, s0

count_bits:
    beq t0, zero, count_done
    li t1, 10
    div t0, t0, t1
    addi s1, s1, 1
    j count_bits

count_done:
    mv t0, s0
    li s2, 0
    li s3, 0

loop:
    beq t0, zero, check
    li t1, 10
    rem t2, t0, t1
    li t3, 1
    sub t4, s1, s3
pow_loop:
    beq t4, zero, pow_done
    mul t3, t3, t2
    addi t4, t4, -1
    j pow_loop
pow_done:
    add s2, s2, t3
    addi s3, s3, 1
    li t1, 10
    div t0, t0, t1
    j loop
check:
    beq s2, s0, print_true
    la a0, false
    call printf
    j done

print_true:
    la a0, true
    call printf

done:
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)
    ld s5, 8(sp)
    ld s6, 0(sp)
    addi sp, sp, 64
    li a0, 0
    ret

