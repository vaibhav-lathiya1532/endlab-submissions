.section .rodata
inp:
.string "%lld"
out:
.string "%lld "
out_n:
.string "%lld\n"

.section .data
.balign 8
matrix : .space 8000000 

.section .text
.globl main

main:

addi sp, sp, -80
sd ra, 8(sp)
sd s0, 16(sp)
sd s1, 24(sp)
sd s2, 32(sp)
sd s3, 40(sp)
sd s4, 48(sp)
sd s7, 56(sp)
sd s8, 64(sp)
sd s9, 72(sp)


la a0, inp
mv a1, sp
call scanf
ld s1, 0(sp)


mul s7, s1, s1
slli t0, s7, 3
#mv a0, t0
#call malloc
#mv s2, a0
la s2, matrix
mv s8, s2




input:


beqz s7, tr_init
la a0, inp
mv a1, s8
call scanf
addi s8, s8, 8 
addi s7, s7, -1
j input



tr_init:
li s3, 0

tr:
beq s3, s1, rev_init
addi s4, s3, 1

inner_tr:
beq s4, s1, inner_tr_end
mul t1, s3, s1
add t1, t1, s4
slli t1, t1, 3
add t1, t1, s2
ld t2, 0(t1)

mul t3, s4, s1
add t3, t3, s3
slli t3, t3, 3
add t3, t3, s2
ld t4, 0(t3)

sd t4, 0(t1)
sd t2, 0(t3)

addi s4, s4, 1
j inner_tr

inner_tr_end:
addi s3, s3, 1
j tr




rev_init:
li s3, 0
srai s0, s1, 1

rev:
beq s3, s1, print_init
li s4, 0

inner_rev:
beq s4, s0, inner_rev_end
mul t1, s3, s1
add t1, t1, s4
slli t1, t1, 3
add t1, t1, s2
ld t2, 0(t1)

mul t3, s3, s1

addi t4, s1, -1
sub t4, t4, s4

add t3, t3, t4
slli t3, t3, 3
add t3, t3, s2
ld t5, 0(t3)

sd t5, 0(t1)
sd t2, 0(t3)

addi s4, s4, 1
j inner_rev

inner_rev_end:
addi s3, s3, 1
j rev






print_init:
li s3, 0
addi s9, s1, -1

print:
beq s3, s1, end
li s4, 0

inner_print:
beq s4, s9, inner_print_end
mul t1, s3, s1
add t1, t1, s4
slli t1, t1, 3
add t1, t1, s2
ld t2, 0(t1)
la a0, out
mv a1, t2
call printf
addi s4, s4, 1
j inner_print

inner_print_end:
mul t1, s3, s1
add t1, t1, s4
slli t1, t1, 3
add t1, t1, s2
ld t2, 0(t1)
la a0, out_n
mv a1, t2
call printf
addi s3, s3, 1
j print


end:

ld ra, 8(sp)
ld s0, 16(sp)
ld s1, 24(sp)
ld s2, 32(sp)
ld s3, 40(sp)
ld s4, 48(sp)
ld s7, 56(sp)
ld s8, 64(sp)
ld s9, 72(sp)
addi sp, sp, 80



ret
