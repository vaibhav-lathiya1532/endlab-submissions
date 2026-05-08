.section .rodata
fmt1: .asciz "%d"
fmt2: .asciz "%d\n"

.section .text
.globl main
main:
    add sp, sp, -64
    sd ra, 56(sp)
    sd s4, 48(sp)
    sd s3, 40(sp)
    sd s2, 32(sp)
    sd s1, 24(sp)
    sd s0, 16(sp)

    la a0, fmt1
    mv a1, sp
    call scanf

    lw s0, 0(sp)

    mv a0, s0
    slli a0, a0, 2
    call malloc

    mv s1, a0
    li s2, 0

loop:

    beq s2, s0, calc_prefix
    
    la a0, fmt1
    slli t0, s2, 2
    add t0, t0, s1
    mv a1, t0
    call scanf

    addi s2, s2, 1
    j loop

calc_prefix:

    mv a0, s0
    slli a0, a0, 2
    call malloc
    mv s2, a0

    li s4, 0
    li t0, 0

prefix_loop:
    bge t0, s0, calc_suffix

    slli t1, t0, 2
    add t1, t1, s1
    lw t1, 0(t1)

    slli t2, t0, 2
    add t2, t2, s2
    sw s4, 0(t2)

    add s4, s4, t1
    addi t0, t0, 1
    j prefix_loop

calc_suffix:

    mv a0, s0
    slli a0, a0, 2
    call malloc
    mv s3, a0

    li s4, 0
    mv t0, s0
    addi t0, t0, -1

suffix_loop:
    blt t0, x0, calc_ans

    slli t1, t0, 2
    add t1, t1, s1
    lw t1, 0(t1)

    slli t2, t0, 2
    add t2, t2, s3
    sw s4, 0(t2)

    add s4, s4, t1
    addi t0, t0, -1
    j suffix_loop

calc_ans:
    li s4, 0

compare:
    bge s4, s0, no_found

    # t0 = prefix[i]
    slli t0, s4, 2
    add t0, t0, s2
    lw t0, 0(t0)

    # t1 = suffix[i]
    slli t1, s4, 2
    add t1, t1, s3
    lw t1, 0(t1)

    beq t0, t1, found

    addi s4, s4, 1
    j compare

no_found:
    la a0, fmt2
    li a1, -1
    call printf
    j exit

found:
    la a0, fmt2
    mv a1, s4
    call printf
    j exit

exit:

    mv a0, s1
    call free

    mv a0, s2
    call free

    mv a0, s3
    call free

    ld ra, 56(sp)
    ld s4, 48(sp)
    ld s3, 40(sp)
    ld s2, 32(sp)
    ld s1, 24(sp)
    ld s0, 16(sp)
    add sp, sp, 64
    ret
