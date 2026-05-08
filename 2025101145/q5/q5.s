.section .rodata
input: .string "%lld"
output: .string "%lld "
newline: .string "\n"

.section .bss
matrix: .space 800000

.section .text
.globl main
.extern scanf
.extern printf

main:
addi sp, sp, -96
sd ra, 0(sp)
sd s0, 8(sp) # Size of input array!
sd s1, 16(sp) # Base address of array!
sd s2, 24(sp) # Row index!
sd s3, 32(sp) # Column index!
sd s4, 40(sp) 
sd s5, 48(sp) # 's4' and 's5' will be use wherever necessary!

la a0, input
addi a1, sp, 56
call scanf
ld s0, 56(sp)

la s1, matrix
li s2, 0

inputing:
bge s2, s0, firstReset
li s3, 0

innerInputing:
bge s3, s0, firstContinue 
mul s4, s2, s0
add s4, s4, s3
slli s4, s4, 3
add s4, s1, s4
la a0, input
mv a1, s4
call scanf
addi s3, s3, 1
j innerInputing

firstContinue:
addi s2, s2, 1
j inputing

firstReset:
la s1, matrix
li s2, 0

transposing:
bge s2, s0, secondReset
addi s3, s2, 1

innerTransposing:
bge s3, s0, secondContinue
mul s4, s2, s0
add s4, s4, s3
slli s4, s4, 3
add s4, s1, s4
ld t0, 0(s4)

mul s5, s3, s0
add s5, s5, s2
slli s5, s5, 3
add s5, s1, s5
ld t1, 0(s5)

sd t0, 0(s5)
sd t1, 0(s4)
addi s3, s3, 1
j innerTransposing

secondContinue:
addi s2, s2, 1
j transposing

secondReset:
la s1, matrix
li s2, 0

reversing:
bge s2, s0, thirdReset
li t0, 0
addi t1, s0, -1

innerReversing:
bge t0, t1, thirdContinue
mul s4, s2, s0
add s4, s4, t0
slli s4, s4, 3
add s4, s1, s4
ld t2, 0(s4)

mul s5, s2, s0
add s5, s5, t1
slli s5, s5, 3
add s5, s1, s5
ld t3, 0(s5)

sd t2, 0(s5)
sd t3, 0(s4)
addi t0, t0, 1
addi t1, t1, -1
j innerReversing

thirdContinue:
addi s2, s2, 1
j reversing

thirdReset:
la s1, matrix
li s2, 0

printing:
bge s2, s0, done
li s3, 0

innerPrinting:
bge s3, s0, fourthContinue
mul s4, s2, s0
add s4, s4, s3
slli s4, s4, 3
add s4, s1, s4

ld a1, 0(s4)
la a0, output
call printf
addi s3, s3, 1
j innerPrinting

fourthContinue:
la a0, newline
call printf

addi s2, s2, 1
j printing

done:
ld ra, 0(sp)
ld s0, 8(sp) # Size of input array!
ld s1, 16(sp) # Base address of array!
ld s2, 24(sp) # Row index!
ld s3, 32(sp) # Column index!
ld s4, 40(sp) 
ld s5, 48(sp) # 's4' and 's5' will be use wherever necessary!
addi sp, sp, 96

li a0, 0
li a7, 93
ecall
