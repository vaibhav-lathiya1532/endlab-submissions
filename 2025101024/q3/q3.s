.data
input_fmt: .asciz "%lld"
output_fmt: .asciz "%lld"
n: .space 8
nums: .space 8
.text
.global main

main:
    addi sp,sp,-56
    sd ra,48(sp)
    sd s0,40(sp)
    sd s1,32(sp)
    sd s2,24(sp)
    sd s3,16(sp)
    sd s4,8(sp)
    sd s5,0(sp)
    la a0,input_fmt
    la a1,n
    call scanf
    ld t0,n
    ld s0,0(t0)
    
    mv s1,s0
    li s2,0 
input_loop:
    li t0,0
    ble s1,t0,done_loop

    la a0,input_fmt
    la a1,nums
    call scanf
    ld t0,n
    ld s3,0(t0)

    srai t2,s3,1

