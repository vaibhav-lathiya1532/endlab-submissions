.data

input: .string "%lld"
output: .string "%lld"

yes: .string "TRUE\n"
no: .string "FALSE\n"

n: .word 0

.text
.global main
main:

addi sp,sp,-80
sd s0,0(sp) #n
sd s1,8(sp) #digits
sd s2,16(sp) #sum
sd s3,24(sp) #rem
sd s4,32(sp) 
sd s5,40(sp)
sd s6,48(sp) 
sd s7,56(sp) 
sd s8,64(sp) #n


la a0,input
la a1,n
call scanf


la t0,n
ld s0, 0(t0)
mv s8,s0

#s8 and s0 are both n

li s1,0
mv s2,s0
li t1,10

digits:

#this finds the number of digits
bge x0,s2,next
addi s1,s1,1
div s2,s2,t1
j digits


next:

li s2,0
li t5,10

while:
bge x0,s0,done
rem s3,s0,t5
#take remainder and exponentiate that, then add to total sum and reduce s1
li s7,1
mv s4,s1

#exp with s3, use s7 for holding,use s4 for s1
exp:
bge x0,s4,n2
mul s7,s7,s3
addi s4,s4,-1
j exp


n2:
add s2,s2,s7
addi s1,s1,-1
div s0,s0,t5
j while

done:

beq s8,s2,true

#if s8 and s2 (n and sum) are equal,then true. else false

false:
la a0,no
call printf
j n3

true:
la a0,yes
call printf
j n3

n3:

ld s0,0(sp) #n
ld s1,8(sp) #array
ld s2,16(sp) #i
ld s3,24(sp)
ld s4,32(sp)
ld s5,40(sp)
ld s6,48(sp)
ld s7,56(sp)
ld s8,64(sp) 


addi sp,sp,80


li a0,0
call exit

