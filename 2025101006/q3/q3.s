.global main

.section .data
fmt_in: .string "%ld"
fmt_out: .string "%ld\n"
n: .space 8

.section .text

main:
    addi sp,sp,-40
    sd s3, 32(sp)
    sd ra, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)
    sd s5, 0(sp)
    
    la a0, fmt_in
    la a1, n
    call scanf

    ld s0, n
    li s1, 0

loop:
    beq s0,s1, done
    la a0, fmt_in
    la a1, n
    call scanf
    ld s3, n
    li t0, 2
    j prime_check

prime_check:
    beq s3, t0, prime
    rem t1, s3, t0
    li t2, 0
    beq t1, t2, iterate
    addi t0, t0, 1
    j prime_check

prime:
    add s5, s5, s3

iterate:
    addi s1,s1,1
    j loop

done:
    la a0, fmt_out
    mv a1, s5
    call printf
    
    ld s3, 32(sp)
    ld ra, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    ld s5, 0(sp)
    addi sp,sp,40





