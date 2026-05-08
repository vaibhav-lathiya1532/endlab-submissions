.globl main

.section  .rodata

frm1: .string "%lld"
frm2: .string "%lld "
newline: .string "\n"

.section .text

main:
    addi sp, sp, -24
    sd ra, 16(sp)

    la a0, frm1
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)

    mul t0, s0, s0
    li t1, 8
    mul s4, t0, t1
    li t3, -1
    mul s5, t2, t3
    add sp, sp, s5
    addi s1, sp, 24

    li t0, 0
read_i:                                     #read elements
    bge a0, s0, finish
    li t1, 0
read_j:
    bge t1, s0, next_i
    li t3, 8
    mul t2, t0, s0
    add t2, t2, t1
    mul t2, t2, t3
    add t2, t2, s1

    la a0, frm1
    addi a1, t2, 0
    call scanf
    addi t1, t1, 1
    j read_j
next_i:
    addi t0, t0, 1
    j read_i

finish:                       #transpose
    li t0, 0
t_i:
    bge t0, s0, rev
    mv t1, t0
t_j:
    bge t1, s0, n_i
    li t3, 8
    mul t2, t0, s0
    add t2, t2, t1
    mul t2, t2, t3
    add t2, t2, s1
    ld t4, 0(t2)
    
    mul t5, t1, s0
    add t5, t5, t0
    mul t5, t5, t3
    add t5, t5, s1
    ld t6, 0(t5)

    sd t6, 0(t2)
    sd t4, 0(t5)
    addi t1, t1, 1
    j t_j
n_i:
    addi t0, t0, 1
    j t_i

rev:                                #reversing
    li t0, 0
    srli s3, s0, 1
go_i:
    bge t0, s0, print
    li t1, 0
go_j:
    bge t1, s3, go_nexti
    li t3, 8
    mul t2, t0, s0
    add t2, t2, t1
    mul t2, t2, t3
    add t2, t2, s1
    ld t4, 0(t2)

    mul t5, t0, s0
    add t5, t5, s0
    addi t5, t5, -1
    sub t5, t5, t1
    mul t5, t5, t3
    add t5, t5, s1
    ld t6, 0(t5)

    sd t6, 0(t2)
    sd t4, 0(t5)
    addi t1, t1, 1
    j go_j
go_nexti:
    addi t0, t0, 1
    j go_i

print:                                 #printing
    li t0, 0
p_i:
    bge t0, s0, exit
    li t1, 0
p_j:
    bge t1, s0, nline
    li t3, 8
    mul t2, t0, s0
    add t2, t2, t1
    mul t2, t2, t3
    add t2, t2, s1
    ld t4, 0(t2)

    la a0, frm2
    mv a1, t4
    call printf
    addi t1, t1, 1
    j p_j
nline:
    la a0, newline
    call printf
    addi t0, t0, 1
    j p_i

exit:
    add sp, sp, s4
    ld ra, 16(sp)
    addi sp, sp, 24
    ret
