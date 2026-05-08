.section .data
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"
.section .bss
array: .space 800000
.section .text
.globl main
main:
addi sp,sp,-64
sd ra,8(sp)
sd s0,16(sp)
sd s1,24(sp)
sd s2,32(sp)
sd s3,40(sp)
la a0,fmt_in
mv a1,sp
call scanf
ld s0,0(sp)


#printcheck:
#la a0,fmt_out
#mv a1,s0
#call printf

mv s1,x0
la s2,array #s2=address
mv s3,s2


inputloop:
bge s1,s0,inputloopend
la a0,fmt_in
mv a1,s3 #address to store array
call scanf

#printcheckinloop
#ld t6,0(s3)
#la a0,fmt_out
#mv a1,t6
#call printf

addi s1,s1,1
addi s3,s3,8
beq x0,x0,inputloop
inputloopend:

mv s1,x0
mv s3,s2
li t0,-100000000
li t1,-100000001
loop:
bge s1,s0,loopend
ld t2,0(s3)
bgt t2,t0,largest
bgt t2,t1,secondlargest
here:

addi s1,s1,1
addi s3,s3,8
beq x0,x0,loop
loopend:

la a0,fmt_out
mv a1,t1
call printf

ld ra,8(sp)
ld s0,16(sp)
ld s1,24(sp)
ld s2,32(sp)
ld s3,40(sp)
addi sp,sp,64
ret

largest:
mv t1,t0
mv t0,t2
beq x0,x0,here

secondlargest:
beq t2,t0,here
mv t1,t2
beq x0,x0,here
