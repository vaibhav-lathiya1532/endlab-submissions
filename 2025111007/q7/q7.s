.section .data
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld\n"
n: .dword 0

.section .text 
.globl main
.extern scanf
.extern printf

main:
addi sp,sp,-16
sd ra,8(sp)

la a0,fmt_in
la a1,n
call scanf
la t1,n
ld t0,0(t1)         #t0=n

mv t2,t0
li t3,0
li t4,10

count:
ble t2,zero,countend
div t2,t2,t4
addi t3,t3,1
j count

countend:
li t6,0

loop:
ble t0,zero,loopend
rem t2,t0,t4
mv t5,t3
li t1,1

power:
ble t5,zero,powerend
mul t1,t1,t2
addi t5,t5,-1
j power

powerend:
add t6,t6,t1
div t0,t0,t4
j loop

loopend:
la a0,fmt_out
ld a1,0(t6)
call printf

ld ra,8(sp)
add sp,sp,16
li a0,0
ret
