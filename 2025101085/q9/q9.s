.data
fmt:
.string "%lld"
fmt1:
.string "1\n"
fmt2:
.string "0\n"
.text
.global main

main:
addi sp ,sp,-64
sd x1,0(sp) 
sd s0,8(sp) #n
sd s1,16(sp) #counter
sd s2,32(sp) #temp

la a0, fmt
addi a1,sp,24
call scanf 
ld s0,24(sp)
li s1,0

loop:
li t0,100
beq s1,t0,pno
addi s2,x0,0


while:
li t2,1
blt s0,t2,check
li t1,10
rem t0,s0,t1
mul t0,t0,t0
add s2,s2,t0
div s0,s0,t1
j while 

check:
li t0,1
beq s2,t0,py
addi s1,s1,1
addi s0,s2,0
j loop

py:
la a0,fmt1
call printf
j end

pno:
la a0,fmt2
call printf
j end

end:
ld x1,0(sp) 
ld s0,8(sp) #n
ld s1,16(sp) #counter
ld s2,32(sp) #temp
addi sp,sp,64
addi a0,x0,0
ret