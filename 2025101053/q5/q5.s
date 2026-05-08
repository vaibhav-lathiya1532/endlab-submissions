.section .data
fmtin: .string "%lld"
fmtout: .string "%lld "
fmtlast: .string "%lld\n"

.section .bss
n: .quad 0
mat: .space 8000000

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
    mul x9,x8,x8

    # Store the start of the matrix
    la x25,mat
    
    add x18,x0,x0      # Initialise i=0
    
iloop:
    bge x18,x8,start_print
    add x19,x0,x0      # Initialise j=0;

    beq x0,x0,jloop

jloop:
    bge x19,x8,next

    addi x21,x18,1
    addi x22,x19,1
    mul x22,x8,x22
    sub x22,x22,x21
    slli x22,x22,3

    # Take input of the integer
    la x10,fmtin
    la x11,n 
    call scanf

    ld x23,n
    add x24,x25,x22
    sd x23,0(x24)

    addi x19,x19,1
    beq x0,x0,jloop

next:
    addi x18,x18,1
    beq x0,x0,iloop

start_print:
    add x18,x0,x0

print_loop:
    bge x18,x9,exit
    
    addi x26,x18,1
    rem x26,x26,x8

    beq x26,x0,print_last

    slli x27,x18,3
    add x27,x27,x25
    
    ld x27,0(x27)

    la x10,fmtout
    add x11,x0,x27
    call printf

    addi x18,x18,1
    beq x0,x0,print_loop

print_last:
    slli x27,x18,3
    add x27,x27,x25
    
    ld x27,0(x27)

    la x10,fmtlast
    add x11,x0,x27
    call printf

    addi x18,x18,1
    beq x0,x0,print_loop

exit: 
    ld x1,8(sp)
    addi sp,sp,16

    ret
    

