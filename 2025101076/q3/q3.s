.section .data

fmt: .string "%d"
fmt2: .string "%d\n"

.section .text

.globl main

main:

addi sp,sp,-80
sd ra,72(sp)
sd s0,64(sp)
sd s1,56(sp)
sd s2,48(sp)
sd s3,40(sp)
sd s4,32(sp)
sd s5,24(sp)
sd s6,16(sp)
sd s7,8(sp)


addi a0,x0,100
call malloc

addi s0,a0,0

addi s1,x0,0 
addi s2,x0,25

addi t0,x0,2
sw t0,0(s0)

addi t0,x0,3
sw t0,4(s0)

addi t0,x0,5
sw t0,8(s0)

addi t0,x0,7
sw t0,12(s0)

addi s1,s1,4

addi s3,x0,10

init_loop:
bge s1,s2,exit_init_loop

lw t0,0(s0)
rem t1,s3,t0
beqz t1,not_prime

lw t0,4(s0)
rem t1,s3,t0
beqz t1,not_prime

lw t0,8(s0)
rem t1,s3,t0
beqz t1,not_prime

lw t0,12(s0)
rem t1,s3,t0
beqz t1,not_prime

addi t0,x0,4
mul t0,s1,t0
add t0,t0,s0
sw s3,0(t0)
addi s1,s1,1

addi s3,s3,1
j init_loop

not_prime:
addi s3,s3,1
j init_loop

exit_init_loop:

lla a0,fmt
addi a1,sp,0
call scanf

lw s1,0(sp) 
addi s2,x0,0

loop:
beqz s1,exit_loop

addi s1,s1,-1

lla a0,fmt
addi a1,sp,0
call scanf

lw s4,0(sp)

addi s3,x0,25

inner_loop:
    beqz s3,exit_innerloop

    addi s3,s3,-1
    addi t0,x0,4
    mul t0,s3,t0
    add t0,t0,s0
    lw s5,0(t0)

    beq s4,s5,exit_innerloop
    
    rem t1,s4,s5
    beqz t1,not_prime1

    j inner_loop

exit_innerloop:
add s2,s2,s4
j loop

not_prime1:
j loop

exit_loop:

lla a0,fmt2
addi a1,s2,0
call printf

ld ra,72(sp)
ld s0,64(sp)
ld s1,56(sp)
ld s2,48(sp)
ld s3,40(sp)
ld s4,32(sp)
ld s5,24(sp)
ld s6,16(sp)
ld s7,8(sp)

addi sp,sp,80

ret
