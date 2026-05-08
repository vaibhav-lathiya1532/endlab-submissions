.section .rodata
fmt1:
.string "%lld"
fmt2:
.string "TRUE\n"
fmt3:
.string "FALSE\n"

.section .text
.globl main
power:
mv t0,a0 # base
mv t1,a1 # exponent to be raised to
li t2,1 

loop: beq t1,x0,go_to_end
mul t2,t2,t0
addi t1,t1,-1
j loop

go_to_end:
mv a0,t2
ret

main:
addi sp,sp,-64
sd ra,56(sp)
sd s0,48(sp)
sd s1,40(sp)
sd s2,32(sp)
sd s3,24(sp)
sd s4,16(sp)

lla a0,fmt1
addi a1,sp,0
call scanf
ld s0,0(sp) # s0=n

mv s3,s0 # copy of n
li s1,0 # number of digits in n
li s4,10

loop1: beq s3,x0,calculate
addi s1,s1,1
div s3,s3,s4
j loop1

calculate:
li s2,0 # sum
mv s3,s0 # copy of n

loop2: beq s3,x0,check
rem a0,s3,s4
mv a1,s1
call power
add s2,s2,a0
addi s1,s1,-1
div s3,s3,s4
j loop2

check:
beq s2,s0,true
lla a0,fmt3
call printf
j exit

true:
lla a0,fmt2
call printf

exit:
ld s4,16(sp)
ld s3,24(sp)
ld s2,32(sp)
ld s1,40(sp)
ld s0,48(sp)
ld ra,56(sp)
addi sp,sp,64
ret


