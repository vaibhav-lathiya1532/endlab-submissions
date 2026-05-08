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
    mv t0, s0

    j scan_start
scan_start:

    beqz s0, done_valid
    la a0, fmt_in
    la a1, num
    call scanf

    la t1, num
    ld s1, 0(t1)
    li s2, 2
    addi s0, s0, -1

    remu t2, s1, s2
    beqz t2, was_even
    j was_odd

was_even:
    beqz s0, done_valid

    la a0, fmt_in
    la a1, num
    call scanf

    la t1, num
    ld s1, 0(t1)
    li s2, 2
    addi s0, s0, -1

    remu t2, s1, s2
    beqz t2, done_invalid
    j was_odd


was_odd:
    beqz s0, done_valid

    la a0, fmt_in
    la a1, num
    call scanf

    la t1, num
    ld s1, 0(t1)
    li s2, 2
    addi s0, s0, -1

    remu t2, s1, s2
    beqz t2, was_even
    j done_invalid

done_valid:
    la a0, out_true
    j out

done_invalid:
    la a0, out_false
    j out

out:
    call printf

    li a0, 0
    ld ra, 0(sp)
    addi sp, sp, 16
    ret
