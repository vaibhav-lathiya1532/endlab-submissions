.data 

    fmt_in: .asciz "%d %d" 

    arr: .space 100000

.text 
.global main 

main: 
    addi sp, sp, -16 
    sw ra, 12(sp) 
    sw s0, 8(sp) 
    sw s1, 4(sp) 
    sw s2, 0(sp) 

    la a0, fmt_in 
    addi a1, sp, 8 
    addi a2, sp, 4 

    call scanf 

    la t0,  arr 
    li t1, 0 
    j read_arr 

read_arr: 
    
    mv t2, t1 
    slli t2, t2, 2 
    add t2, t2, t0 

    lw a1, 0(t2) 
    la a0, fmt_in 
    call scanf 

