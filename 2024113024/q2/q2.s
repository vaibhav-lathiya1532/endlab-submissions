.data
input: .asciz "%lld %lld"
output: .asciz "%lld %lld\n"
m: .space 8
n: .space 8

.text
.globl main

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)


    la a0, input
    la a1, m
    la a2, n
    call scanf
    
    la a1, m
    ld s0, 0(a1) #s0 stores m

    la a1, n
    ld s1, 0(a1) # s1 stores n

    li t0, 0 #to store gcd

find_gcd:
    bgt t0, s0, print
    bgt t0, a1, print
    rem t1, s0, t0 #t1 is remainder of m/t0
    beqz t1, check2
    addi t0, t0, 1
    j find_gcd

check2:
    rem t1, s1, t0
    beqz t1, gcd
    addi t0, t0, 1
    j find_gcd

gcd:
    mv s2, t0
    addi t0, t0, 1
    j find_gcd


print:
    mul t0, s0, s1 #t0 is lcm*hcf
    div s3, t0, s2 # so now s3 is lcm


    la a0, output
    addi a1, s2, 0
    addi a2, s3, 0
    call printf




end:
    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    addi sp, sp, 80

    li a7, 93
    li a0, 0
    ecall

