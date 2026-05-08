.data
fmt: .asciz "%d"
out: .asciz "%d\n"

.text
.extern printf
.extern scanf
.globl main

main:
addi sp,sp,-32
sd ra,24(sp)
sd s0,16(sp)
sd s1,8(sp)

la a0,fmt
mv a1,sp
call scanf
ld t0,0(sp)                 #t0=n=s0
addi s0,t0,0
li t1,0                     #t1=i=0
li t4,-1000001                  #a=-int=t4
li t5,-1000001                                      

loop:
bge t1,s0,done1

la a0,fmt
mv a1,sp
call scanf
ld t3,0(sp)

beq t3,t4,don
bgt t3,t4,gta
bgt t3,t5,gtb

j don

gta:            #num>a  -> gta   num<=a && num>b -> gtb
mv t5,t4
mv t4,t3
j don

gtb:
mv t5,t3

don:
addi t1,t1,1
j loop

done1:
la a0,out
mv a1,t5
call printf


ld ra,24(sp)
ld s0,16(sp)
ld s1,8(sp)
addi sp,sp,32
ret
