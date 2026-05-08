.global main

.section .rodata
sc:
.string "%lld %lld"

pr:
.string "%lld "

nl:
.string "\n"

.section .text
main:
addi sp, sp, 32
sd ra, (sp)

lla a0, sc
addi a1, sp, 8
addi a2, sp, 16
call scanf

ld s0, 8(sp)
ld s1, 16(sp)
sub s0, s1, s0 #now s0 stores the difference between inserted and price

li a2, 0 #Represent number of denominations
li a3, 25 #Represents amount
l1:
blt s0, a3, e1
sub s0, s0, a3
addi a2, a2, 1
beq a0, a0, l1

e1:
lla a0, pr
addi a1, a2, 0
call printf

li a2, 0 #Represent number of denominations
li a3, 10 #Represents amount
l2:
blt s0, a3, e2
sub s0, s0, a3
addi a2, a2, 1
beq a0, a0, l2

e2:
lla a0, pr
addi a1, a2, 0
call printf

li a2, 0 #Represent number of denominations
li a3, 5 #Represents amount
l3:
blt s0, a3, e3
sub s0, s0, a3
addi a2, a2, 1
beq a0, a0, l3

e3:
lla a0, pr
addi a1, a2, 0
call printf

li a2, 0 #Represent number of denominations
li a3, 1 #Represents amount
l4:
blt s0, a3, e4
sub s0, s0, a3
addi a2, a2, 1
beq a0, a0, l4

e4:
lla a0, pr
addi a1, a2, 0
call printf

lla a0, nl
call printf

ld ra, (sp)
addi sp, sp, 32
ret
