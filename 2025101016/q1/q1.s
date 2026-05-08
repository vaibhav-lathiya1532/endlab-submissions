.section .rodata
    format_int:                 .string "%ld"

.section .text
.globl main

main:
# Index of registers
# ra - (120)
# t0 - N(112)
# t1 - array address(104)
# t2 - current address(96)
# t3 - max(88)
# t4 - counter(80)
# t5 - secondmax(72)


addi sp,sp,-128
sd ra,120(sp)

lla a0,format_int
mv a1,sp
call scanf

ld t0,0(sp)
addi t0,t0,-2
sd t0,112(sp)

mv a0,t1
call malloc

ld t0,112(sp)
mv t1,a0
sd t1,104(sp)
mv t2,t1
sd t2,96(sp)


lla a0, format_int
mv a1,t2
call scanf



lla a0, format_int
mv a1,t2
call scanf

ld t0, 112(sp)
ld t1, 104(sp)
ld t2, 96(sp)
mv t3, a0
sd t3, 88(sp)
li t4,0
sd t4, 80(sp)
li t5,0
sd t5, 72(sp)


lla a0, format_int
mv a1,t2
call scanf

ld t0, 112(sp)
ld t1, 104(sp)
ld t2, 96(sp)
ld t3, 88(sp)
ld t4, 80(sp)
ld t5, 72(sp)


bgt a0, t3, newmax
mv t5, a0
sd t5, 72(sp)


loop:
beq t4,t0,wrap_up

sd t0, 112(sp)
sd t1, 104(sp)
sd t2, 96(sp)
sd t3, 88(sp)
sd t4, 80(sp)
sd t5, 72(sp)

lla a0, format_int
mv a1,t2
call scanf

ld t0, 112(sp)
ld t1, 104(sp)
ld t2, 96(sp)
ld t3, 88(sp)
ld t4, 80(sp)
ld t5, 72(sp)

sd a0, 0(t2)

addi t2,t2,8
sd t2,96(sp)

addi t4,t4,1

bgt a0,t3,newmax
bgt a0,t5,newsecondmax

j loop



newmax:
mv t5,t3
sd t5, 72(sp)

mv t3,a0
sd t3,88(sp)

j loop


newsecondmax:
mv t5,a0
sd t5, 72(sp)

j loop







wrap_up:

lla a0, format_int
mv a0,t5
call printf


ld ra,120(sp)
addi sp,sp,128

ret
