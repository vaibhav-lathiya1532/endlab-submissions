.section .rodata
input:
	.string "%lld"
output:
	.string "%lld\n"
.globl main
.section .text

func:
	#x10 has number #x11 has 10 #x12 has 0
	beq x10,x0,gone
	rem x13,x10,x11
	div x10,x10,x11
	mul x13,x13,x13
	add x12,x12,x13
	beq x0,x0,func
gone:
	jalr x0,0(x1)

main:
	addi sp,sp,-16
	sd x1,0(sp)
	addi x11,sp,8
	la x10,input
	call scanf
	ld x18,8(sp)
	blt x18,x0,ret
	addi x19,x0,100
	addi x20,x0,1
loop:
	beq x19,x0,ret
	addi x10,x18,0
	addi x12,x0,0
	addi x11,x0,10
	jal x1,func
	beq x12,x20,happy
	addi x18,x12,0
	addi x19,x19,-1
	beq x0,x0,loop
ret:
	la x10,output
	addi x11,x0,0
	call printf
	ld x1,0(sp)
	addi sp,sp,16
	addi x10,x0,0
	jalr x0,0(x1)
happy:
	la x10,output
	addi x11,x0,1
	call printf
	ld x1,0(sp)
	addi sp,sp,16
	addi x10,x0,0
	jalr x0,0(x1)
