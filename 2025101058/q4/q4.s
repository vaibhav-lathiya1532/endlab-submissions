.section .data
fmt: .string "%lld"
fmt1: .string "%lld "
fmt2: .string "%lld\n"

.section .bss
pr: .quad 0
ins: .quad 0

.section .text
.globl main

main:
        addi sp,sp,-8
        sd x1,0(sp)

        la x10,fmt
        la x11,pr
        call scanf
        ld x18,pr       #x18 = price

        la x10,fmt
        la x11,ins
        call scanf
        ld x19,ins      #x19 = inserted

        sub x18,x19,x18      #x18 = change

        li x19,0            #x19 = cnt
        bgt x18,x0,loop1

        j cont1

loop1:
        addi x20,x18,-25
        bge x20,x0,dec_change1

        j cont1

dec_change1:
        addi x18,x18,-25
        addi x19,x19,1
        bgt x18,x0,loop1

        j cont1

cont1:
        la x10,fmt1
        mv x11,x19
        call printf

        li x19,0
        bgt x18,x0,loop2

        j cont2


loop2:
        addi x20,x18,-10
        bge x20,x0,dec_change2

        j cont2

dec_change2:
        addi x18,x18,-10
        addi x19,x19,1
        bgt x18,x0,loop2

        j cont2

cont2:
        la x10,fmt1
        mv x11,x19
        call printf

        li x19,0
        bgt x18,x0,loop3

        j cont3

loop3:
        addi x20,x18,-5
        bge x20,x0,dec_change3

        j cont3

dec_change3:
        addi x18,x18,-5
        addi x19,x19,1
        bgt x18,x0,loop3

        j cont3

cont3:
        la x10,fmt1
        mv x11,x19
        call printf

        li x19,0
        bgt x18,x0,loop4

        j cont4


loop4:
        addi x20,x18,-1
        bge x20,x0,dec_change4

        j cont4

dec_change4:
        addi x18,x18,-1
        addi x19,x19,1
        bgt x18,x0,loop4

        j cont4

cont4:
        la x10,fmt2
        mv x11,x19
        call printf

        ld x1,0(sp)
        addi sp,sp,8

        jalr x0,0(x1)

        
        



