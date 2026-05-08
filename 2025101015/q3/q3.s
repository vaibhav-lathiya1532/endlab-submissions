.section .text
.globl main

main:
    la a7, 5
    ecall

    mv s0, a0 #s0 = n

    addi t0, s0, 1
    slli t0, t0, 3 #t0 = (n+1)*8

    sub sp, sp, t0 #made space in stack
    la, a7, 5
    ecall
    mv 0(sp), a0

    li s1, 0 #s1 is the counter
    li s2, 0 #s2 holds sum

number_loop:
    addi s4, 0(sp), 0

    addi a0, s4, 0
    jal check_if_prime

    ld s5, a0
    beqz s5, next_number

    add s2, s2, s4

next_number:
    beq s1, s0, end_code

    addi s1, s1, 1
    j number_loop

check_if_prime:
    li t0, 2
    beq t0, a0, prime

    andi t0, a0, 1
    beqz t0, not_prime

    li t0, 3
    beq t0, a0, prime

    li t0, 5
    beq t0, a0, prime

    li t0, 7
    beq t0, a0, prime

    li t0, 11
    beq t0, a0, prime

    li t0, 13
    beq t0, a0, prime

    li t0, 17
    beq t0, a0, prime

    li t0, 19
    beq t0, a0, prime

    li t0, 23
    beq t0, a0, prime
    
    li t0, 29
    beq t0, a0, prime

    li t0, 31
    beq t0, a0, prime

    li t0, 37
    beq t0, a0, prime

    li t0, 41
    beq t0, a0, prime

    li t0, 43
    beq t0, a0, prime

    li t0, 47
    beq t0, a0, prime

    li t0, 53
    beq t0, a0, prime

    li t0, 59
    beq t0, a0, prime

    li t0, 61
    beq t0, a0, prime

    li t0, 67
    beq t0, a0, prime

    li t0, 71
    beq t0, a0, prime

    li t0, 73
    beq t0, a0, prime

    li t0, 79
    beq t0, a0, prime

    li t0, 83
    beq t0, a0, prime

    li t0, 89
    beq t0, a0, prime

    li t0, 91
    beq t0, a0, prime

    li t0, 93
    beq t0, a0, prime

    li t0, 97
    beq t0, a0, prime

    li t0, 101
    beq t0, a0, prime

prime:
    li a0, 1
    ret

not_prime:
    li a0, 0
    ret

end_code:
    add a0, s2, 0
    la a7, 1
    ecall

    ret
