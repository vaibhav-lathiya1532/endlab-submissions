.section .rodata
    fmt_input: .string "%lld"
    fmt_true: .string "TRUE\n"
    fmt_false: .string "FALSE\n"

.section .text
.globl main

main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s2, 32(sp)
    sd s1, 24(sp)
    sd s0, 16(sp)

    la a0, fmt_input
    add a1, sp, zero
    call scanf
    ld s0, 0(sp)

    add a0, s0, zero
    slli a0, a0, 3
    call malloc
    add s1, a0, zero
    add s2, zero, zero

input_loop:
    bge s2, s0, check_first
    la a0, fmt_input
    slli a1, s2, 3
    add a1, s1, a1
    call scanf
    addi s2, s2, 1
    jal zero, input_loop

check_first:
    ld t0, 0(s1)
    slli t0, t0, 63
    srli t0, t0, 63
    addi s2, zero, 1

start_parity:
    xori t5, t0, 1

check_parity_loop:
    bge s2, s0, print_true
    slli t0, s2, 3
    add t0, s1, t0
    ld t1, 0(t0)
    slli t1, t1, 63
    srli t1, t1, 63
    bne t1, t5, print_false
    xori t5, t5, 1
    addi s2, s2, 1
    jal zero, check_parity_loop

print_false:
    la a0, fmt_false
    call printf
    jal zero, end

print_true:
    la a0, fmt_true
    call printf

end:
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    ld ra, 40(sp)
    addi sp, sp, 48
    add a0, zero, zero
    jalr zero, 0(ra)






