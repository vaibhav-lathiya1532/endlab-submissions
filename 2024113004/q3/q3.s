.section .rodata
long_long_fmt: .string "%lld"
output_fmt: .string "%lld\n"

.bss
N: .space 8

.text
.globl main
main:
    addi sp, sp, -64
    sd ra, (sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)

    la a0, long_long_fmt
    la a1, N
    call scanf

    la s1, N
    ld s1, (s1)

    slli a0, s1, 3
    call malloc

    mv s2, a0

    li s3, 0

input_loop:
    bge s3, s1, end_input_loop

    la a0, long_long_fmt

    slli a1, s3, 3
    add a1, s2, a1

    call scanf

    addi s3, s3, 1
    j input_loop

end_input_loop:
    li s3, 0
    li a1, -1

find_pivot:
    bge s3, s1, end_find_pivot

    li s4, 0
    li s5, 0

left_sum:
    bge s4, s3, end_left_sum

    slli t0, s4, 3
    add t0, s2, t0
    ld t0, (t0)

    add s5, s5, t0

    addi s4, s4, 1
    j left_sum

end_left_sum:
    addi s4, s3, 1
    li s6, 0

right_sum:
    bge s4, s1, end_right_sum

    slli t0, s4, 3
    add t0, s2, t0
    ld t0, (t0)

    add s6, s6, t0

    addi s4, s4, 1
    j right_sum

end_right_sum:

    beq s5, s6, found_pivot

    addi s3, s3, 1
    j find_pivot

found_pivot:
    mv a1, s3

end_find_pivot:
    la a0, output_fmt
    call printf

return:
    ld ra, (sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    addi sp, sp, 64
    li a0, 0
    ret
