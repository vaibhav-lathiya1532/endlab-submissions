.section .rodata
input:
	.string "%lld"
output:
	.string "%lld\n"
.globl main
.section .text

fun:
	#x10 number and return number if prime if not then 0 and x15=1 and x16=num+1 and x13=0 and x12=2
	beq x15,x16,ret
	rem x14,x10,x15
	beq x14,x0,inc
	addi x15,x15,1
	beq x0,x0,fun
inc:
	addi x13,x13,1
	addi x15,x15,1
	beq x0,x0,fun
ret:
	beq x13,x12,prime
	addi x10,x0,0
	jalr x0,0(x1)
prime:
	jalr x0,0(x1)

main:
	addi sp,sp,-32
	sd x1,16(sp)
	addi x11,sp,24
	la x10,input
	call scanf
	ld x18,24(sp)  #x18=n
	addi x19,x0,0
	addi x27,x0,0 #x27 = sum
loop:
	beq x19,x18,ex
	la x10,input
	addi x11,sp,0
	call scanf
	ld x10,0(sp)
	addi x15,x0,1
	addi x16,x10,1
	addi x13,x0,0
	addi x12,x0,2
	jal x1,fun
	add x27,x27,x10
	addi x19,x19,1
	beq x0,x0,loop
ex:
	la x10,output
	addi x11,x27,0
	call printf
	addi x10,x0,0
	ld x1,16(sp)
	addi sp,sp,32
	jalr x0,0(x1)
