.data
scan_fmt: .asciz "%ld"
print_fmt: .asciz "%ld\n"

.section .text
.globl main

main:
addi sp, sp, -16
sd ra, 8(sp)
la a0, scan_fmt 
mv a1, sp
call scanf
ld s0, 0(sp)

slli a0, s0, 3
call malloc 
mv s1, a0

li s3, 0

read_loop:
bge s3, s0, read_target
slli t0, s3, 3
add t0, t0, s1
la a0, scan_fmt
mv a1, t0
call scanf
addi s3, s3, 1
j read_loop

read_target:
la a0, scan_fmt
mv a1, sp
call scanf 
ld s2, 0(sp)

li s3, 0
addi s4, s0, -1

bs_loop:
bgt s3, s4, not_found

sub s5, s4, s3
srli s5, s5, 1
add s5, s5, s3
slli t0, s5, 3
add t0, t0, s1
ld s6, 0(t0)

beq s6, s2, found

slli t0, s3, 3
add t0, t0, s1
ld t1, 0(t0)

slli t0, s4, 4
add t0, t0, s1
ld t2, 0(t0)

bgt t1, s6, search_right

search_left:
blt s2, t1, go_right
bge s2, s6, go_right

go_left:
addi s4, s5, -1
j bs_loop

search_right:
bgt s2, t2, go_left
ble s2, s6, go_left

go_right:
addi s3, s5, 1
j bs_loop

found:
mv a1, s5
j print_res

not_found: 
li a1, -1
j print_res

print_res:
la a0, print_fmt
call printf

mv a0, s1
call free

ld ra, 8(sp)
addi sp, sp, 16
li a0, 0
ret

