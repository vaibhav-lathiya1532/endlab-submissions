.section .rodata
in: .string "%100s"
out: .string "%lld\n"

.text
.globl main
main:
addi sp,sp,-32
sd ra,24(sp)
sd s0,16(sp)
sd s1,8(sp)
li a0,105
call malloc
mv s0,a0
la a0,in
mv a1,s0
call scanf
li s1,0

loop:
lb t0,0(s0)
beq t0,x0,end
li t1,'0'
li t2,'9'
blt t0,t1,op
bgt t0,t2,op
addi sp,sp,-8
addi t0,t0,-48
sd t0,0(sp)
addi s0,s0,1
j loop

op:
ld t3,0(sp)
ld t4,8(sp)
addi sp,sp,8
li t5,'+'
beq t0,t5,add
li t5,'-'
beq t0,t5,sub
li t5,'*'
beq t0,t5,mul

add:
add t4,t4,t3
sd t4,0(sp)
addi s0,s0,1
j loop

sub:
sub t4,t4,t3
sd t4,0(sp)
addi s0,s0,1
j loop

mul:
mul t4,t4,t3
sd t4,0(sp)
addi s0,s0,1
j loop

end:
la a0,out
ld a1,0(sp)
call printf
li a0,0
addi sp,sp,8
ld ra,24(sp)
ld s0,16(sp)
ld s1,8(sp)
addi sp,sp,32
ret
