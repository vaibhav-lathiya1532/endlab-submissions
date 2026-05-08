.section .rodata
fmt_in: .string "%d"
fmt_gcd: .string "%d "
fmt_lcm: .string "%d\n"

.data
n: .space 4

.section .text
.global main

main:
    addi sp, sp, -40
    sd ra, 32(sp)
    sd s0, 24(sp) #n1
    sd s1, 16(sp) #n2
    sd s2, 8(sp)  #gcd counter
    sd s3, 0(sp) #lcm counter

    la a0, fmt_in
    la a1, n
    call scanf
    ld s0, n

    la a0, fmt_in
    la a1, n
    call scanf
    ld s1, n

    bgt s0, s1, gcd1


    li t1, 1
    ld s2, s0

gcd0:
    beq s2, t1, print_gcd
    rem t0, s1, s2
    beqz t0, print_gcd

    addi s2, s2, -1
    j gcd0

gcd1:
    beq s2, t1, print_gcd
    rem t0, s0, s2
    beqz t0, print_gcd

    addi s2, s2, -1
    j gcd1

print_gcd:
    la a0, fmt_gcd
    la a1, s2
    call printf

    bgt s0, s1, lcm1
    mul t1, s0, s1
    ld s3, s1

lcm0:
    beq t1, s3, print_lcm
    rem t0, s3, s1
    beqz t0, print_lcm

    addi s3, s3, 1
    j lcm0

lcm1:
    beq t1, s3, print_lcm
    rem t0, s3, s0
    beqz t0, print_lcm

    addi s3, s3, 1
    j lcm1

print_lcm:
    la a0, fmt_lcm
    la a1, s3
    call printf

done:
    ld ra, 32(sp)
    ld s0, 24(sp) #n1
    ld s1, 16(sp) #n2
    ld s2, 8(sp)  #gcd counter
    ld s3, 0(sp) #lcm counter

    addi sp, sp, 40
