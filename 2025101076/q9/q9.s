.section .data

fmt: .string "%lld"
fmt2: .string "%d\n"


.section .text

.globl main

main:

addi sp,sp,-64
sd ra,56(sp)
sd s0,48(sp)
sd s1,40(sp)
sd s2,32(sp)
sd s3,24(sp)
sd s4,16(sp)
sd s5,8(sp)

lla a0,fmt
addi a1,sp,0
call scanf

ld s0,0(sp) 

addi s1,x0,100
addi s2,x0,10
addi s3,s0,0
addi s4,x0,1

loop:
beqz s1,exit_loop

beq s3,s4,happy
addi t1,s3,0
addi s5,x0,0 

inner_loop:
    beqz t1,exit_innerloop
    rem t0,t1,s2
    mul t0,t0,t0
    add s5,s5,t0
    div t1,t1,s2
    j inner_loop

exit_innerloop:
beq s5,s4,happy
addi s3,s5,0
addi s1,s1,-1

j loop

exit_loop:
lla a0,fmt2
addi a1,x0,0
call printf

ld ra,56(sp)
ld s0,48(sp)
ld s1,40(sp)
ld s2,32(sp)
ld s3,24(sp)
ld s4,16(sp)
ld s5,8(sp)

addi sp,sp,64

ret

happy:

lla a0,fmt2
addi a1,x0,1
call printf

ld ra,56(sp)
ld s0,48(sp)
ld s1,40(sp)
ld s2,32(sp)
ld s3,24(sp)
ld s4,16(sp)
ld s5,8(sp)

addi sp,sp,64

ret
