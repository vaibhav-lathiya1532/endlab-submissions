.data
in_fmt: .asciz "%lld %lld"
sp_format: .asciz "%lld"
out_fmt: .asciz "%lld"
arr: .space 8000000
n: .space 8
m: .space 8


.text
.globl main
 addi sp,sp,-32
 sd ra,24(sp)
 sd s0,16(sp)
 sd s1,8(sp)
 sd s2,0(sp)

 la a0,in_fmt
 la a1,n
 la a2,m
 call scanf
 ld s0,n
 ld s1,m
 li s2,0
 input_loop:
    bge  s2,s0,exit_input_loop 
    slli t0,s2,3
    la t1,arr
    add t1,t1,t0
   
   
    la a0,sp_format
    la a1,t1
    call scanf
    li t3,0
    li t4,n
output_loop:
    

