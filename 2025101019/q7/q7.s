.section .rodata
    fmt_input: .string "%lld"
    fmt_true: .string "TRUE\n"
    fmt_false: .string "FALSE\n"

.section .text
.globl main

main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s1, 16(sp)
    sd s0, 8(sp)
    la a0, fmt_input
    add a1, sp, zero
    call scanf
    ld s0, 0(sp)
    add t0, s0, zero
    add s1, zero, zero
    addi t6, zero, 10

length:
    beq t0, zero, disarium
    div t0, t0, t6
    addi s1, s1, 1
    jal zero, length

disarium:
    add t0, s0, zero # copy of orig number
    add t1, zero, zero  # new number

disarium_loop:
    beq t0, zero, disarium_end
    rem a0, t0, t6
    add a1, s1, zero
    jal ra, pow
    add t1, t1, a0
    div t0, t0, t6
    addi s1, s1, -1
    jal zero, disarium_loop

disarium_end:
    beq s0, t1, print_true

print_false:
    la a0, fmt_false
    call printf
    jal zero, end

print_true:
    la a0, fmt_true
    call printf

end:
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld ra, 24(sp)
    addi sp, sp, 32
    add a0, zero, zero
    jalr zero, 0(ra)

pow:
    addi t3, zero, 1

pow_loop:
    beq a1, zero, pow_end
    mul t3, t3, a0
    addi a1, a1, -1
    jal zero, pow_loop

pow_end:
    add a0, t3, zero
    jalr zero, 0(ra)
