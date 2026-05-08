.data
input: .string "%d"
n: .space 8
true: .string "TRUE"
false: .string "FALSE"

.text
.globl main

pow:
li t0, 1
loop_pow:
beq a1, zero, end_pow
addi a1, a1, -1
mul t0, t0, a0
jal zero, loop_pow
end_pow:
mv a0, t0
ret

main:
addi sp, sp, -16
sd ra, 0(sp)
la a0, input
la a1, n
call scanf
la t0, n
ld t0, 0(t0) # n
li t1, 0 # length
mv t2, t0
mv t5, t0
loop1:
beq t2, zero, loop1_end
addi t1, t1, 1
li t3, 10
div t2, t2, t3
jal zero, loop1
loop1_end:
li t2, 0 # val
loop2:
beq t0, zero, loop2_end
li t3, 10
rem a0, t0, t3
mv a1, t1
sd t0, 8(sp)
call pow
ld t0, 8(sp)
add t2, t2, a0
div t0, t0, t3
addi t1, t1, -1
jal zero, loop2
loop2_end:
beq t2, t5, yes
no:
la a0, false
call printf
jal zero, end
yes:
la a0, true
call printf
end:
ld ra, 0(sp)
addi sp, sp, 16
li a0, 0
ret
