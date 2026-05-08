.section .rodata
fmt1 : .string "%lld"
fmt2: .string "%lld\n"
fmt3 : .string "%lld %lld\n"


.section .text

.global main

main:

addi sp,sp,-128
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


la a0,fmt1
addi sp,sp,-16
mv a1,sp
call scanf

ld s0,0(sp)
addi sp,sp,16

slli t0,s0,3

mv a0,t0
call malloc

mv s1,a0

mv s2,s1

li s3,0

input:

beq s3,s0,input_done

la a0,fmt1
mv a1,s2
call scanf
addi s2,s2,8
addi s3,s3,1
j input

input_done:

li s4,-1000000
li s6,-1000000

li s5,0

loop:

beq s0,s5,done


ld s8,0(s1)

bgt s8,s4,foundbigger
addi s5,s5,1
addi s1,s1,8
j loop


foundbigger:

bgt s8,s6,changemax
bne s8,s6,l1
addi s5,s5,1
addi s1,s1,8
j loop

l1:
mv s4,s8
addi s5,s5,1
addi s1,s1,8

j loop

changemax:
mv s4,s6
mv s6,s8
addi s5,s5,1
addi s1,s1,8
j loop




done:

la a0,fmt2
mv a1,s4
call printf


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
addi sp,sp,128
ret