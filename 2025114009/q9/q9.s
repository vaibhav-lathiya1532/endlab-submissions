.section .data

input_format: .string "%ld"
output_format: .string "%ld\n"

num: .space 8

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)
    addi sp, sp, -40

    sd s11, 32(sp)
    sd s10, 24(sp)
    sd s2, 16(sp)
    sd s1, 8(sp)
    sd s0, 0(sp)

    la a0, input_format
    la a1, num
    call scanf
    la s0, num
    ld s0, 0(s0)
    li s11, 0 # this has the number of iterations 
    li s10, 100
    li s1, 0 # number formed

loop:   
    li t0, 10
    beq s0, zero, reset
    rem s2, s0, t0 # s2 = last_dig
    mul s2, s2, s2 # s2 = last_dig^2
    div s0, s0, t0 # s0 /= 10
    add s1, s1, s2 # s1 += s2
    j loop
reset:
    li t0, 1
    beq s1, t0, happy_number
    bge s11, s10, unhappy_number
    addi s0, s1, 0
    li s1, 0
    addi s11, s11, 1
    j loop

happy_number:
    la a0, output_format
    li a1, 1
    call printf
    j exit_code
unhappy_number:
    la a0, output_format
    li a1, 0
    call printf
    j exit_code

exit_code:
    ld s11, 32(sp)
    ld s10, 24(sp)
    ld s2, 16(sp)
    ld s1, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 40

    ld ra, 8(sp)
    addi sp, sp, 16
    ret