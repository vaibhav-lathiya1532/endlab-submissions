.section .data
input: .asciz "%d"
output: .asciz "%d\n"
newline: .asciz "\n"
test: .asciz "test"
n1: .word 0
n2: .word 0
n3: .word 0

.section .text
.globl main
.extern printf
.extern scanf




main:
la a0, input
la a1,n1
call scanf
la x1,n1

la a0,input
la a1,n2
call scanf
la x2,n2

sub x3,x2,x1
la a0,output
mv a1,x3
call printf
li a0,0
ret


