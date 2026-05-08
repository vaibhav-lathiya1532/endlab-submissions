.section .data
input: .asciz "%lld"
output: .asciz "%lld\n"

.section .bss
.balign 8
n: .space 8
ans: .space 8
array: .space 904

.section .text

.globl main
main:

addi sp,sp,-112
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)
sd s4,40(sp)
sd s5,48(sp)
sd s6,56(sp)
sd s7,64(sp)
sd s8,72(sp)
sd s9,80(sp)
sd s10,88(sp)
sd s11,96(sp)


la a0,input
la a1,n
call scanf

la t0,n
ld s0,0(t0) #s0=n
li s1,0 #s1=i=0
inputloop:
bge s1,s0,endinput
slli t1,s1,3
la a1,array
add a1,a1,t1
la a0,input
call scanf
addi s1,s1,1
beq x0,x0,inputloop



endinput:

li s3,-10000000
li s4, -10000000

li s1,0 #s1=i=0
loop:
bge s1,s0,endloop
slli t1,s1,3
la t0,array
add t0,t0,t1
ld s5, 0(t0) #s5=arr[i]
blt s4,s5,both

bge s3,s5,here
beq s5,s4, here

add s3,s5,x0
beq x0,x0,here
la a0,input
la a1,n
call scanf



both:
add s3,s4,x0
add s4,s5,x0

here:
addi s1,s1,1
beq x0,x0,loop



endloop:


la t0, ans
sd s3,0(t0)

li t0,0
add a1, s3,x0
la a0,output
call printf



end:

ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
ld s5,48(sp)
ld s6,56(sp)
ld s7,64(sp)
ld s8,72(sp)
ld s9,80(sp)
ld s10,88(sp)
ld s11,96(sp)
addi sp,sp,112
li a0,0
ret
