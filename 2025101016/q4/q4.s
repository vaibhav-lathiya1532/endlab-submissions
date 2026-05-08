.section .rodata
    format_int4:                 .string "%ld %ld %ld %ld"
    format_int2:                 .string "%ld %ld"
    format_int:                  .string "%ld"

.section .text
.globl main

main:
# Index of registers
# ra - (120)
# t0 - price (112)
# t1 - inserted (104)
# t2 - change (96)(88)(80)(72)

addi sp,sp,-128
sd ra,120(sp)

addi t1,sp,8

lla a0, format_int2
mv a1, sp
mv a2, t1
call scanf

ld t0, 0(sp)
ld t1, 0(t1)

beq t0,t1,immvic

sub t0,t1,t0
sd t0, 112(sp)
sd t1, 104(sp)

li t2,0
twentyfive:
addi t2,t2,1
addi t0,t0,-25

bge t0,x0,twentyfive

addi t2,t2,-1
addi t0,t0,25
sd t2,96(sp)
sd t0, 112(sp)


li t2,0

ten:
addi t2,t2,1
addi t0,t0,-10

bge t0,x0,ten

addi t2,t2,-1
addi t0,t0,10
sd t2, 88(sp)
sd t0, 112(sp)


li t2,0

five:
addi t2,t2,1
addi t0,t0,-5

bge t0,x0,five

addi t2,t2,-1
addi t0,t0,5
sd t2,80(sp)
sd t0,112(sp)


li t2,0

one:
addi t2,t2,1
addi t0,t0,-1

bge t0,x0,one

addi t2,t2,-1
addi t0,t0,1
sd t2,72(sp)
sd t0,112(sp)


lla a0, format_int4
ld a1, 96(sp)
ld a2, 88(sp)
ld a3, 80(sp)
ld a4, 72(sp)
call printf

j wrap_up


immvic:
lla a0, format_int4
mv a1,x0
mv a2,x0
mv a3,x0
mv a4,x0
call printf

j wrap_up


wrap_up:
ld ra,120(sp)
addi sp,sp,128

ret

