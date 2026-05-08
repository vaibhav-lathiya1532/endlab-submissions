.section .data

fmt_in : .asciz "%d"
fmt_out: .asciz "%d\n"
arr_in : .asciz "%d"
N: .word 0
target: .word 0
array: .space 400000

.section .text
.globl main

.extern printf
.extern scanf

main:

    addi sp,sp,-16
    sd ra,8(sp)

read_N:

    la a0,fmt_in
    la a1,N
    call scanf
    la s1,N
    lw s1,0(s1)
la s0,array
li t0,0

read_array:
    beq t0,s1,read_target
    la a0,arr_in
    srli t1,t0,2
    add t2,s0,t1
    add a1,t2,x0
    call scanf

    addi t0,t0,1
    j read_array

read_target:

    la a0,fmt_in
    la a1,target
    call scanf

    la t4,target
    lw t4,0(t4)

li t1,0
addi t2,s1,-1

search_loop:
    add t3,t1,t2
    slli t3,t3,1
    
    bgt t1,t2,not_found
    beq t4,t5,found

    srli t5,t3,2
    add t5,s0,t5
    lw t5,0(t5)

    srli t6,t1,2
    add t6,s0,t6
    lw t6,0(t6)

    srli s2,t2,2
    add s2,s0,s2
    lw s2,0(s2)
    
    ble t6,t5,left_sorted
right_sorted:
    ble t4,s2,check_range_right
    addi t2,t3,-1
    j search_loop
check_range_right:
    blt t6,t4,go_right
    addi t2,t3,-1
    j search_loop
go_right:
    addi t1,t3,1
    j search_loop
left_sorted:
    ble t6,t4,check_range_left
    addi t1,t3,1
    j search_loop
check_range_left:
    blt t4,s2,go_left
    addi t1,t3,1
    j search_loop
go_left:
    addi t2,t3,-1
    j search_loop
found:
    la a0,fmt_out
    addi a1,t3,0
    call printf
    j end
not_found:
    la a0,fmt_out
    li t0,-1
    add a1,t1,x0
    call printf

end:

    li a0,0
    ld ra,8(sp) 
    addi sp,sp,16
    ret

