.data
n: .word 0
data: .space 100001
input: .asciz "%d"
output: .asciz "%s\n"
output_true: .asciz "TRUE"
output_false:.asciz "FALSE"

.text
.globl main
.extern printf
.extern scanf

check:

init:

addi x3,x0,0
mv x1,a0
mv x2,a1
li x7,2
addi x5,x0,0
addi x8,x0,1

loop:

blt x3,x1,loop_end
lw x4,0(x2)
beq x3,x0,zerocase
rem x6,x4,x7
sub t1,x8,x6
beq x5,t1,continue
la a0,output
la a1,output_false
call printf
ret

zerocase:

rem x5,x4,x7
addi x3,x3,1
addi x2,x2,4
j loop

continue:

addi x5,x6,0
addi x3,x3,1
addi x2,x2,4
j loop

loop_end:
la a0,output
la a1,output_true
call printf
ret

main:

la a0,input
la a1,n
call scanf
mv x1,a0
la a0,input
la a1,data
call scanf
mv x2,a0
mv a0,x1
mv a1,x2
call check
