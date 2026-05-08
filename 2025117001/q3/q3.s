.section .rodata
in: .string "%lld"
out: .string "%lld\n"

.text
.globl main
main:
addi sp,sp,-48
sd ra,40(sp)
sd s0,32(sp)
sd s1,24(sp)
sd s2,16(sp)
sd s3,8(sp)
la a0,in
mv a1,sp
call scanf
ld s0,0(sp)
la a0,out
mv a0,s0
slli a0,a0,3
call malloc
mv s1,a0
li s2,0
li s3,0
loop:
bge s2,s0,fun
la a0,in
slli a1,s2,3
add a1,a1,s1
call scanf
slli a1,s2,3
add a1,a1,s1
ld t0,0(a1)
add s3,s3,t0
addi s2,s2,1
j loop

fun:
li s2,0
li t0,0
li t1,-1
floop:
bge s2,s0,end
slli t3,s2,3
add t3,t3,s1
ld t3,0(t3)
sub t2,s3,t0
sub t2,t2,t3
beq t0,t2,found
add t0,t0,t3
addi s2,s2,1
j floop

found:
mv t1,s2

end:
la a0,out
mv a1,t1
call printf
li a0,0
ld ra,40(sp)
ld s0,32(sp)
ld s1,24(sp)
ld s2,16(sp)
ld s3,8(sp)
addi sp,sp,48
ret
