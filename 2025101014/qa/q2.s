.data
in: .string "%lld %lld"
ina: .string "%lld"
out: .string "%lld\n"
array: .space 800000

.text
.globl main
.extern scanf
.extern printf

main:
    addi sp,sp,-32
    sd ra,24(sp)
    sd s0,16(sp)
    sd s1,8(sp)
    sd s3,0(sp)

    lla a0,in
    addi a1,sp,16
    addi a2,sp,8
    call scanf

    ld s0,16(sp)
    ld s1,8(sp)
    la s3,array

    li t0,0
    
arr:
    bge t0,s0,arr_made

    srli t1,t0,3
    la a0,ina
    la a1,t1
    call scanf

    addi t0,t0,1
    j arr

arr_made:
    li t0,0
    li t1,0
    addi t2,s0,-1

loop:
    bge t1,t2,done

    srli t3,t1,3
    srli t4,t2,3

    add t5,t3(s3),t4(s3)
    bgt t5,s1,single

    addi t0,t0,1
    addi t2,t2,-1
    addi t1,t1,1
    j loop

single:
    addi t0,t0,1
    addi t2,t2,-1
    j loop

done:
    bgt t1,t2,exit
    addi t0,t0,1

exit:
    mv a1,t0
    la a0,out
    call printf

    ld ra,24(sp)
    ld s0,16(sp)
    ld s1,8(sp)
    ld s3,0(sp)
    addi sp,sp,32

    ret