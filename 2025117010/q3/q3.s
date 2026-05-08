.section .rodata
fmtin:
.string "%lld"
fmtout:
.string "%lld\n"

.section .text
.global main
main:

ld t0,-100032
add sp, sp, t0
sd ra, 100024(sp)
sd s0, 100016(sp)
sd s4, 100008(sp)
sd s5, 100000(sp)
li s5, 0

lla a0, fmtin
mv a1, s0
call scanf
mv s0, a0
addi s2, s0, 0
srli s1, s0, 3
addi s6, s2, 0
addi s6, s6, -1
mv a0, s2
mv a1, s5
call malloc

loop:
beqz s0, logical
lla a0, fmtin
mv a1, sp(s2)
call scanf
add a0, s5, a0
mv sp(s2), a0
addi s2, s2, 8
addi s0, s0, -1
j loop


logical:
li t4,0
li t3,0
li t2,0
logic:
beq t4, s6, notthere
ld t1, sp(t3), 0
add t2, t1, t2
sub s5, s5, t1
beq s5,t2, found
addi t4, t4, 1
addi t3, t3, 8
j logic

found:
mv a1,t4
lla a0, fmtout
call printf
j exit

notthere:
addi a1, x0, -1
lla a0, fmtout
call printf

exit:
sd t0,100032
ld ra, 100024(sp)
ld s0, 100016(sp)
ld s4, 100008(sp)
ld s5, 100000(sp)
add sp, sp, t0