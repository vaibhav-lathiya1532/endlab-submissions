.data
fmtin: .string "%d"
fmtout: .string "%d"
nl: .string "\n"

mat: .space 4000000

.text
.global main
main:
la a0,fmtin
mv a1,sp
call scanf
ld s0,0(sp) #n

addi t0 x0,x0

iscan:
bge t0,s0,tp
mv t1,0

jscan:
bge t1,s0,inci
la a0,fmtin
mul t2,t0,s0
add t2,t2,t1
slli t2,t2,2
la t5,mat
add a1,t2,t5
call scanf
addi t1,t1,1
j jscan

inci:
addi t0,t0,1
j iscan

add t0,x0,x0

tp:
bge t0,s0,rev
addi t1,t0,1

jloop:
bge t1,s0,incri

mul t2,t0,s0
add t2,t2,t1
slli t2,t2,2
la t5,mat
add t2,t2,t5
mul t3,t1,s0
add t3,t3,t0
slli t3,t3,2
add t3,t3,t5
lw s1,0(t2)
lw s2,0(t3)
sw s2,0(t2)
sw s1,0(t3)
addi t1,t1,1
j jloop

incri:
addi t0,t0,1
j tp
add t0,x0,x0
add t1,x0,x0
rev:
srai t4,s0,1
bge t0,s0,printout
rloop:
bge t1,t4,ini
sub s5,s0,t1
slli s5,s5,2
slli t4,t1,2
lw s1,0(s5)
lw s2,0(t4)







