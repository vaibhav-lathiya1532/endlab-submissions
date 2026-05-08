.data
fmt:
.string "%ld"
.text
.global main

main:
addi sp,sp,-64
sd x1,0(sp)
sd s0 ,8(sp) #n
sd s1,16(sp) #sum
sd s2,24(sp) #counter
sd s3,40(sp) #primecounter
sd s4,48(sp) #temp
la a0, fmt
addi a1,sp,32
call scanf 
ld s0,32(sp)



li s2,0
li s1,0

for:
beq s2,s0,done
la a0, fmt
addi a1,sp,32
call scanf 
ld s4,32(sp)
li s3,2
prime:
li t0,1
beq s4,t0,noprime
beq s3,s4,yesprime
rem t1,s4,s3
beq t1,x0,noprime
addi s3,s3,1
j prime

noprime:
addi s2,s2,1
j for

yesprime:
addi s2,s2,1
add s1,s1,s4
j for


done:
la a0,fmt
addi a1,s1,0
call printf
ld x1,0(sp)
ld s0 ,8(sp) #n
ld s1,16(sp) #sum
ld s2,24(sp) #counter
ld s3,40(sp) #primecounter
ld s4,48(sp) #temp
addi sp,sp,64
addi a0,x0,0
ret

