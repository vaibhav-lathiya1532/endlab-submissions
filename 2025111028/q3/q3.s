.data
    input: .asciz "%d"
    output: .asciz "%d\n"
    output_minus: .asciz "-1\n"

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, input
    call scanf
    mv s1, a1

    slli s2, s1, 2
    mv a0, s2
    call malloc
    mv s2, a0

    li s0, 0
    li s3, 0
    addi t6, s1, -1
    addi sp, sp, -8
    sd s3, 0(sp)

store_stack:
    beq s3, t6, start_compare

    slli t1, s3, 2
    add t1, s2, t1
    ld t5, 0(t1)

    addi sp, sp, -8
    sd t5, 0(sp)

    j store_stack

start_compare:
    li s3, 0
    addi t5, t6, 0

compare_loop:
    ld s6, 0(sp)
    addi sp, sp, 8

    beq s6, s3, success

    slli t1, s5, 2
    add t1, s2, t1
    ld t5, 0(t1)

    add t3, t3, t5
    addi t5, t5, -1
    j compare_loop

fail:
    la a0, output_minus
    call printf 
    j cleanup

success:
    mv a1, s5
    la a0, output
    call printf
    j cleanup

cleanup:
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
