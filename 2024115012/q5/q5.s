.data 

    fmt_in: .asciz "%d " 
    fmt_space: .asciz "%d "
    fmt_newline: .asciz "\n"
    
    arr:    .space 4000000

.text 
.global main

main:
    addi sp, sp, -16 
    sw ra, 12(sp)
    sw s2, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)

    la a0, fmt_in 
    addi a1, sp, 0 
    call scanf 



    lw s0, 0(sp) 

read_arr: 
    li t1, 0
    la t0, arr                                         
    j read_rows 

read_rows:
    bge t1, s0, done_read 
    li t2, 0  #cols 

    j read_cols

read_cols: 
    
    bge t2, s0, next_row 
    la t0, arr 
    mul t3, t1, s0 
    add t3, t3, t2 
    slli t3, t3, 2  
    add t3, t0, t3   
    
    la a0, fmt_in 
    mv a1, t3 
    call scanf 


    addi t2, t2, 1 

    j read_cols 

next_row: 
    addi t1, t1, 1 
    j read_rows 

done_read: 
    li t1, 0 
    j transpose_row 

transpose_row: 
    bge t1, s0, done_trans
    addi t2, t1, 1 
    j trans_cols 

trans_cols: 
    bge t2, s0, next_rowtrans 
    

     mul t3, t1, s0 
     add t3, t3, t2 
     slli t3, t3, 2
     add t3, t3, t0  

     lw t4, 0(t3) 

     mul t5, t2, s0 
     add t5, t5, t1 
     slli t5, t5, 2 
     add t5, t5, t0 

     lw t6, 0(t5)

     sw t6, 0(t3) 
     sw t4, 0(t5) 

     addi t2, t2, 1 

next_rowtrans: 
    addi t1, t1, 1 
    j transpose_row


done_trans:  
    li t1, 0 
    j rev_rows 

rev_rows:
    la t0, arr
    bge t1, s0, done 
    li t2, 0 
    j rev_cols 

rev_cols:
    la t0, arr
    srai t3, s0, 1 
    bge t2, t3, next_rev 

    #arr[i][j] = arr[i][n-j-1]

    mul t3, t1, s0 
    add t3, t3, t2 
    slli t3, t3, 2  
    add t3, t3, t0 

    lw t4, 0(t3)


    mv t6, s0 
    addi t6, t6, -1 
    sub t6, t6, t2 
    add t5, t5, t6 
    slli t5, t5, 2 
    add t5, t5, t0 

    lw t0, 0(t5) 

    sw t4, 0(t5) 
    sw t0, 0(t3) 

    addi t2, t2, 1 

next_rev: 
    addi t1, t1, 1 
    j rev_rows


done:
    la t0, arr 

    la a0, fmt_space

    li s1, 0

    j print_row 

print_row: 
    bge s1, s0, end 
    li s2, 0 
    j print_cols 

print_cols: 
    bge s2, s0, newline 

    mul t1, s1, s0 
    add t1, t1, s2 
    slli t1, t1, 2 

    add t1, t1, t0 

    mv a1, t1 

    call printf 

    addi s2, s2, 1 
    j print_cols

newline: 
    addi s1, s1, 1 
    la a0, fmt_newline
    call printf 
    j print_row

end: 
    lw ra, 12(sp)
    lw s2, 8(sp) 
    lw s1, 4(sp) 
    lw s0, 0(sp) 
    addi sp, sp, 16 
    ret 

    
