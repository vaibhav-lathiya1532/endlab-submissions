.data
scan_fmt: .asciz "%ld"
print_fmt: .asciz "%ld "
newline: .asciz "\n"

.section .text
.globl main

main:
addi sp, sp, -32
sd ra, 24(sp)
mv a1, sp
la a0, scan_fmt
call scanf
ld s0, 0(sp)
mv a1, sp
la a0, scan_fmt
call scanf
ld s1, 0(sp)

li s2, 1
li s3, 1

calc_gcd:
bgt s2, s0, found_gcd
rem t0, s0, s2
beqz t0, check_next
j next_iter_gcd

check_next:
rem t0, s1, s2
beqz t0, update_gcd
j next_iter_gcd

update_gcd:
mv s3, s2
j next_iter_gcd

next_iter_gcd:
addi s2, s2, 1
j calc_gcd

found_gcd:
mv a1, s3
la a0, print_fmt
call printf

bge s0, s1, set_to
blt s0, s1, set_lo
set_to:
mv s2, s0
set_lo:
mv s2, s1

mul s3, s0, s1  #high lim
mv s4, s2 #final lcm

calc_lcm:
beq s4, s3, found_lcm
rem t0, s4, s0
beqz t0, check_next_1
j next_iter_lcm

check_next_1:
rem t0, s4, s1
beqz t0, update_lcm
j next_iter_lcm

update_lcm:
mv s2, s4
j found_lcm

next_iter_lcm:
addi s4, s4, 1
j calc_lcm

found_lcm:
mv a1, s4
la a0, print_fmt
call printf

la a0, newline
call printf

ld ra, 24(sp)
addi sp, sp, 32
li a0, 0
ret
