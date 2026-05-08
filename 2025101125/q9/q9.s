.globl main
main:
addi sp,sp,-16
sd ra,0(sp)

la a0,fmtin
addi a1,sp,8
call scanf

ld s0,8(sp)

addi s1,x0,100
addi s2,x0,1
addi s3,x0,10

loop:
beq s0,s2,yes
beq s1,x0,no

addi t0,x0,0
loop2:
beq s0,x0,break2
rem t2,s0,s3
mul t2,t2,t2
add t0,t0,t2
div s0,s0,s3
jal x0,loop2
break2:
addi s0,t0,0
addi s1,s1,-1
jal x0,loop

yes:
la a0,yesstr
call printf
jal x0,end

no:
la a0,nostr
call printf
end:
ld ra,0(sp)
addi sp,sp,16
ret



.data
fmtin: .string "%lld"
yesstr: .string "1\n"
nostr: .string "0\n"
