.data
in: .string "%lld"
out1: .string "TRUE\n"
out2: .string "FALSE\n"

.text
.globl main

main:
    addi sp,sp,-32
    sd ra,24(sp)

    la a0,in
    addi a1,sp,0
    call scanf
    ld s0,0(sp)

    li s1,0

read:
    bge s1,s0,done

    la a0,in
    addi a1,sp,0
    call scanf
    ld s2,0(sp)

    li t2,2
    remu s3,s2,t2
    
    addi s1,s1,1
    j read

pri_true:
    la a0,out1
    call printf
    
done:
    la a0,out2
    call printf

    li a0,0
    ld ra,24(sp)
    addi sp,sp,32
    ret


