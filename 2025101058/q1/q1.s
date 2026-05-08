.section .data
fmt: .string "%lld"
fmt1: .string "%lld\n"

.section .bss
n: .quad 0

.section .text
.globl main

main:
        addi sp,sp,-8
        sd x1,0(sp)

        la x10,fmt
        la x11,n
        call scanf
        ld x18,n        #x18 = n

        li x26,-1000001     #x26 = max1
        li x27,-1000001     #x27 = max2

        bgt x18,x0,loop

loop:
        la x10,fmt
        la x11,n
        call scanf
        ld x19,n

        bgt x19,x26,elem_greater_than_max1
        blt x19,x26,check
        j cont

elem_greater_than_max1:
        mv x27,x26
        mv x26,x19
        j cont

check:
        bgt x19,x27,elem_greater_than_max2_and_lesser_than_max1
        j cont

elem_greater_than_max2_and_lesser_than_max1:
        mv x27,x19
        j cont

cont:
        addi x18,x18,-1
        bgt x18,x0,loop

        la x10,fmt1
        mv x11,x27
        call printf

        ld x1,0(sp)
        addi sp,sp,8

        jalr x0,0(x1)

