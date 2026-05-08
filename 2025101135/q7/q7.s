.section .rodata
print_true: .asciz "TRUE\n"
print_false: .asciz "FALSE\n"
print: .asciz "%lld\n"
scan: .asciz "%lld"

.section .text
.global main
.extern scanf
.extern printf 

main:
addi sp,sp,-48
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)
sd s4,40(sp)

addi sp,sp,-8
la a0,scan
mv a1,sp
call scanf
ld s0,0(sp)
mv s3,s0
addi sp,sp,8


mv t0,s0
li s1,0
li s2,0
li s4,10

count_digit:
beqz t0,digit_loop
div t0,t0,s4 
addi s1,s1,1
j count_digit

digit_loop:
beqz s1,br 
rem t0,s0,s4
div s0,s0,s4
mv t2,s1
li a0,1

power:
beqz t2,brpow
mul a0,a0,t0
addi t2,t2,-1
j power

brpow:
add s2,s2,a0
addi s1,s1,-1
j digit_loop

br:
beq s2,s3,tru  
la a0,print_false
j pri 

tru:
la a0,print_true

pri:
call printf
ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
addi sp,sp,48
ret

