.text
.globl main

power:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd a0, 16(sp)
    sd a1, 8(sp)
    mv s0, a0
    li a0, 1
    li t0, 0
pow_loop:
    bge t0, a1, p_end
    mul a0, a0, s0
    addi t0, t0, 1
    j pow_loop

p_end:
    li a0, 0
    ld ra, 24(sp)
    ld a0, 16(sp)
    ld a1, 8(sp)
    addi sp, sp, 32
    ret


main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    sd s4, 0(sp)

    la a0, fmt_in
    la a1, N_inp
    call scanf
    la t0, N_inp
    ld s0, 0(t0)

    addi a0, x0, 80
    call malloc
    mv s3, a0

    li s1, 0
    mv t0, s0
    li t1, 10
    li s2, 0
div_ten:
    li t2, 0
sub_ten:
    blt t0, t1, next
    addi t0, t0, -10
    addi t2, t2, 1
    j sub_ten

next:
    beq t2, x0, rev
    addi s1, s1, 1
    slli t3, s2, 3
    add t3, t3, s3
    ld t0, 0(t3)
    mv t0, t2
    addi s2, s2, 1
    j div_ten

rev:
    li s2, 0
    mv t0, s1
    addi t0, t0, -1

rev_loop:
    bge s2, t0, list_form
    slli t1, s2, 3
    add t1, t1, s3
    sd t2, 0(t1)
    slli t3, t0, 3
    add t3, t3, s3
    sd t4, 0(t3)
    ld t2, 0(t3)
    ld t4, 0(t1)
    addi s2, s2, 1
    addi t0, t0, -1
    j rev_loop

list_form:
    li s2, 0
    li s4, 0

sum_f:
    bge s2, s1, check
    slli t2, s2, 3
    add t2, t2, s3
    ld t3, 0(t2)
    la a0, t3
    addi t4, s2, 1
    la a1, t4
    call power
    mv t0, a0
    add s4, s4, t0
    addi s2, s2, 1
    j sum_f

check:
    beq s4, s0, p_true
    la


    



.section .bss
N_inp: .quad 0

.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%s"
p_t: .string "TRUE"
p_f: .string "FALSE"