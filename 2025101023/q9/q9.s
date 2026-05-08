.globl main

.section .data
input: .string "%lld"
out_1: .string "1\n"
out_0: .string "0\n"

.section .text
main:
    addi sp, sp,-80
    sd ra, 64(sp)
    sd s0, 48(sp)  #n
    sd s1, 32(sp)  #temp
    sd s2, 16(sp)   #sum
    sd s3, 0(sp)    #count

    la a0, input
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)

    mv s1, s0  #temp = n
    li s2, 0    #s=0
    li s3, 0    #c=0
    
loop0: 
    li t0, 100
    bgt s3, t0, print0

loop1:  
    li t1, 10

    rem t2, s1, t1
    mul t3, t2, t2
    add s2, s2, t3

    j next_digit

next_digit:
    beqz s1, loop2
    div s1, s1, t1
    j loop1

loop2:

    li t4, 1
    beq s2, t4, print1  #if s=1 , print 1

    mv s1, s2
    add s3, s3, 1  #c++
    j loop0


print1:
    la a0, out_1
    call printf

    j exit

print0:
    la a0, out_0
    call printf

exit:
    li a0, 0
    ld ra, 64(sp)
    ld s0, 48(sp)  #n
    ld s1, 32(sp)  #temp
    ld s2, 16(sp)   #sum
    ld s3, 0(sp)    #count
    addi sp, sp, 80
    ret











