.data
in: .string "%lld"
out: .string "%lld"

.text
.globl main
main:
addi sp,sp,-32
sd ra,0(sp)

la a0,in
addi a1,sp,8
call scanf

ld a4,8(sp) # number
li t0,100 #limit
li a2,0 # index
li a5,1
li a3,0 # sum
loop:
bgt a2,t0,print_0

while:
ble a4,x0,done
li t1,10
rem t4,a4,t1
mul t3,t4,t4
add a3,a3,t3
div a4,a4,t1
j while

done:
beq a3,a5,print_1
addi a4,a3,0
li a3,0
addi a2,a2,1
j loop

print_0:
li a1,0
la a0,out
call printf
ld ra,0(sp)
addi sp,sp,32
li a0,0
ret

print_1:
li a1,1
la a0,out
call printf
ld ra,0(sp)
addi sp,sp,32
li a0,0
ret

