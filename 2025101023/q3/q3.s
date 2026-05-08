.globl main

.section .data
input: .string "%lld"
arr: .string "%lld "
output: .string "%lld\n"

.section .bss
buffer: .skip 8000000

.section .text
main:
    addi sp, sp, -112
    sd ra, 96(sp)
    sd s0, 80(sp)  #n
    sd s1, 64(sp) #left pointer
    sd s2, 48(sp)   #right pointer
    sd s3, 32(sp)       #leftsum
    sd s4, 16(sp)        #rightsum
    sd s5, 0(sp)            #curr array elem

    la a0, input
    addi a1, sp, 0
    la a2, buffer
    call scanf
    ld s0, buffer

read_arr:
    li t0, 0

    bgt t0, s0, leftsum

    la a0, arr
    addi a1, sp, 16
    call scanf
    ld s5, 16(sp)

    li s3, 0  #leftsum = 0
    li s4, 0 #rightsum = 0

leftsum:
    li t0, 0  #left pointer = 0
    add s3, s3, 0(t0)
    addi t0, t0, 1
    j leftsum

rightsum:
    sub t1, s0, -1  #n-1
    mv t0, t1
    add s4, s4, 96(t0)
    addi t0, t0, -1
    j rightsum

equal:

    sd t0, 0(sp)
    beq t3, t4, print    

print:

    ld t0, 0(sp)
    la a0, output
    mv a1, t0
    call printf

    li a0, 0
    ld ra, 96(sp)
    ld s0, 80(sp)  
    ld s1, 64(sp) 
    ld s2, 48(sp)   
    ld s3, 32(sp)       
    ld s4, 16(sp)        
    ld s5, 0(sp) 
    ret        






    








