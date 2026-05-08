.section .data
fmt: .asciz "%lld"
fmtprint: .asciz "%lld "
fmtprintend: .asciz "%lld\n"

.section .bss
matrix: .space 8000000
n: .space 8

.section .text
.globl main

main:
addi x2,x2,-64
sd x1,0(x2)
sd x18,8(x2)
sd x19,16(x2)
sd x20,24(x2)
sd x21,32(x2)
sd x22,40(x2)
sd x23,48(x2)
sd x24,56(x2)
la x10,fmt
la x11,n
call scanf
la x5,n
ld x18,0(x5)
la x21,matrix
li x19,0

read_loop:
bge x19,x18,done_read
li x20,0
inner_read:
bge x20,x18,cont
mul x5,x19,x18
add x5,x20,x5
slli x5,x5,3
add x11,x5,x21
la x10,fmt
call scanf
addi x20,x20,1
j inner_read

cont:
addi x19,x19,1
j read_loop


done_read:
la x5,n
ld x18,0(x5)
li x19,0


transpose:
bge x19,x18,done_transpose
addi x20,x19,1
inner_transpose:
bge x20,x18,cont2
mul x5,x19,x18
add x5,x20,x5
slli x5,x5,3
add x22,x5,x21
mul x5,x20,x18
add x5,x5,x19
slli x5,x5,3
add x23,x5,x21
ld x6,0(x22)
ld x7,0(x23)
sd x6,0(x23)
sd x7,0(x22)
addi x20,x20,1
j inner_transpose

cont2:
addi x19,x19,1
j transpose

done_transpose:
la x5,n
ld x18,0(x5)
li x19,0
li x22,0
li x23,0

reverse:
bge x19,x18,print
srli x24,x18,1
li x20,0

inner_reverse:
bge x20,x24,cont3
mul x5,x19,x18
add x5,x20,x5
slli x5,x5,3
add x28,x5,x21
sub x6,x18,x20
addi x6,x6,-1
mul x7,x18,x19
add x7,x7,x6
slli x7,x7,3
add x29,x7,x21
ld x6,0(x28)
ld x5,0(x29)
sd x6,0(x29)
sd x5,0(x28)
addi x20,x20,1
j inner_reverse

cont3:
addi x19,x19,1
j reverse

print:
li x19,0
print_loop:
bge x19,x18,done
li x20,0
inner_print:
bge x20,x18,cont4
add x6,x18,-1
beq x20,x6,use_end
la x10,fmtprint
j accprint

use_end:
la x10,fmtprintend

accprint:
mul x5,x19,x18
add x5,x5,x20
slli x5,x5,3
add x28,x5,x21
ld x11,0(x28)
call printf
addi x20,x20,1
j inner_print

cont4:
addi x19,x19,1
j print_loop

done:
ld x1,0(x2)
ld x18,8(x2)
ld x19,16(x2)
ld x20,24(x2)
ld x21,32(x2)
ld x22,40(x2)
ld x23,48(x2)
ld x24,56(x2)
addi x2,x2,64
li x10,0
ret