.section .rodata
fmtscan:
.string "%d"
fmt:
.string "%d"
.section .text
.globl main
main:
addi sp,sp,-48
sd ra,40(sp)
sd s0,32(sp)
sd s1,24(sp)
sd s2,16(sp)
sd s3,8(sp)
lla a0,fmtscan
addi a1,sp,0
call scanf
lw s0,0(sp) #s0 me n
li s1,0 #i
li s2,0 #sum
loop:
addi t0,s0,-1 #n-1
beq s1,t0,jmp

lla a0,fmtscan
addi a1,sp,0
call scanf
lw s3,0(sp) #s3 me number 
j prime








prime:
addi s3,s3,-1
sloop:

