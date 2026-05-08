.section .data
inp: .asciz "%lld"
out: .asciz "%lld\n"
deb: .asciz "aaa\n"

.section .text
.globl main
.extern scanf
.extern malloc
.extern printf

main:
addi sp, sp, -80
sd ra, 0(sp)
sd s1, 16(sp) #n
sd s2, 24(sp) #address of array
sd s3, 32(sp) #loop counter
sd s4, 40(sp) #total sum
sd s5, 48(sp)
sd s6, 56(sp)
sd s7, 64(sp)


addi a1, sp, 8
la a0, inp
call scanf

ld s1, 8(sp)

mv t0, s1
slli t0, t0, 3 #n*8 bytes
mv a0, t0
call malloc
mv s2, a0


#taking input now
li s3, 0
inputloop:
beq s3, s1, endinput
slli t0, s3, 3
add t1, t0, s2 
#byte adress of current element in array

la a0, inp
mv a1, t1
call scanf


addi s3, s3, 1
j inputloop
endinput:

li s3, 0
li s4, 0

loop:

beq s3, s1, end
slli t6, s3, 3
add t6, t6, s2
ld s6, 0(t6)

li t4, 1
beq s6, t4, yesprime

li s5, 2 #counter of all smaller numbers
is_prime:
beq s5, s6, yesprime
rem s7, s6, s5
beq s7, x0, noprime
addi s5, s5, 1
j is_prime
yesprime:
add s4, s4, s6
noprime:

addi s3, s3, 1

j loop
end:

la a0, out
mv a1, s4
call printf

li a0, 0

ld ra, 0(sp)
ld s1, 16(sp) #n
ld s2, 24(sp) #address of array
ld s3, 32(sp) #loop counter
ld s4, 40(sp) #total sum
ld s5, 48(sp)
ld s6, 56(sp)
ld s7, 64(sp)
addi sp, sp, 80
ret
