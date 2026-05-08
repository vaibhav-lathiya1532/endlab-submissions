.section .rodata
input: .string "%lld"
output1: .string "1\n"
output0: .string "0\n"

.section .text

.globl main
main:
    addi sp,sp,-16
    sd ra,0(sp)
    sd s0,8(sp)

    la a0,input
    addi a1,sp,8
    call scanf
    ld s0,8(sp)

    li t0,101

loop1:
    beqz t0,print0
    li t2,1
    beq s0,t2,print1
    li t1,0
    
loop2:
    beqz s0,done1
    li t2,10
    rem t3,s0,t2
    div s0,s0,t2
    mul t4,t3,t3
    add t1,t1,t4
    j loop2

done1:
    mv s0,t1
    addi t0,t0,-1
    j loop1

print0:
    la a0,output0
    call printf
    j done 

print1:
    la a0,output1
    call printf

done:
    ld ra,0(sp)
    li a0,0
    addi sp,sp,16
    ret

