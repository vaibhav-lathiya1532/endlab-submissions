.section .rodata
fmt:
    .string "%ld %ld"
fmt2:
    .string "%ld"
err:.string "error found no allocation"
w:.string "while\n"
l:.string "\n"
.section .data
n:
    .dword 0
L:
    .dword 0
.section .text
.globl main

# s0 --> n 
# s1 --> L
# s2 --> base address of arr
# s3 --> index
main:
    lla a0,fmt
    lla a1,n
    lla a2,L
    call scanf

    lla t0,n
    ld s0,0(t0)

    lla t0,L
    ld s1,0(t0)

    mv a0,s0
    call malloc
    beqz a0,error

    mv s2,a0
    li s3,-1

loop:
    lla a0,l
    call printf
    addi s3,s3,1
    bge s3,s0,work
    slli t0,s3,3
    add a1,t0,s2
    lla a0,fmt2
    call scanf
    j loop

#-------------above is correct------------#
work:
    li s3,0
    addi s4,s0,-1
    li s5,0
while:
   
    bgt s3,s4,result

    slli t0,s3,3
    slli t1,s4,3

    add t0,t0,s2
    add t1,t1,s2

    ld t0,0(t0)
    ld t1,0(t1)
    addi s5,s5,1
    addi s4,s4,-1
    add t2,t0,t1
    ble t2,s1,both
    j while
both:
    addi s3,s3,1
    j while
result:
    lla a0,fmt2
    mv a1,s5
    call printf
    call exit
error:
    lla a0,err
    call printf
    call exit