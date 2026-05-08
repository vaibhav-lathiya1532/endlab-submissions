.section .data
arr: .space 8000000
in: .space 8
str: .string "%lld"
str1: .string "%lld "
str2: .string "\n"

.section .text
.global main

main:
addi sp,sp,-16
sd ra,8(sp)
sd s10,0(sp)
la a0,str
la a1,in
call scanf
la a1,in
ld s0,0(a1)  #s0=n
li s1,0

inpu:
beq s1,s0,tra
li s2,0

inpuin:
beq s2,s0,ch
la a0,str
la a1,in
call scanf
la a1,in
ld t1,0(a1)  #t1 has curr value
la a1,arr
mul t2,s1,s0
add t3,t2,s2
li t4,8
mul t5,t3,t4
add t6,t5,a1
sd t1,0(t6)
addi s2,s2,1
beq a0,a0,inpuin

ch:
addi s1,s1,1
beq a0,a0,inpu

tra:
la a1,arr
li s1,0

train:
beq s1,s0,rev
addi s2,s1,1

traou:
beq s2,s0,ch1
la a1,arr
mul t2,s1,s0
add t3,t2,s2
li t4,8
mul t5,t3,t4
add t6,t5,a1
ld s4,0(t6)
mul t2,s2,s0
add t3,t2,s1
li t4,8
mul t5,t3,t4
add s6,t5,a1
ld s5,0(s6)
sd s4,0(s6)
sd s5,0(t6)
addi s2,s2,1
beq a0,a0,traou

ch1:
addi s1,s1,1
beq a0,a0,train

rev:
li s1,0
li s9,2
div s7,s0,s9


revin:
beq s1,s0,pri
li s2,0

revout:
beq s2,s7,ch2
la a1,arr
mul t2,s1,s0
add t3,t2,s2
li t4,8
mul t5,t3,t4
add t6,t5,a1
ld s4,0(t6)
addi s8,s0,-1
sub s8,s8,s2
mul t2,s1,s0
add t3,t2,s8
li t4,8
mul t5,t3,t4
add s10,t5,a1
ld s5,0(s10)
sd s4,0(s10)
sd s5,0(t6)
addi s2,s2,1
beq a0,a0,revout

ch2:
addi s1,s1,1
beq a0,a0,revin

pri:
li s1,0

outo:
beq s1,s0,fin
li s2,0

outi:
beq s2,s0,ch3
la a1,arr
mul t2,s1,s0
add t3,t2,s2
li t4,8
mul t5,t3,t4
add t6,t5,a1
ld t1,0(t6)
la a0,str1
addi a1,t1,0
call printf
addi s2,s2,1
beq a0,a0,outi

ch3:
addi s1,s1,1
la a0,str2
call printf
beq a0,a0,outo

fin:
ld ra,8(sp)
ld s10,0(sp)
addi sp,sp,16
ret