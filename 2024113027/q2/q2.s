.section .rodata
inp:
.string "%lld"
out:
.string "%lld "
out_n:
.string "%lld\n"

.section .data
.balign
matrix : .space 8000000 

.section .text
.globl main

main:

addi sp, sp, -80
sd ra, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
sd s4, 40(sp)
sd s5, 48(sp)
sd s6, 56(sp)
sd s0, 64(sp)



la a0, inp
mv a1, sp
call scanf
ld s1, 0(sp)

la a0, inp
mv a1, sp
call scanf
ld s2, 0(sp)

beq s1, s2, easy
bgt s1, s2, big

small:
mv s3, s2

big:
mv s3, s1

li s4, 1
mv s5, s4
lcm:
bgt s4,s3, hcf
rem t0,s1, s4
beqz t0, div_1
addi s4,s4,1
j lcm

div_1:
rem t0,s2, s4
beqz t0, div_2
addi s4,s4,1
j lcm

div_2:
mv s5, s4
addi s4,s4,1
j lcm


hcf:
mul t0, s1, s2
div s6, t0, s5
j set

easy:

la a0, out
mv a1, s1
call printf

la a0, out_n
mv a1, s1
call printf
j end


set:

la a0, out
mv a1, s5
call printf

la a0, out_n
mv a1, s6
call printf

end:

ld ra, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld s4, 40(sp)
ld s5, 48(sp)
ld s6, 56(sp)
ld s0, 64(sp)
addi sp, sp, 80
ret
