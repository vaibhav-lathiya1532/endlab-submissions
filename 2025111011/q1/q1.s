.global main

.section .rodata
sc:
.string "%lld"
t:
.string "TRUE\n"
f:
.string "FALSE\n"

.section .text
main:
addi sp, sp, -16
sd ra, (sp)

addi a1, sp, 8
lla a0, sc
call scanf
ld s0, 8(sp) #s0 now has number of elements

li s1, 2 #It should hold remainder of last division
li s2, 0 #s2 holds number of iterations happened till now
li s3, 2 #Hard-coded to 2

loop:
bge s2, s0, exit
lla a0, sc
addi a1, sp, 8
call scanf
ld a1, 8(sp) #a1 now has inputted number

rem a1, a1, s3
beq s1, a1, false
addi s1, a1, 0
addi s2, s2, 1
beq a0, a0, loop

exit:

lla a0, t
call printf
beq a0, a0, return

false:
lla a0, f
call printf

return:
ld ra, (sp)
addi sp, sp, 16
ret