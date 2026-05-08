.data
input: .string "%lld %lld"
output: .string "%lld %lld\n"
.text
.global main

main:
addi sp,sp,-64
sd x1,56(sp)
sd x9,48(sp)    # val1
sd x18,40(sp)   # val2
sd x19,32(sp)  
sd x20,24(sp)
sd x21,16(sp)
sd x22,8(sp)

la x10,input
addi x11,sp,0
addi x12,sp,8
call scanf
ld x9,0(sp)
ld x18,8(sp)

blt x9,x18,val1_small

addi x20,x18,0
addi x22,x9,0
beq x0,x0,go
val1_small:
addi x20,x9,0
addi x22,x18,0

go:
li x21,1

hcf:

bgt x21,x20,lcm
rem x5,x9,x21
beq x5,x0,checkv2
addi x21,x21,1
j hcf
checkv2:
rem x6,x18,x21
beq x6,x0,stornew
addi x21,x21,1
j hcf
stornew:
addi x11,x21,0
addi x21,x21,1
j hcf

addi x21,x22,0

lcm:
rem x5,x21,x9
beq x5,x0,chv2
addi x21,x21,1
j lcm
chv2:
rem x6,x21,x18
beq x6,x0,strnw
addi x21,x21,1
j lcm

strnw:
addi x12,x21,0

la x10,output
call printf


ld x1,56(sp)
ld x9,48(sp)    # val1
ld x18,40(sp)   # val2
ld x19,32(sp)  
ld x20,24(sp)
ld x21,16(sp)
ld x22,8(sp)
addi sp,sp,64
ret