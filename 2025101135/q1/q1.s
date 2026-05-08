.section .rodata
print_true: .asciz "TRUE\n"
print_false: .asciz "FALSE\n"
scan: .asciz "%lld"

.section .text
.global main
.extern scanf
.extern printf 
.extern malloc

main:
addi sp,sp,-48
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)

addi sp,sp,-8
la a0,scan
mv a1,sp
call scanf
ld s0,0(sp)
addi sp,sp,8

mv a0,s0
slli a0,a0,3
call malloc
mv s1,a0

li s2,0


inlo:
beq s2,s0,chelo

addi sp,sp,-8
la a0,scan
mv a1,sp
call scanf
ld t1,0(sp)
addi sp,sp,8

slli t0,s2,3
add t0,s1,t0
sd t1,0(t0)
addi s2,s2,1
j inlo


chelo:
li t5,1
beq s0,t5,fal
beqz s2,tr
li t2,2

#check current
slli t0,s2,3
addi t0,t0,-8
add t0,t0,s1
ld t0,0(t0)
rem t0,t0,t2
beq s2,s0,first
beq t0,s3,fal 

first:
mv s3,t0
addi s2,s2,-1
j chelo

tr:
la a0,print_true
j ex

fal:
la a0,print_false

ex:
call printf
ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
addi sp,sp,48
ret




