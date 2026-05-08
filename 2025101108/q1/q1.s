.section .data
fmt_in: .string "%d "
fmt_out: .string "%d"
n: .quad 0
current: .quad 0
max: .quad -1000001
matrix: .space 400

.section .text
.globl main

main:
    addi sp,sp,-16
    sd t0,8(sp)

    lla a0,fmt_in
    lla a1,n
    call scanf

    ld s1,matrix
    li s2,2
    ld s0,n 

    lla a0,fmt_in
    lla a1,current
    call scanf

    ld t0,current

    lla a0,fmt_in
    lla a1,current
    call scanf

    ld t1,current


loop:
    bge s2,s0,check
    
    lla a0,fmt_in
    lla a1,current
    call scanf

    ld t2,current

    bgt t2,t0,next
    bgt t2,t1,replace

    addi s2,s2,1

    j loop

replace:
    mv t1,t2
    addi s2,s2,1
    j loop

next:
    blt t2,t1,replacel
    addi s2,s2,1
    j loop

replacel:
    mv t0,t2
    addi s2,s2,1
    j loop

check:
    blt t0,t1,print
    lla a0,fmt_out
    mv a1,t1
    call printf
    
    ret

print:
    lla a0,fmt_out
    mv a1,t0
    call printf
    
    ret

    
    








