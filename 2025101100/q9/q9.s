.section .data
    fmt_in: .asciz "%lld"
    fmt_out: .asciz "%lld\n"

.bss
    N_val: .space 8

.section .text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)
    sd s0, 0(sp)

    la a0, fmt_in
    la a1, N_val
    call scanf

    ld t0, N_val
    addi t1, x0, 10
    addi t2, x0, 100
    addi t3, x0, 1

loop:
    beqz t2, not_happy
    addi t4, x0, 0

calculate_sum:
    beqz t0, next_num
    rem t6, t0, t1
    div t0, t0, t1
    mul t6, t6, t6
    add t4, t4, t6
    j calculate_sum

next_num:
    beq t4, t3, happy
    addi t0, t4, 0
    addi t2, t2, -1
    j loop

not_happy:
    la a0, fmt_out
    addi a1, x0, 0
    call printf
    j end

happy:
    la a0, fmt_out
    addi a1, x0, 1
    call printf

end:
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    addi a0, x0, 0
    ret


