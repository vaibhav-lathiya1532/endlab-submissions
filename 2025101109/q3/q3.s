.data
array: .space 5000
.text
.globl main


main:

li a7,5
ecall  #input n
mv s0,a0

la t0,array
li t1,0

arrayinput:
beq t1,s0,check1
li a7,5
ecall 
mv t2,a0
addi t0,t0,4
addi t1,t1,1

j arrayinput


la t2,array
li t5,0 #sum
li t6,0 #count
li s2,0

check1:
bgt s2,s0,done
li t0,2
lw t1,0(t2)

loop:
beq t1,t0,countcheck
rem t3,t1,t0
beq t3,zero,inc
addi t0,t0,1
j loop

inc:
addi t6,t6,1
addi t0,t0,1
j loop

countcheck:
addi s2,s2,1
beq t6,zero,prime
addi t2,t2,4
j check1

prime:
add t5,t5,t1
addi t2,t2,4
j check1

done:
mv a0,t5
li a7,5
ecall

li a7,10
ecall









