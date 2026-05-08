.section .rodata
fmt:
.string "%lld"

fmt2:
.string "%lld\n"

.text
.globl main
main:
addi sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 40(sp)

lla a0, fmt
addi a1, sp, 24
call scanf

ld s0, 24(sp)

lla a0, fmt
addi a1, sp, 32
call scanf

ld s1, 32(sp)

slli t0, s0, 3
sub sp, sp, t0
mv s2, sp       # s2 = address of array
li t0, 0
read_loop:
bge t0, s0, next

slli t1, t0, 3
add t1, t1, s2
mv a1, t1
lla a0, fmt
call scanf

addi t0, t0, 1
j read_loop

next:
addi t1, s0, -1       # t1 = heavier index of array
li t0, 0              # t0 = lighter index
li t4, 0
loop:
bgt t0, t1, end

li t6, 0

slli t2, t0, 3
add t2, t2, s2
ld t3, 0(t2)

add t6, t3, t6
slli t2, t1, 3
add t2, t2, s2
ld t3, 0(t2)
add t6, t3, t6

ble t6, s1, one
j two

one:
addi t0, t0, 1
addi t1, t1, -1
addi t4, t4, 1
j loop

two:
addi t1, t1, -1
addi t4, t4, 1
j loop

end:
mv a1, t4
lla a0, fmt2
call printf

mv t0, s0
slli t0, t0, 3
add sp, sp, t0

ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 40(sp)
addi sp, sp, 48
li a0, 0
ret


















