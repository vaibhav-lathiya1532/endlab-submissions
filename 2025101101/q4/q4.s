.section .data
int_fmt: .string "%lld "
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

ld s0, 8(a1)
ld s1, 16(a1)

mv a0, s0
call atoll
mv s0,a0

mv a0,s1
call atoll
mv s1,a0

#   s0 stores the first number
#   s1 stores the second number

sub s0, s1, s0
# s0 stores the sum we need to reach

logic:
li t1, 25
mv t0, s0
jal ra, calc
mv s1, t3
mv s0, t0

li t1, 10
mv t0, s0
jal ra, calc
mv s2, t3
mv s0, t0

li t1, 5
mv t0, s0
jal ra, calc
mv s3, t3
mv s0, t0

li t1, 1
mv t0, s0
jal ra, calc
mv s4, t3
mv s0, t0

j print

calc:
li t3, 0

loop:
blt t0, t1, loop_done
sub t0, t0, t1
addi t3, t3, 1
j loop


loop_done:
jalr x0, 0(ra)

print:
la a0, int_fmt
mv a1, s1
call printf

la a0, int_fmt
mv a1, s2
call printf

la a0, int_fmt
mv a1, s3
call printf

la a0, int_fmt
mv a1, s4
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
