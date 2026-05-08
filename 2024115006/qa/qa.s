.section .rodata
fmt_d:
    .string "%ld"
fmt_out:
    .string "%ld\n"

.section .text
.globl main

main:
    
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)


    la a0, fmt_d
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)


    addi t0, x0, 8
    mul a0, s0, t0
    call malloc
    add s1, a0, x0

    addi s2, x0, 0

sloop:
    bge s2, s0, sdone

    addi t0, x0, 8
    mul a1, s2, t0
    add a1, a1, s1
    
    la a0, fmt_d
    call scanf

    addi s2, s2, 1
    j sloop

sdone:

    addi s2, x0, 0
    addi s3, x0, 0

mloop:
    bge s2, s0, mdone

    addi t0, x0, 8
    mul t1, s2, t0
    add t1, t1, s1

    ld s4, 0(t1)
    addi t2, x0, 2

    li s6, 1
    beq s4, s6, is_one

check_prime:
    bge t2, s4, is_prime

    rem t3, s4, t2
    beq t3, x0, not_prime

    addi t2, t2, 1
    j check_prime

not_prime:
    addi s2, s2, 1
    j mloop

is_prime:
    addi s2, s2, 1
    add s3, s3, s4
    j mloop

is_one:
    addi s2, s2, 1
    j mloop

mdone:
    la a0, fmt_out
    addi a1, s3, 0
    call printf

    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    ld s6, 16(sp)
    addi sp, sp, 80

    ret
