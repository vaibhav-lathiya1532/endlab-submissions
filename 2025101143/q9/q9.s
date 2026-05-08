.section .data
n: .space 8
percnlld: .string "%lld"
percnlldnewl: .string "%lld\n"

.section .text
.global main

main:
addi sp,sp,-48
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)
sd s4,40(sp)
la a0,percnlld
la a1,n
call scanf
la t0,n
ld s0,0(t0)      #s0=n
addi s1,x0,100
add s2,x0,x0     #s2=i
addi s3,x0,10
addi s4,x0,4
addi t6,x0,1

loop:
beq s2,s1,print_zer
add t4,x0,x0

inner_loop:
rem t1,s0,s3
div s0,s0,s3
mul t1,t1,t1
add t4,t4,t1
bne s0,x0,inner_loop

beq t4,s4,print_zer
beq t4,t6,print_one
add s0,x0,t4
addi s2,s2,1
j loop

print_zer:
la a0,percnlldnewl
add a1,x0,x0
call printf
j wraps

print_one:
la a0,percnlldnewl
addi a1,x0,1
call printf

wraps:
ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
addi sp,sp,48
ret






