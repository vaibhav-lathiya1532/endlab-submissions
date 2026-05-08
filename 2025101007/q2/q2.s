.data
    input_fmt: .asciz "%lld %lld"
    buffer: .space 2
    output_fmt: .asciz "%lld %lld\n"
.text
.globl main

main:
    addi sp,sp,-24
    sd ra,16(sp)

    la a0,input_fmt
    la a1,buffer
    call scanf

    ld s0,0(sp)
    ld s1,8(sp)

    li t0,1
find_gcd:
    bgt a0,a1,greater_a0
    bgt t0,a1,exit
    rem t1,a0,t0
    rem t2,a1,t0
    beqz t1,check_a1

greater_a0:
    bgt t0,a0,exit
    rem t1,a0,t0
    rem t2,a1,t0
    beqz t1,check_a1

check_a1:
    beqz t2,print
    addi t0,t0,1
    ld s3,t0
    
find_lcm:
    

print:
    la a0,output_fmt
    mv a1,s3
    call printf



