.section .data
input: .asciz "%lld"
output: .asciz "%lld "
endo: .asciz "%lld\n"
space: .asciz " "
newline: .asciz "\n"

.section .bss
.balign 8
p: .space 8
i: .space 8


.section .text

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

la a0,input
la a1,p
call scanf

la a0,input
la a1,i
call scanf

la t0,p
ld s0,0(t0) #s0 = price

la t0,i
ld s1,0(t0) #s1 = inserted

sub s2,s1,s0 #s2= money returned cant use this variable not be changed

li s8,0
li s9,0
li s10,0
li s11,0

loop1:
li t1,25

blt s2,t1,endloop1
addi s8,s8,1
addi s2,s2,-25
beq x0,x0,loop1



endloop1:

loop2:
li t1,10
blt s2,t1,endloop2
addi s9,s9,1
addi s2,s2,-10
beq x0,x0,loop2



endloop2:



loop3:
li t1,5
blt s2,t1,endloop3
addi s10,s10,1
addi s2,s2,-5
beq x0,x0,loop3



endloop3:

loop4:
li t1,1
blt s2,t1,endloop4
addi s11,s11,1
addi s2,s2,-1
beq x0,x0,loop4



endloop4:


add a1,s8,x0
la a0,output
call printf


add a1,s9,x0
la a0,output
call printf


add a1,s10,x0
la a0,output
call printf



add a1,s11,x0
la a0,endo
call printf


end:

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
li a0,0
ret
