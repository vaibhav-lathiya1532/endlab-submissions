.section .data
fmt_in: .asciz "%lld"
out_true: .asciz "TRUE\n"
out_false: .asciz "FALSE\n"

.section .bss
.align 8
num: .skip 8

.section .text
.globl main
main:
    addi sp, sp, -16
    sd ra, 0(sp)

    la a0, fmt_in
    la a1, num
    call scanf

    la t0, num
    ld s0, 0(t0)
    li s1, 10

    li s2, 0
    mv t0, s0
count_loop:
    beqz t0, count_done
    divu t0, t0, s1
    addi s2, s2, 1
    j count_loop

count_done:
    mv t0, s0
    li s3, 0

outer_loop:
    beqz t0, outer_done
    remu t1, t0, s1
    divu t0, t0, s1
    mv t2, t1
    addi s2, s2, -1
    mv t3, s2
    j inner_loop

inner_loop:
    beqz t3, inner_done
    mul t2, t2, t1
    addi t3, t3, -1
    j inner_loop

inner_done:
    add s3, s3, t2
    j outer_loop

outer_done:
    beq s0, s3, is_dis
    j not_dis

is_dis:
    la a0, out_true
    j out

not_dis:
    la a0, out_false
    j out

out:
    call printf

    li a0, 0
    ld ra, 0(sp)
    addi sp, sp, 16
    ret
