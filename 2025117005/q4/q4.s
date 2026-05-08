.data
fmt_in: .asciz "%lld %lld"
fmt_out: .asciz "%lld %lld %lld %lld\n"

price: .quad 0
inserted: .quad 0

.text
.globl main

main:
    la a0,fmt_in
    la a1,price
    la a2,inserted
    call scanf

    ld s0,price
    ld s1,inserted

    sub s2,s1,s0

    li s3,0
    li s4,0
    li s5,0
    li s6,0

a_loop:
    li t0,25
    blt s2,t0,b_loop
    sub s2,s2,t0
    addi s3,s3,1
    j a_loop
b_loop:
    li t0,10
    blt s2,t0,c_loop
    sub s2,s2,t0
    addi s4,s4,1
    j b_loop
c_loop:
    li t0,5
    blt s2,t0,d_loop
    sub s2,s2,t0
    addi s5,s5,1
    j c_loop
d_loop:
    li t0,1
    blt s2,t0,print
    sub s2,s2,t0
    addi s6,s6,1
    j d_loop

print:
    la a0,fmt_out
    mv a1,s3
    mv a2,s4
    mv a3,s5
    mv a4,s6
    call printf

exit:
    la a7,93
    li a0,0
    ecall