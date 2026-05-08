.section .rodata
input: .string "%lld"
output: .string "%lld "
newline: .string "\n"

.section .text
.globl main
.extern scanf
.extern printf

main:
addi sp, sp, -96
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp) # Store the two numbers!
sd s2, 24(sp)
sd s3, 32(sp) # Store the gcd(a, b) and lcm(a, b) respectively!

la a0, input
addi a1, sp, 40
call scanf
ld s0, 40(sp)

la a0, input
addi a1, sp, 40
call scanf
ld s1, 40(sp)

mv t0, s0
mv t1, s1
mul t2, s0, s1 # a x b = gcd(a, b) x lcm(a, b)!

loop:
ble t1, zero, done
rem t3, t0, t1
mv t0, t1 # New 'a' = old 'b'!
mv t1, t3 # New 'b' = old 'a % b'!
j loop

done:
mv s2, t0
div s3, t2, s2

mv a1, s2
la a0, output
call printf

mv a1, s3
la a0, output
call printf

la a0, newline
call printf

ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp) # Store the two numbers!
ld s2, 24(sp)
ld s3, 32(sp) # Store the gcd(a, b) and lcm(a, b) respectively!
addi sp, sp, 96

li a0, 0
li a7, 93
ecall
