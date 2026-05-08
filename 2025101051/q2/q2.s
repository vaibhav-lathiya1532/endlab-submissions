.section .data
fmt: .asciz "%lld"
fmtprint1: .asciz "%lld "
fmtprint2: .asciz "%lld\n"

.section .bss
inp1: .space 8
inp2: .space 8

.section .text 
.globl main

main:
addi x2,x2,-64
sd x1 ,0(x2)
sd x18,8(x2)
sd x19,16(x2)
sd x20,24(x2)
sd x21,32(x2)
sd x22,40(x2)
la x10,fmt
la x11,inp1
call scanf
la x5,inp1
ld x18,0(x5)
la x10,fmt
la x11,inp2
call scanf
la x5,inp2
ld x19,0(x5)
blt x19,x18,inp1_big
li x20,0
li x21,0
li x22,0

j gcdcalc

inp1_big:
add x5,x19,x0
add x6,x18,x0
mv x18,x5
mv x19,x6



gcdcalc:
bge x22,x18,gcdmin
sub x28,x18,x22
rem x5,x18,x28
beqz x5,gcdcheck2

cont:
addi x22,x22,1
j gcdcalc

gcdcheck2:
rem x6,x19,x28
beqz x6,gcdfound
j cont


gcdmin:
li x11,1
j printgcd

gcdfound:
add x11,x28,x0

printgcd:
la x10,fmtprint1
call printf
li x22,1


lcmcalc:
bge x22,x18,lcmmax
mul x6,x19,x22
rem x5,x6,x18
beqz x5,lcmfound
addi x22,x22,1
j lcmcalc

lcmmax:
mul x7,x19,x18
mv x11,x7
j printlcm

lcmfound:
mv x11,x6

printlcm:
la x10,fmtprint2
call printf

done:
ld x1 ,0(x2)
ld x18,8(x2)
ld x19,16(x2)
ld x20,24(x2)
ld x21,32(x2)
ld x22,40(x2)
addi x2,x2,64
ret