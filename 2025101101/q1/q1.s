.section .data
int_fmt: .string "%lld"
new_line: .string "\n"

.section .text
.global main

main:
addi sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
sd s4, 40(sp)

addi sp,sp,-16
mv a1,sp
la a0, int_fmt
call scanf
ld s0, 0(sp)  # s0 stores 'n'
addi sp,sp,16

mv a0,s0
slli a0,a0,3
call malloc
mv s1, a0   #   s1 stores the base address

li s2, 0
input:
beq s2, s0, logic
slli s3, s2, 3
add s3,s3,s1
la a0, int_fmt
mv a1, s3
call scanf
addi s2, s2, 1
j input


logic:
li s2, 1
ld s3, 0(s1)    # s3 stores the second largest
ld s4, 0(s1)    # s4 storest the largest

getting_unique:
slli t0, s2, 3
add t0, s1, t0
ld t1, 0(t0)
bne t1, s4, compare
addi s2,s2,1
j getting_unique

compare:
bgt s4, t1, first_bigger
mv s4, t1
addi s2,s2,1
j loop

first_bigger:
mv s3, t1
addi s2,s2,1
j loop


loop:
beq s2, s0, print
slli t0, s2, 3
add t0, s1, t0
ld t1, 0(t0)
bgt t1, s4, max_update
beq t1, s4, equal_case
bgt t1, s3, second_update
addi s2,s2,1
j loop


max_update:
mv s3, s4
mv s4, t1
addi s2,s2,1
j loop


equal_case:
addi s2,s2,1
j loop

second_update:
mv s3, t1
addi s2,s2,1
j loop

print:
la a0, int_fmt
mv a1, s3
call printf

la a0, new_line
call printf

done:
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld s4, 40(sp)
addi sp, sp, 48
li a0,0
ret
