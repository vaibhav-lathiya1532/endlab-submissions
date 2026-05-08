.data
fmtin: .string "%lld"
fmtout: .string "%lld\n"

arr: .space 800000



.text
.global main
main:

addi sp,sp,-16
la a0,fmtin

mv a1,sp
call scanf
ld t0,0(sp)
addi sp,sp,16
addi sp,sp,-16
la a0,fmtin

mv a1,sp
ld t1,0(sp)
addi sp,sp,16

mv s5,x0
ld t6,arr

loop1:
bge s5,t0,next
la a0,fmtin

slli t3,s5,3
addi s5,s5,1
add t3,t3,t6
mv a1,t3
call scanf
j loop1


next:
addi s5,s5,-1
mv s4,x0
add t0,x0,x0

loop2:
bgt s4,s5,printout
slli t3,s5,3
slli t5,s4,3
add t3,t3,t6
add t5,t5,t6
ld s0,0(t3)
ld s1,0(t5)
add s2,s0,s1
bgt s2,t1,new
addi s4,s4,1
new:
addi s5,s5,-1
addi t0,t0,1
j loop2

printout:
la a0,fmtout

mv a1,t0
call printf


ret






