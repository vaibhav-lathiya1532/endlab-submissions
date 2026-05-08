.section .data
fmtin: .string "%lld"
fmtout: .string "%lld\n"

.section .bss
n: .quad 0
L: .quad 0
arr: .space 8000000

.section .text
.globl main

main:
    addi sp,sp,-16
    sd x1,8(sp)

    #To take the input of N 
    la x10,fmtin
    la x11,n 
    call scanf

    ld x8,n 
    
    #To take input of the load
    la x10,fmtin
    la x11,L 
    call scanf

    ld x9,L

    add x26,x8,-1
    slli x26,x26,3

    la x21,arr          #Pointer to the start of arr -> x21
    add x26,x26,x21     #Pointer to the last of arr -> x26
    add x18,x0,x0       #Iterator -> x18
    add x25,x0,x0       #Counter -> x25

input_loop:
    bge x18,x8,check_loop

    slli x19,x18,3
    add x19,x19,x21

    la x10,fmtin
    la x11,n 
    call scanf

    ld x23,n 
    sd x23,0(x19)

    addi x18,x18,1
    beq x0,x0,input_loop

check_loop:
    bgt x21,x26,done_ig

    ld x22,0(x21)
    ld x23,0(x26)

    sub x7,x9,x23

    blt x7,x22,con1
    beq x0,x0,con2

con1:
    addi x25,x25,1

    addi x26,x26,-8
    beq x0,x0,check_loop

con2:
    addi x25,x25,1

    addi x21,x21,8
    addi x26,x26,-8
    beq x0,x0,check_loop

done_ig:
    la x10,fmtout
    add x11,x0,x25
    call printf

    ld x1,8(sp)
    addi sp,sp,16
    ret



    
