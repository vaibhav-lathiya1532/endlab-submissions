.section .rodata
input: .string "%lld"
output: .string "%lld\n"

.section .text

.globl isPrime

isPrime:
    mv t2,a0
    li t4,1
    beq t2,t4,no
    li t1,2
    div t0,t2,t1
    addi t0,t0,1

loop:
    beq t1,t0,yes
    rem t3,t2,t1

    beqz t3,no
    addi t1,t1,1
    j loop

yes:
    mv a0,t2
    ret  

no:
    li a0,0
    ret



.globl main

main:
    addi sp,sp,-64
    sd ra,0(sp)
    sd s0,8(sp)   # stores N
    sd s1,16(sp)   # loop counter   
    sd s2,24(sp)   # result
    sd s3,32(sp)


    la a0,input
    addi a1,sp,8
    call scanf
    ld s0,8(sp)

    li s1,0
    li s2,0

loop1:
    beq s1,s0,print  

    la a0,input
    addi a1,sp,32
    call scanf

    ld s3,32(sp)

    mv a0,s3
    call isPrime
    mv t0,a0

    add s2,s2,t0
    addi s1,s1,1
    j loop1

print:
    la a0,output
    mv a1,s2
    call printf  
    
    ld ra,0(sp)
    ld s0,8(sp)   
    ld s1,16(sp)     
    ld s2,24(sp)   
    ld s3,32(sp)

    li a0,0

    ret
