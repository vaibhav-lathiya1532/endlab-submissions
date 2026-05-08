.data
fmt:
.string "%lld %lld"
fmt1:
.string "%lld %lld\n"
.text
.globl main
main:
addi sp,sp,-120
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

la a0,fmt
addi a1,sp,104
addi a2,sp,112
call scanf
ld s0,104(sp)
ld s1,112(sp)
addi s2,x0,2
addi s5,x0,1

bgt s0,s1,while1

while2:
addi t0,s0,1
beq s2,t0,notfound
ld ra,0(sp)
rem s3,s0,s2
rem s4,s1,s2
add s7,s3,s4
beq s7,x0,found2
addi s2,s2,1
jal x0,while2


found2:
addi s5,s2,0
addi s2,s2,1
jal x0,while2

while1:
addi t0,s1,1
beq s2,t0,notfound
rem s3,s0,s2
rem s4,s1,s2
add s7,s3,s4
beq s7,x0,found1
addi s2,s2,1
jal x0,while1

found1:
addi s5,s2,0
addi s2,s2,1
jal x0,while1

notfound:

final:
mul t4,s0,s1
div t4,t4,s5
mv s6,t4

bge s0,s1,mbig
rem t4,s1,s0
beq t4,x0,niche2
jal x0,okp

mbig:
rem t4,s0,s1
beq t4,x0,niche
jal x0,okp
niche:
addi s6,s0,0
jal x0,okp

niche2:
addi s6,s1,0
jal x0,okp

okp:
la a0,fmt1
addi a1,s5,0
addi a2,s6,0
call printf
li a0,0
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
addi sp,sp,120
ret



