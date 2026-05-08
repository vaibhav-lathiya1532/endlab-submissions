.section .rodata
scanf_fmt: .string "%lld"
printf_val: .string "%lld "
printf_newline: .string "\n"
printf_debug: .string "DEBUG DEBUG DEBUG\n"

    .section .text
    .globl main
    .align 2

main:
    addi sp, sp, -96
    sd ra, 88(sp)
    sd s0, 80(sp)
    sd s1, 72(sp)
    sd s2, 64(sp)
    sd s3, 56(sp)
    sd s4, 48(sp)
    sd s5, 40(sp)
    addi s0, sp, 96

    la a0, scanf_fmt
    addi a1, sp, 24
    call scanf
    ld s0, 24(sp)

    # ------ s0 = n ------

    mul t0, s0, s0
    add t0, t0, sp
    call malloc
    mv s1, t0  # ------ s1 = base address of array ------

    li s2, 0
loop_read_i:
    bge s2, s0, end_read_i
    li s3, 0

loop_read_j:
    bge s3, s0, end_read_j

    la a0, scanf_fmt
    mul t0, s2, s0         # t0 = i*n
    add t0, t0, s3         # t0 = i*n + j
    slli t0, t0, 2         # t0 = (i*n + j)*4
    add t0, t0, s1
    call scanf

    addi s3, s3, 1
    j loop_read_j

end_read_j:
    addi s2, s2, 1
    j loop_read_i

end_read_i:
    li s2, 0

    la a0, printf_debug
    call printf

loop_transverse_i:
    bge s2, s0, end_transverse_i
    addi s4, s2, 1
    mv s3, s4

    la a0, printf_debug
    call printf

loop_transverse_j:
    bge s3, s0, end_transverse_j

    # ---- original matrix -------
    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 2
    add t0, t0, s1
    ld t1, 0(t0)

    # ---- transverse matrix ----
    mul t2, s3, s0       # t2 = j*n
    add t2, t2, s2       # t2 = j*n + i
    slli t2, t2, 2       # t2 = (j*n + i)*4
    add t2, t2, s1
    ld t3, 0(t2)

    # ---- swapping ----
    sd t1, 0(t2)
    sd t3, 0(t0)

    la a0, printf_debug
    call printf

    addi s3, s3, 1
    j loop_transverse_j

end_transverse_j:
    addi s2, s2, 1
    j loop_transverse_i

    la a0, printf_debug
    call printf

end_transverse_i:
    li s2, 0

    la a0, printf_debug
    call printf

loop_reverse_i:
    srli t4, s0, 1
    bge s2, t4, end_reverse_i
    li s3, 0

    la a0, printf_debug
    call printf

loop_reverse_j:
    bge s3, s0, end_reverse_j

    # ----- original matrix ----
    mul t2, s3, s0
    add t2, t2, s2
    slli t2, t2, 2
    add t2, t2, s1
    ld t3, 0(t2)

    # ---- reversed matrix ----
    mul t0, s3, s0    # t0 = j*n
    sub t1, s0, s3    # t1 = n - j
    addi t1, t1, -1   # t1 = n - j - 1
    add t0, t0, t1    # t0 = j*n + n - j - 1
    slli t0, t0, 2    # t0 = (j*n + n - j - 1)*4
    add t0, t0, s1
    ld t4, 0(t0)

    sd t3, 0(t0)
    sd t4, 0(t2)

    la a0, printf_debug
    call printf

    addi s3, s3, 1
    j loop_reverse_j

end_reverse_j:
    addi s2, s2, 1
    j loop_reverse_i

    la a0, printf_debug
    call printf

end_reverse_i:
    li s2, 0

    la a0, printf_debug
    call printf

loop_print_i:
    bge s2, s0, end_print_i
    li s3, 0

    la a0, printf_debug
    call printf

loop_print_j:
    bge s3, s0, end_print_j

    la a0, printf_val
    mul t0, s2, s0         # t0 = i*n
    add t0, t0, s3         # t0 = i*n + j
    slli t0, t0, 2         # t0 = (i*n + j)*4
    add t0, t0, s1
    call printf_val

    la a0, printf_debug
    call printf

    addi s3, s3, 1
    j loop_read_j

end_print_j:
    la a0, printf_newline
    call printf
    addi s2, s2, 1

    la a0, printf_debug
    call printf

    j loop_print_i
end_print_i:
    mv s1, t0
    call free

    ld ra, 88(sp)
    ld s0, 80(sp)
    ld s1, 72(sp)
    ld s2, 64(sp)
    ld s3, 56(sp)
    ld s4, 48(sp)
    ld s5, 40(sp)
    addi sp, sp, 96

    li a0, 0
    ret