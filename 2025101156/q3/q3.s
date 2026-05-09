.data
in: .string "%lld"
out: .string "%lld"
buffer: .space 800000
.text
.globl main
main:
addi sp,sp,64
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)

la a0,in
addi a1,sp,24
call scanf
ld a3,24(sp) # n
la s0,buffer
li s1,0 # index

array_in:
beq s1,a3,done_in
la a0,in
slli t1,s1,3
add t1,t1,s0
addi a1,t1,0
call scanf
ld a3,24(sp)
addi s1,s1,1
j array_in

done_in:
li s1,1
ld a3,24(sp)

prifix:
beq s1,a3,logic
addi t1, s1,-1
slli t2,t1,3
add t2,t2,s0
ld t3,0(t2) #arr[i-1]

slli t6,s1,3
add t6,t6,s0
ld t4,0(t6) #arr[i]

add t5,t4,t3
sd t5,0(t6)

ld a3,24(sp)
addi s1,s1,1
j prifix

logic:
li s1,0
ld a3,24(sp)
addi s2,a3,-1
loop:
beq s1,a3,exit
beq s1,x0,zerocase
addi t1,s1,-1
slli t1,t1,3
add t1,s0,t1
ld a7,0(t1)

slli t2,s1,3
add t2,s0,t2
ld a4,0(t2)

slli t3,s2,3
add t3,s0,t3
ld a6,0(t3)

sub t5,a6,a4
beq t5,a7,index_found
addi s1,s1,1
j loop

zerocase:
slli t1,s1,3
add t3,s0,t1
ld t4,0(t3)

slli t1,s2,3
add t3,t1,s0
ld a6,0(t3)  # arr[n-1]

sub t5,a6,t4
beq t5,x0,index_found
addi s1,s1,1

j loop

index_found:
la a0,out
addi a1,s1,0
call printf

ld ra,0(sp)
addi sp,sp,64
li a0,0
ret

exit:
li a1,-1
la a0,out
call printf
ld ra,0(sp)
addi sp,sp,64
li a0,0
ret
