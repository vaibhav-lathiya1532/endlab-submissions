.data
    fmt_inp: .string "%d"
    fmt_out: .string "%d\n"
.bss    
    arr: .space 500
.text
.globl main
main:
    addi sp,sp,-16
    addi a1, sp,0
    la a0,fmt_inp
    call scanf
    lw s0, 0(sp)
    addi sp,sp,16
    la s1, arr
    li s2, 0  # curr index
    li s3,0   #sum
store_loop:
    beq s2, s0, store_loop_done
    la a0, fmt_inp
    mv a1, s1
    call scanf
    addi s2,s2,1
    lw t0 , 0(s1)
    add s3, s3, t0
    addi s1,s1,4
    j store_loop
store_loop_done:
    la s1, arr
    li s2, 0
    li s4, 0    # s4 stores the left sum 

find_loop:
    beq s2, s0, ans_not_found
    lw t0, 0(s1)
    sub t1 , s3, t0
    li t2,2
    mul t3, s4, t2
    add t3, t0, t3
    beq s3, t3, found_ans
    add s4, s4, t0
    addi s1,s1,4
    addi s2,s2,1
    j find_loop

ans_not_found:
    la a0 , fmt_out
    li a1, -1
    call printf
    call exit
found_ans:
    la a0, fmt_out
    mv a1,s2
    call printf
    call exit
