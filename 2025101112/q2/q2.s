.section .data
    fmt_in : .string "%lld %lld"
    fmt_out : .string "%lld %lld\n"

.section .text

.globl main

main:
    addi sp, sp, -48   #Need to clear 48 later on
    sd x1, 24(sp)      

    la x10, fmt_in
    addi x11, sp, 0    #x11 and now x12 have the addresses
    addi x12, sp, 8
    call scanf

    ld x11, 0(sp)
    ld x12, 8(sp)

    call find_gcd
    mv x11, x10
    ld x16, 0(sp)
    ld x17, 8(sp)
    mul x12, x16, x17
    div x12, x12, x11

    la x10, fmt_out
    call printf

    ld x1, 24(sp)
    addi sp, sp, 48
    ret

find_gcd:
    li x13, 1
    li x14, 0
    beq x12, x13, return_one
    beq x12, x14, return_first_number
    rem x15, x11, x12
    mv x11, x12
    mv x12, x15
    j find_gcd

return_one:
    li x10, 1
    ret

return_first_number:
    mv x10, x11
    ret




