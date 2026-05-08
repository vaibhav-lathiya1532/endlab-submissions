
.section .rodata
fmt:
.string "%lld"

out:
.string "%lld\n"

.text
.globl main
main:
addi sp, sp, -64
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
sd s4, 40(sp)
sd s5, 48(sp)

lla a0, fmt
addi a1, sp, 56
call scanf

ld s0, 56(sp)

mv t0, s0
slli t0, t0, 3
sub sp, sp, t0
mv s1, sp

li t0, 0           # t0 = index of the array while taking input
read_loop:
beq t0, s0, read_target
slli t1, t0, 3
add t1, t1, s1
mv a1, t1

lla a0, fmt
call scanf

addi t0, t0, 1
j read_loop

read_target:
lla a0, fmt
addi sp, sp, -8
mv a1, sp
call scanf

ld s2, 0(sp)
addi sp, sp, 8

li t1, 0           # t1 = low
addi t2, s0, -1     # t2 = high

loop:
bgt t1, t2, not_found

# lla a0, out
# mv a1, t1
# call printf

# lla a0, out
# mv a1, t2
# call printf

sub t3, t2, t1
srli t3, t3, 1
add t3, t3, t1         # t3 = mid

slli t4, t3, 3
add t5, t4, s1
ld t6, 0(t5)           # t6 = arr[mid]

slli t4, t1, 3
add t5, t4, s1
ld a2, 0(t5)           # a2 = arr[low]

slli t4, t2, 3
add t5, t4, s1
ld a3, 0(t5)           # a3 = arr[high]

beq t6, s2, found

ble a2, t6, left_sorted
j right_sorted

right_sorted:
blt t6, s2, check_right_upper
j move_left

check_right_upper:
ble s2, a3, move_right
j move_left

left_sorted:
ble a2, s2, check_left_upper
j move_right

check_left_upper:
blt s2, t6, move_left
j move_right

move_left:
addi t2, t3, -1
j loop

move_right:
addi t1, t3, 1
j loop

found:
lla a0, out
mv a1, t3
call printf
j done

not_found:
# lla a0, out
# mv a1, t1
# call printf

# lla a0, out
# mv a1, t2
# call printf

lla a0, out
li a1, -1
call printf

done:
slli t0, s0, 3
add sp, sp, t0

ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld s4, 40(sp)
ld s5, 48(sp)
addi sp, sp, 64
li a0, 0
ret



















