.data
space: .string " "

.text
.globl main

main:
    li a7, 5
    ecall
    mv s2, a0

    li a7, 5
    ecall 
    mv s3, a0

greater:
    bge s2, s3, next

continue:
    li s4, 0
    mv s4, s2
    mv s2, s3
    mv s3, s4

next:
    mv t0, s2
    mv t1, s3

loop:
    rem t2, t0, t1
    beq t2, zero, gcd
    mv t0, t1
    mv t1, t2
    j loop

gcd:
    mv s5, t1

lcm:
    mv t4, s2
    mv t5, s3
    mv t6, s5
    mul t3, t4, t5
    div s6, t3, t6

output:
    mv a0, s5
    li a7, 1
    ecall

    la a0, space
    li a7, 4
    ecall 

    mv a0, s6
    li a7, 1
    ecall 

shutdown:
    li a7, 10
    ecall