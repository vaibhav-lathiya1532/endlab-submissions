 .text
 .globl main

main:
    li a7, 5
    ecall
    mv s0, a0

    li s1, 1
    li s2, 0

    mv t1, s0
    li t0, 0

read:
    beqz t1, print
    li a7, 5
    ecall
    mv t2, a0
    mv t3, a0
    addi t3, t3, -1
    beqz t3, read

prime:
    rem t4, t2, t3
    beqz t4, read
    addi t3, t3, -1
    bne t3, s1, prime
    add t0, t0, t2
    addi t1, t1, -1
    bge t1, s2, read

print:
    mv a0, t0
    li a7, 1
    ecall

end:
    li a7, 10
    ecall
    