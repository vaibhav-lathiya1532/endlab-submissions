.section .rodata
input: .string "%lld"
output: .string "%lld\n"

.text
.global main

main:
addi sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)

lla a0, input
addi a1, sp, 40
call scanf
ld s0, 40(sp)
mv s3, s0
li s1, 0
li s2, 0

inputloop:
bge zero, s3, logic
addi s3, s3, -1
addi sp, sp, -16
lla a0, input
mv a1, sp
call scanf
j inputloop

logic:
bge s2, s0, final
addi s2, s2, 1
ld a3, 0(sp)
addi sp, sp, 16
li t0, 1
beq a3, t0, logic
li a4, 2

primeloop:
mul a5, a4, a4
blt a3, a5, isprime
rem a6, a3, a4
beq a6, zero, logic
addi a4, a4, 1
j primeloop

isprime:
add s1, s1, a3
j logic

final:
lla a0, output
mv a1, s1
call printf
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
addi sp, sp, 48
li a0, 0
ret
