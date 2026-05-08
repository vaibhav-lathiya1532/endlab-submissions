.data
fmt:
.string "%lld"
fmt1:
.string "%lld\n"
fmt2:
.string "%lld "

.text
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
la a0,fmt
addi a1,sp,104
call scanf
ld s0,104(sp)
mul s1,s0,s0
slli s1,s1,3
addi a0,s1,0
call malloc
mv s2,a0
addi s3,x0,-1
addi s4,x0,0

while1:
addi s3,s3,1
bge s3,s0,next1
addi s4,x0,0


while2:
bge s4,s0,while1
mul t0,s3,s0
add t0,t0,s4
slli t0,t0,3
add t0,t0,s2
la a0,fmt
add a1,t0,x0
call scanf

addi s4,s4,1
jal x0,while2


next1:
addi s3,x0,-1


while3:
addi s3,s3,1
bge s3,s0,next2
addi s4,s3,1

while4:
beq s4,s0,while3
mul t0,s3,s0
add t0,t0,s4
slli t0,t0,3
add t0,t0,s2

mul t1,s4,s0
add t1,t1,s3
slli t1,t1,3
add t1,t1,s2

ld t3,0(t0)
ld t4,0(t1)

sd t3,0(t1)
sd t4,0(t0)

addi s4,s4,1
jal x0,while4



next2:
addi s3,x0,-1

while5:
addi s3,s3,1
beq s3,s0,next3
addi s5,x0,0
addi s6,s0,-1

while6:
bge s5,s6,while5              
mul t0,s3,s0
add t2,t0,s5
add t3,t0,s6
slli t2,t2,3
slli t3,t3,3
add t2,t2,s2
add t3,t3,s2
ld t4,0(t2)
ld t5,0(t3)
sd t4,0(t3)
sd t5,0(t2)
addi s5,s5,1
addi s6,s6,-1
jal x0,while6

next3:
addi s3,x0,-1
addi s4,x0,0

while7:
addi s3,s3,1
beq s3,s0,next4
addi s4,x0,0

while8:
addi t3,s0,-1
beq s4,t3,nexter


mul t0,s3,s0
add t0,t0,s4
slli t0,t0,3
add t0,s2,t0

ld t3,0(t0)
la a0,fmt2
addi a1,t3,0
call printf

addi s4,s4,1
jal x0,while8

nexter:
mul t0,s3,s0
add t0,t0,s4
slli t0,t0,3
add t0,s2,t0

ld t3,0(t0)
addi a1,t3,0
la a0,fmt1
call printf

jal x0,while7

next4:
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
addi sp,sp,112
ret





