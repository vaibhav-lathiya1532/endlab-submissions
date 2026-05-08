.section .data

fmt_in : .asciz "%d %d"
fmt_out: .asciz "%d\n"
arr_in : .asciz "%d"
N: .word 0
L: .word 0
target: .word 0
array: .space 400000

.section .text
.globl main

.extern printf
.extern scanf

main:

    addi sp,sp,-16
    sd ra,8(sp)

read_N_L:

    la a0,fmt_in
    la a1,N
    la a2,L
    call scanf
    la s1,N
    lw s1,0(s1)
    la s2,L
    lw s2,0(s2)

la s0,array
li t0,0

read_array:
    beq t0,s1,start
    la a0,arr_in
    srli t1,t0,2
    add t2,s0,t1
    add a1,t2,x0
    call scanf

    addi t0,t0,1
    j read_array

li t1,0
addi t2,s1,-1

li t3,0

start:

    bge t1,t2,result
    srli t3,t1,2
    add t3,s0,t3
    lw t3,0(t3)

    srli t4,t2,2
    add t4,s0,t4
    lw t4,0(t4)
    add t5,t3,t4

    bgt  t5,s2,greater
    ble t5,s2,less

greater:
addi t3,t3,1
    addi t2,t2,-1
    j start

less:
    addi t3,t3,1
    addi t1,t1,1
    addi t2,t2,-1
    j start

result:
la a0,fmt_out
addi a1,t3,0
call printf

end:
    li a0,0
    ld ra,8(sp) 
    addi sp,sp,16
    ret
