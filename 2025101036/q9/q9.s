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
mv s2, s0
li s1, 0

loop:
li s3, 0
li t0, 100
bge s1, t0, nothappy
li t0, 1
beq s2, t0, happy
addi s1, s1, 1

check:
bge zero, s2, end
li t0, 10
rem a2, s2, t0
div s2, s2, t0
mul a3, a2, a2
add s3, s3, a3
j check

end:
mv s2, s3
j loop

happy:
lla a0, output
li a1, 1
call printf
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
addi sp, sp, 48
li a0, 0
ret

nothappy:
lla a0, output
li a1, 0
call printf
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
addi sp, sp, 48
li a0, 0
ret
