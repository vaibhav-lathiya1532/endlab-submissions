.section .rodata
input:
    .string "%s"
output:
    .string "%lld\n"

.section .data
str:
    .space 128
.text
.globl main

main:
    addi sp, sp, -192
    
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd ra, 0(sp)
    sd s0, 24(sp)


    la a0, input
    addi a1, sp, 32
    call scanf
    addi s0, sp, 32

    li s2, -1

    li a0, 800
    call malloc
    mv s1, a0

    mv t0, s0;

loop:
    lb t1, 0(t0)
    beqz t1, done

    li t2, '+'
    beq t1, t2, plus

    li t2, '-'
    beq t1, t2, minus
;
    li t2, '*'
    beq t1, t2, mult

    addi t1, t1, -48
    addi s2, s2, 1
    slli t3, s2, 3
    add t3, t3, s1
    sd t1, 0(t3)
    addi t0, t0, 1
    j loop


minus:;
    slli t1, s2, 3
    add t1, t1, s1
    ld t2, 0(t1)
    addi s2, s2, -1
    slli t1, s2, 3
    add t1, t1, s1
    ld t3,0(t1)
    sub t3, t3, t2
    sd t3, 0(t1)
    addi t0, t0, 1
    j loop

plus:
    slli t1, s2, 3
    add t1, t1, s1
    ld t2, 0(t1)
    addi s2, s2, -1
    slli t1, s2, 3
    add t1, t1, s1
    ld t3,0(t1)
    add t3, t3, t2
    sd t3, 0(t1)
    addi t0, t0, 1
    j loop   

mult:
    slli t1, s2, 3
    add t1, t1, s1
    ld t2, 0(t1)
    addi s2, s2, -1
    slli t1, s2, 3
    add t1, t1, s1

    ld t3,0(t1)
    mul t3, t3, t2
    sd t3, 0(t1)
    addi t0, t0, 1
    j loop 


done:
    la a0, output
    ld a1, 0(s1)
    call printf
    ld ra, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    addi sp, sp, 192
    li a0, 0
    ret

