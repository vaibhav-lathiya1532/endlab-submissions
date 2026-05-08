.section .rodata
fmt1:
    .string "%d"
fmt2:
    .string "%d\n"

.section .data
n:
    .space 8
num:
    .space 8

.section .text
.globl main
main:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)

    lla a0, fmt1
    lla a1, n
    call scanf

    lla s3, n
    ld s3, 0(s3)

    mv a0, s3
    slli a0, a0, 3
    call malloc

    mv s1, a0

    li s2, 0
    li s5, 0
    addi s4, s3, -1

input:
    beq s2, s3, hmm
    lla a0, fmt1
    lla a1, num
    call scanf

    lla t0, num
    ld t0, 0(t0)
    
    add s5, s5, t0
    
    slli t0, s2, 3
    add t0, s1, t0
    sd s5, 0(t0)

    addi s2, s2, 1
    j input


hmm:
    li s2, 0
    addi t0, s2, 1


hello:
    beq t0, s4, EXIT_FAIL

    addi t1, t0, -1
    slli t1, t1, 3
    add t1, s1, t1
    ld t1, 0(t1)

    slli t2, t0, 3
    add t2, s1, t2
    ld t2, 0(t2)
    sub t2, s5, t2

    beq t1, t2, EXIT_PASS

    addi t0, t0, 1
    j hello

EXIT_PASS:
    lla a0, fmt2
    mv a1, t0
    call printf

    ld s5, 48(sp)
    ld s4, 40(sp)
    ld s3, 32(sp)
    ld s2, 24(sp)
    ld s1, 16(sp)
    ld s0, 8(sp)
    ld ra, 0(sp)
    addi sp, sp, 64

    ret

EXIT_FAIL:
    lla a0, fmt2
    li a1, -1
    call printf

    ld s5, 48(sp)
    ld s4, 40(sp)
    ld s3, 32(sp)
    ld s2, 24(sp)
    ld s1, 16(sp)
    ld s0, 8(sp)
    ld ra, 0(sp)
    addi sp, sp, 64

    ret
