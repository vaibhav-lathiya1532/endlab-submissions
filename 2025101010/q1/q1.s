.globl main

.section .rodata
input_format: .string "%lld"
output_format: .string "%lld\n"

.section .bss
.balign 4
N: .space 8

.section .text

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
    la a1, N 
    call scanf
    ld s0, N                        # holds n, the number of array elements

    li s1, 0
    li s2, -1000003                 # second_largest
    li s3, -1000003                 # largest

__main_input_loop:
    bge s1, s0, __main_output

    la a1, N
    la a0, input_format
    call scanf
    ld s4, N

    bge s4, s3, __main_replace_largest
    bge s4, s2, __main_replace_second_largest

__main_continue_input_loop:
    addi s1, s1, 1
    j __main_input_loop

__main_replace_largest:
    mv s2, s3
    mv s3, s4
    j __main_continue_input_loop

__main_replace_second_largest:
    mv s2, s4
    j __main_continue_input_loop

__main_output:
    la a0, output_format
    mv a1, s2
    call printf

__main_exit:
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





