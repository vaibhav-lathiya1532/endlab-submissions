.section .data
inp: .asciz "%lld"
pos: .asciz "1\n"
neg: .asciz "0\n"
out: .asciz "%lld\n"

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

la a0, inp
addi a1, sp , 8
call scanf

ld s1, 8(sp) #s1 stores the numbers

li s3, 0 #loop counter
li s4, 100 #max
li s5, 10 #for division
li s6, 1 #to check if happy

loop:
beq s3, s4, false

li s2, 0

#first get the sum of the squares of each digit in s1, store it in s2
in_loop:
ble s1, x0, end_in_loop
rem t5, s1, s5
div s1, s1, s5

mul t5, t5, t5

add s2, s2, t5

j in_loop
end_in_loop:


beq s2, s6, true

mv s1, s2

addi s3, s3, 1
j loop
false:
la a0, neg
call printf
j end
true:
la a0, pos
call printf

end:

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
