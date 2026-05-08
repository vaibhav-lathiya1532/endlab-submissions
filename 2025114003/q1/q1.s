.section .data
input_fmt1: .string "%d"
input_fmt2: .string "%ld"
output_fmt1: .string "TRUE\n"
output_fmt2: .string "FALSE\n"

.section .bss
buffer: 800088

.section .text
.globl main

main:
    addi sp, sp, -16
    ld a1, 0(sp)
    la a0, input_fmt1
    call scanf

    ld s0, 0(sp) # s0 has N
    la s1, buffer

    addi t0, s0,0

take_input:

    ld a0, input_fmt2
    la a1, buffer
    call scanf
    addi, t0, t0, -1
    addi a1, a1, 8
    bnez t0, take_input

one_input:
    li s1,1;
    beq s0,s1, return_false







sd t2,0








return_true:
    ld a0, output_fmt1
    call printf

return_false:
    ld a0, output_fmt2
    call printf









