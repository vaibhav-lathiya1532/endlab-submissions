.globl main
main:
addi sp,sp,-16
sd ra,0(sp)

la a0,fmtin
addi a1,sp,8
call scanf

ld s0,8(sp)

addi t0,s0,0
slli t0,t0,3
addi a0,t0,0
call malloc

addi s1,a0,0 #input

addi t0,s0,0
slli t0,t0,3
addi a0,t0,0
call malloc

addi s2,a0,0 #l

addi t0,s0,0
slli t0,t0,3
addi a0,t0,0
call malloc 

addi s3,a0,0 #r

addi s4,x0,0

loop1:
beq s4,s0,break1
addi t0,s4,0
slli t0,t0,3
la a0,fmtin
add a1,s1,t0
call scanf
addi s4,s4,1
jal x0,loop1
break1:

sd x0,0(s2)
addi t0,x0,0
ld t1,0(s1)
addi s4,x0,1

loop2:
beq s4,s0,break2
add t2,t1,t0
addi t0,t2,0
addi t3,s4,0
slli t3,t3,3
add t4,t3,s1
add t5,t3,s2
ld t1,0(t4)
sd t0,0(t5)
addi s4,s4,1
jal x0,loop2

break2:
addi s4,s0,-1
addi t3,s4,0
slli t3,t3,3
add t4,t3,s3
sd x0,0(t4)
add t5,t3,s1

addi t0,x0,0
ld t1,0(t5)
addi s4,s4,-1
loop3:
blt s4,x0,break3
add t2,t1,t0
addi t3,s4,0
slli t3,t3,3
add t4,t3,s1
add t5,t3,s3
sd t2,0(t5)
addi t0,t2,0
ld t1,0(t4)
addi s4,s4,-1
jal x0,loop3

break3:
 addi t0,x0,-1
 addi s4,x0,0

 loop4:
 beq s4,s0,break4
 addi t1,s4,0
 slli t1,t1,3
 add t2,t1,s2
 ld t2,0(t2)
 add t3,t1,s3
 ld t3,0(t3)
 beq t2,t3,find
 addi s4,s4,1
 jal x0,loop4

 find:
 addi t0,s4,0
 break4:

 la a0,fmtout
 addi a1,t0,0
 call printf

 ld ra,0(sp)
 addi sp,sp,16
 ret






.data
fmtin: .string "%lld"
fmtout: .string "%lld\n"
