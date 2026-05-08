.section .data
fmt_in: .asciz "%d"
fmt_out: .asciz "%d "
newline: .asciz "\n"

.section .bss
temp: .space 4
arr: .space 4000000

.section .text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmt_in
    la a1, temp
    call scanf

    la t0, temp
    lw s0, 0(t0)
    la s1, arr
    #s0 is arr size

    add t0, x0, x0

read_out:
    bge t0, s0, done_read
    add t1, x0, x0
    

read_in:
    bge t1, s0, next_row
    add t2, x0, t0
    mul t2, s0, t2
    add t2, t2, t1
    slli t2, t2, 2
    add t2, s1, t2

    la a0, fmt_in
    la a1, temp
    call scanf

    la t3, temp
    lw t4, 0(t3)

    sw t4, 0(t2)
    addi t1, t1, 1
    beq x0, x0, read_in

next_row:
    addi t0, t0, 1
    beq x0, x0, read_out

done_read:
    add t0, x0, x0
    

tr_out:
    bge t0, s0, done_tr
    add t1, x0, x0
  

tr_in:
    ble t1, t0, next_col_tr
    bge t1, s0, next_row_tr
    
    add t2, x0, t0
    mul t2, s0, t2
    add t2, t2, t1
    slli t2, t2, 2
    add t2, s1, t2
    lw t4, 0(t2)

    add t3, x0, t1
    mul t3, s0, t3
    add t3, t3, t0
    slli t3, t3, 2
    add t3, s1, t3
    lw t5, 0(t3)

    sw t5, 0(t2)
    sw t4, 0(t3)


    addi t1, t1, 1
    j tr_in

next_col_tr:
    addi t1, t1, 1
    j tr_in

next_row_tr:
    addi t0, t0, 1
    j tr_out

done_tr:
    add t0, x0, x0
   
    add s3, s0, x0
    srli s3, s3, 1

rev_out:
    bge t0, s0, done_rev
    add t1, x0, x0
    

rev_in:
    
    bge t1, s3, next_row_rev
    
    add t2, x0, t0
    mul t2, s0, t2
    add t2, t2, t1
    slli t2, t2, 2
    add t2, s1, t2
    lw t4, 0(t2)
    add t6, x0, s0
    addi t6, t6, -1
    sub t6, t6, t1

    add t3, x0, t0
    mul t3, s0, t3
    add t3, t3, t6
    slli t3, t3, 2
    add t3, s1, t3
    lw t5, 0(t3)

    sw t5, 0(t2)
    sw t4, 0(t3)



    addi t1, t1, 1
    j rev_in


next_row_rev:
    addi t0, t0, 1
    j rev_out

done_rev:
    add t0, x0, x0
    

pr_out:
    bge t0, s0, done_pr
    add t1, x0, x0
    

pr_in:
    bge t1, s0, next_row_pr
    add t2, x0, t0
    mul t2, s0, t2
    add t2, t2, t1
    slli t2, t2, 2
    add t2, s1, t2
    

    la a0, fmt_out
    sw a1, 0(t2)

    
    
    call printf

    addi t1, t1, 1
    j pr_in

next_row_pr:
    addi t0, t0, 1
    j pr_out

done_pr:
    add t0, x0, x0
    
    ld ra, 8(sp)
    ret