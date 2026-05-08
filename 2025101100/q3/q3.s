.section .data
    fmt_in: .asciz "%lld"
    fmt_out: .asciz "%lld\n"

.bss
    N_val: .space 8
    num: .space 8
    arr: .space 80000

.section .text
.globl main

main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    

    la a0, fmt_in
    la a1, N_val
    call scanf

    ld s1, N_val
    la s0, arr
    addi s2, x0, 0

arr_input:
    bge s2, s1, sum_loop
    slli s2, s2, 3
    add s0, s0, s2
    la a0, fmt_in
    la a1, num
    call scanf
    ld s0, num
    addi s2, s2, 1
    j arr_input


    addi t2, x0, 0
    addi t1, x0, 0
    la s0, arr

sum_loop:
    bge t1, s1, done
    slli t1, t1, 3
    add s0, s0, t1
    addi t5, x0, 2
    ld t3, 0(s0)
    srai t4, t3, 1
    addi t4, t4, 1
    j check_prime

check_prime:
    bge t4, t5, is_prime
    rem t6, t3, t5
    beqz t6, not_prime
    addi t5, t5, 1
    j check_prime

not_prime:
    addi t1, t1, 1
    j sum_loop

is_prime:
    add t2, t2, t3
    addi t1, t1, 1
    j sum_loop

done:
    la a0, fmt_out
    addi a1, t2, 0
    call printf
    ld ra, 40(sp)
    ld s0, 32(sp)
    ld s1, 24(sp)
    ld s2, 16(sp)
    ld s3, 8(sp)
    addi sp, sp, 48
    ret









