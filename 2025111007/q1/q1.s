.section .data
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld\n"
n: .dword 0

.section .bss
array: .space 800

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

li t1,0

array_scan:
bge t1,t0,loop      #if i>=n 
la a0,fmt_in
slli t2,t1,3
la t3,array      
ld t4,0(t3)
add t3,t3,t2
ld a1,t3            #a1=&array[i]
call scanf
addi t1,t1,1
j array_scan

li t1,0
li t5,0             #max
li t6,0             #second

loop:
bge t1,t0,done      #if i>=n done
slli t2,t1,3
la t3,array
ld t3,0(t3)
add t3,t3,t2
ld t4,0(t3)         #t4=array[i]
bgt t4,t6,ch_second 

ch_second:
bgt t4,t5,ch_max 
mv t6,t4
j loop

ch_max:
mv t6,t5
mv t5,t4
j loop

done:
la a0,fmt_out
ld a1,t6
call printf

ld ra,8(sp)
li a0,0
ret
