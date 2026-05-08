.data

input: .string "%lld"
output: .string "%lld"

yes: .string "TRUE\n"
no: .string "FALSE\n"

n: .word 0
a: .word 0
array: .space 800000

.text
.global main
main:

addi sp,sp,-80
sd s0,0(sp) #n
sd s1,8(sp) #array
sd s2,16(sp) #i
sd s3,24(sp)
sd s4,32(sp) #parity
sd s5,40(sp)
sd s6,48(sp) #previous parity
sd s7,56(sp) #flag

la a0,input
la a1,n
call scanf

#INPUTS N

la t0,n

ld s0, 0(t0)

la s1,array
li s2,0
li s4,2
li s7,0

scan:

bge s2,s0,true
la a0,input
la a1,a
call scanf

la t1,a

ld s3,0(t1)

slli t0,s2,3
add t0,t0,s1

sd s3,0(t0)
#SCAND AND STORES VAL IN array

#now s3 is our array element 0 for even 1 for odd
li t3,2
rem s5,s3,t3
#IF EVEN, MAKES FLAG 0, ELSE 1
beq x0,s5,even

odd:
mv s6,s4
li s4,1
beq s6,s4,f1
j l2

even:
mv s6,s4
li s4,0
beq s6,s4,f1
j l2


f1:
li s7,1
#FLAGS AS FALSE
j l2

l2:

addi s2,s2,1
j scan


true:
li t6,1
beq s7,t6,false
#IF FLAGGED

la a0,yes
call printf
j n1

false:
la a0,no
call printf
j n1

n1:

ld s0,0(sp) #n
ld s1,8(sp) #array
ld s2,16(sp) #i
ld s3,24(sp)
ld s4,32(sp)
ld s5,40(sp)
ld s6,48(sp)
ld s7,56(sp)

addi sp,sp,80


li a0,0
call exit

