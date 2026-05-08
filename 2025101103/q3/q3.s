.data
in: .string "%d"
out: .string "%d\n"

.text
.global main

main:
addi sp,sp,-128
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)
sd s4,40(sp)

la a0,in
ld a1,48(sp)
call scanf

ld s1,48(sp)
li t1,0
ld s2,56(sp)
li t2,0

read_loop:
bge t1,s1,done

ld a0,in
ld a1,64(sp)
call scanf

ld s3,64(sp)
addi t1,t1,1
li t4,2
mv t5,s3
addi t5,t5,-1
li s4,0
j isprime

isprime:
ble t4,t5,loop
beqz s4,increment
j read_loop

loop:
rem t6,s1,t4
addi t4,t4,1
beqz t6,yes
j isprime

yes:
addi s4,s4,1
j isprime

increment:
add t2,t2,s3
j read_loop

done:

la a0,out
mv s2,t2
la a1,s2
call printf

li a0,0

ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
addi sp,sp,128
