.section .rodata
input: .string "%lld %lld"
output: .string "%lld %lld"

.section .text
.globl main

main:
    addi sp, sp, 64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)

    lla a0, input
    addi a1, sp, 32
    addi a2, sp, 24
    call scanf

    ld t0, 32(sp) # a
    ld t1, 24(sp) # b
    
    mul s1, t0, t1
    
    bgt t0, t1, gcd
    mv t2, t0
    mv t0, t1
    mv t1, t2

    
gcd:
    li t3, 1
    rem t2, t0, t1
    blt t2, t3, lcm
    mv t0, t1
    mv t1, t2
    j gcd
lcm:
    div t3, s1, t1

    lla a0, output
    mv a1, t1
    mv a2, t3 
    call printf

    ld s1, 40(sp)
    ld s0, 48(sp)
    ld ra, 56(sp)
    addi sp, sp, 64
    li a0, 0
    ret