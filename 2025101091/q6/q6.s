.section .rodata
fmtscan:
.string "%s"
fmt:
.string "%d"
.section .text
.globl main
main:
addi sp,sp,-64
sd ra,56(sp)
sd s0,48(sp)
sd s1,40(sp)
sd s2,32(sp)
sd s3,24(sp)
#input string 
lla a0,fmtscan
addi a1,sp,0
call scanf
addi s0,sp,0         # s0 me tera string ka add 

# stack 
li s1,-1           #top == -1
li a0,80
call malloc 
mv s2,a0               # s2 me stack ka add 

function:
lb t0,0(s0)
beq t0,x0,end

li t1,'+'
beq t0,t1,plus
li t1,'-'
beq t0,t1,min
li t1,'*'
beq t0,t1,mul
li t1,'+'
beq t0,t1,div

#push krna pdega 
li t2,'0'
sub t3,t0,t2 #integer me bdla 

#top++
addi s1,s1,1
slli t4,s1,3
add t4,t4,s2 #8*i + offset 
sd t5,0(t3)

addi s0,s0,1
j function
#----------plus--------
plus:
#pop a 
slli t5,s1,3
add t5,t5,s2 
ld t1,0(t5)

#t1 = a
addi s1,s1,-1 #top --
slli t5,s1,3
add t5,t5,s2 
ld t2,0(t5)
#t2 me b

add t3,t1,t2
sd t3,0(s1)
addi s2,s2,1
j function

#--------------min----------
min:
#pop a 
slli t5,s1,3
add t5,t5,s2 
ld t1,0(t5)

#t1 = a
addi s1,s1,-1 #top --
slli t5,s1,3
add t5,t5,s2 
ld t2,0(t5)
#t2 me b

sub t3,t1,t2
add t1,t1,s2
sd t3,0(s1)
addi s2,s2,1
j function
addi a1,sp,0
addi a1,sp,0
call scanf

#-------------mul--------


mul:
#pop a 
slli t5,s1,3
add t5,t5,s2 
ld t1,0(t5)

#t1 = a
addi s1,s1,-1 #top --
slli t5,s1,3
add t5,t5,s2 
ld t2,0(t5)
#t2 me b

mul t3,t1,t2
sd t3,0(s1)
addi s2,s2,1
j function

#--------------div--------


div:
#pop a 
slli t5,s1,3
add t5,t5,s2 
ld t1,0(t5)

#t1 = a
addi s1,s1,-1 #top --
slli t5,s1,3
add t5,t5,s2 
ld t2,0(s1)
#t2 me b

div t3,t1,t2
sd t3,0(t2)
addi s2,s2,1
j function


end:
slli t1,s1,3
add t1,t1,s2
mv s3,t1
lla a0,fmt
mv a1,s3
call printf

done:
ld s3,24(sp)
ld s2,32(sp)
ld s1,40(sp)
ld s0,48(sp)
ld ra,56(sp)
addi sp,sp,64
ret











