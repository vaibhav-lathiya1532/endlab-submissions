.data
input: .string "%lld"
true: .string "TRUE"
false: .string "FALSE"
n: .space 8

.text
.globl main

main:
addi sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
la a0, input
la a1, n
call scanf
la s0, n
ld s0, 0(s0) # n
li s1, -1 # prev
li s3, 1 # ans
loop1:
la a0, input
la a1, n
call scanf
la s2, n
ld s2, 0(s2) # cur no
andi t0, s2, 1
li t1, -1
beq s1, t1, ok
beq t0, s1, notok
ok:
mv s1, t0
addi s0, s0, -1
li t0, 1
bge s0, t0, loop1
jal zero, end
notok:
li s3, 0
end:
beq s3, zero, no
yes:
la a0, true
call printf
jal zero, fin
no:
la a0, false
call printf
fin:
ld s3, 32(sp)
ld s2, 24(sp)
ld s1, 16(sp)
ld s0, 8(sp)
ld ra, 0(sp)
addi sp, sp, 48
li a0, 0
ret
