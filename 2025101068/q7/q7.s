.section .rodata
fmt1: .string "%lld"
fmt2: .string "TRUE\n"
fmt3: .string "FALSE\n"
fmt4: .string "%lld\n"

.section .text

.global main

count:
addi sp,sp,-48
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)


mv s0,a0
li s1,0
li t0,10


counter:

beq s0,zero,count_done
div s0,s0,t0
addi s1,s1,1
j counter


count_done:

mv a0,s1

ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
addi sp,sp,48

ret





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


addi sp,sp,-16
la a0,fmt1
mv a1,sp
call scanf

ld s0,0(sp)
addi sp,sp,16

#s0 stores n
mv a0,s0

jal ra,count

mv s11,s0

mv s1,a0
#s1 has no of digits


li s2,0
#s2 stores disarium  number
li s4,10

loop:

beq zero,s1,done 

rem s3,s0,s4
div s0,s0,s4
#s3 has last digit

mv t2,s3

li t1,1

inner:
beq t1,s1,inner_done

mul t2,t2,s3

addi t1,t1,1
j inner


inner_done:
add s2,s2,t2
addi s1,s1,-1

j loop


done:


beq s11,s2,found
la a0,fmt3
j exit


found:
la a0,fmt2



exit:

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



