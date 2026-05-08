.data

n: .word 0
matrix: .space 4000000
i: .quad 0

fmt_in: .asciz "%d"
fmt_out: .asciz "%d "
fmt_newline: .asciz "\n"

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmt_in
    la a1, n

    call scanf

    la s1, n 
    lw s1, 0(s1) # s1 = n
    la s0, matrix

    li t0, 0 # i=0

read_i:
    bge t0, s1, done_read
    li t1, 0 # j=0

read_j:
    bge t1, s1, done_j_read
    
    mul t3, t0, s1
    add t3, t3, t1
    slli t3, t3, 2
    add t3, t3, s0

    add sp, sp, -24
    sd t0, 8(sp)
    sd t1, 16(sp)

    la a0, fmt_in
    mv a1, t3
    call scanf

    ld t0, 8(sp)
    ld t1, 16(sp)
    addi sp, sp, 24

    addi t1, t1, 1

    j read_j

done_j_read:
    addi t0, t0, 1
    j read_i

done_read:
    li t0, 0 # i=0

trans_i:
    bge t0, s1, done_trans
    addi t1, t0, 1 #j=i+1

trans_j:
    bge t1, s1, done_j_trans

    mul t3, t0, s1
    add t3, t3, t1
    slli t3, t3, 2
    add t3, t3, s0 # t3 = address of i*n + j * 4 + base

    mul t4, t1, s1
    add t4, t4, t0
    slli t4, t4, 2
    add t4, t4, s0 # t4 = transpose elemt of t3

    lw t2, 0(t3) 
    lw t5, 0(t4)

    sw t2, 0(t4)
    sw t5, 0(t3)

    addi t1, t1, 1

    j trans_j

done_j_trans:
    addi t0, t0, 1
    j trans_i

done_trans:
    li t0, 0 # i=0
    srli s2, s1, 1 # s2 = n/2

rev_i:
    bge t0, s1, done_rev
    li t1, 0 # j=0

rev_j:
    bge t1, s2, done_j_rev

    mul t3, t0, s1
    add t3, t3, t1
    slli t3, t3, 2
    add t3, t3, s0 # t3 = address of i*n + j * 4 + base

    mul t4, t0, s1
    add t4, t4, s1
    addi t4, t4, -1
    li t5, -1
    mul t5, t1, t5
    add t4, t4, t5
    slli t4, t4, 2
    add t4, t4, s0 #rev element of above

    lw t2, 0(t3) 
    lw t5, 0(t4)

    sw t2, 0(t4)
    sw t5, 0(t3)

    addi t1, t1, 1

    j rev_j

done_j_rev:
    addi t0, t0, 1
    j rev_i

done_rev:
    li t0, 0 # i=0, time for output

print_i:
    bge t0, s1, exit
    li t1, 0 # j=0

print_j:
    bge t1, s1, print_j_done

    mul t3, t0, s1
    add t3, t3, t1
    slli t3, t3, 2
    add t3, t3, s0

    lw t3, 0(t3)
    mv a1, t3

    add sp, sp, -24
    sd t0, 8(sp)
    sd t1, 16(sp)

    la a0, fmt_out
    call printf

    ld t0, 8(sp)
    ld t1, 16(sp)
    addi sp, sp, 24

    addi t1, t1, 1
    j print_j
print_j_done:
    add sp, sp, -24
    sd t0, 8(sp)
    sd t1, 16(sp)

    la a0, fmt_newline
    call printf

    ld t0, 8(sp)
    ld t1, 16(sp)
    addi sp, sp, 24

    addi t0, t0, 1
    j print_i

exit:
    ld ra, 8(sp)
    addi sp, sp, 16
    ret

