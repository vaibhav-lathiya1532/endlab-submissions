.section .data
in1: .space 8
in2: .space 8
sc: .string "%lld"
sc1: .string "%lld %lld \n"

.section .text
.global main

main:
addi sp,sp,-16
sd ra,8(sp)
sd s10,0(sp)
la a0,sc
la a1,in1
call scanf
la a1,in1
ld s0,0(a1) #s0=first
la a0,sc
la a1,in2
call scanf
la a1,in2
ld s1,0(a1)   #s1=second
li s2,0  #s2=gcd
li s3,0  #s3=lcm
beq a0,a0,logic

gcd:
beq a0,x0,done
addi s6,a0,0
rem a0,a1,a0
addi a1,s6,0
beq a0,a0,gcd

done:
ret


logic:
addi a0,s0,0
addi a1,s1,0
jal ra,gcd
addi s2,a1,0
div s4,s1,s2
mul s3,s0,s4


pri:
la a0,sc1
addi a1,s2,0
addi a2,s3,0
call printf
ld ra,8(sp)
ld s10,0(sp)
addi sp,sp,16
ret

