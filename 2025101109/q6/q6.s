.data
array: .space 4000

.text
.globl main
main:

la a0,array
li a7,8
mv t0,a0

li t2,'0'
li t3,'9'

loop:
lb t1,0(t0)
beq t1,zero,done
blt t1,t2,operator
bgt t1,t3,operator

addi sp,sp,-4
sw t1,0(sp)
addi t0,t0,4
j loop

operator:
lw t5,0(sp)
add sp,sp,4

lw t6,0(sp)
addi sp,sp,4
addi t0,t0,4

li t4,'+'
beq t1,t4,add

li t4,'-'
beq t1,t4,sub

li t4,'*'
beq t1,t4,mul

add:
add s2,t5,t6
addi sp,sp,-4
sw s2,0(sp)
j loop

sub:
sub s2,t6,t5
addi sp,sp,-4
sw s2,0(sp)
j loop

mul:
mul s2,t6,t5
addi sp,sp,-4
sw s2,0(sp)
j loop

done:
lw s2,0(sp)
mv a0,s2

li a7,5
ecall

li a7,10
ecall




