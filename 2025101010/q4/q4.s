.section .rodata 
input_format: .string "%lld%lld"
output_format: .string "%lld %lld %lld %lld\n"

.section .bss
.balign 4
price: .space 8
inserted: .space 8

.section .text

.globl main

custom_div:

    addi sp, sp, -112
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)
    sd s6, 56(sp)
    sd s7, 64(sp)
    sd s8, 72(sp)
    sd s9, 80(sp)
    sd s10, 88(sp)
    sd s11, 96(sp)

    mv s0, a0
    mv s1, a1
    li s2, 0


    beqz s0, __custom_div_oper_is_zero
    beqz s1, __custom_div_oper_is_zero

__custom_div_loop:
    blt s0, s1, __custom_div_setup_exit

    sub s0, s0, s1
    addi s2, s2, 1


    j __custom_div_loop

__custom_div_oper_is_zero:
    li a0, 0
    li a1, 0
    j __custom_div_exit

__custom_div_setup_exit:
    mv a0, s2
    mv a1, s0
    j __custom_div_exit

__custom_div_exit:
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    ld s7, 64(sp)
    ld s8, 72(sp)
    ld s9, 80(sp)
    ld s10, 88(sp)
    ld s11, 96(sp)
    addi sp, sp, 112

    ret

main:
    addi sp, sp, -112
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)
    sd s6, 56(sp)
    sd s7, 64(sp)
    sd s8, 72(sp)
    sd s9, 80(sp)
    sd s10, 88(sp)
    sd s11, 96(sp)

    la a0, input_format
    la a1, price
    la a2, inserted
    call scanf
    ld s0, price
    ld s1, inserted
    sub s0, s1, s0                      # s0 now holds change

    mv a0, s0
    li a1, 25
    jal custom_div
    mv s2, a0
    mv a0, a1
    li a1, 10
    jal custom_div
    mv s3, a0
    mv a0, a1
    li a1, 5
    jal custom_div
    mv s4, a0
    mv a0, a1
    li a1, 1
    jal custom_div
    mv s5, a0

    la a0, output_format
    mv a1, s2
    mv a2, s3
    mv a3, s4
    mv a4, s5
    call printf

    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    ld s7, 64(sp)
    ld s8, 72(sp)
    ld s9, 80(sp)
    ld s10, 88(sp)
    ld s11, 96(sp)
    addi sp, sp, 112

    ret

