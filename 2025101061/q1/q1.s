.data 
fmt: .asciz "%lld"
fmt2: .asciz "%lld\n"

.text
.global main
main:
addi sp, sp, -80
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)

la a0, fmt
addi a1, sp, 40
call scanf
ld s0, 40(sp)           # s0 has n
slli a0, s0, 3
call malloc
addi s1, a0,0       # s1 is a pointer to my array

addi s2, x0, 0  # i=0
addi s3, x0, -1000 # s3 will store greatest int
addi t4, x0, 1000
mul s3, s3,t4
addi s3, s3, -1
loop:
beq s2, s0, break
la a0, fmt
slli a1, s2, 3
add a1, s1, a1
call scanf

slli t1, s2, 3
add t1, s1, t1
ld t5, 0(t1)
bge t5, s3, great
addi s2, s2,1
j loop

great:
addi s3, t5, 0
addi s2, s2,1
j loop

break:

addi t2, x0, 0  # j=0
addi t6, x0, -1000 # t2 will store 2nd greatest int
addi t4, x0, 1000
mul t6, t6,t4
addi t6, t6, -1

l1:
beq t2, s0, print
slli t1, t2, 3
add t1, s1, t1
ld t5, 0(t1)
bge t5, t6, ans
addi t2, t2,1
j l1

ans:
beq t5, s3, no
addi t6, t5,0
addi t2, t2,1
j l1

no:
addi t2, t2,1
j l1

print:
la a0,fmt2
addi a1, t6, 0
call printf

exit:
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld ra, 0(sp)
addi sp, sp, 80
ret