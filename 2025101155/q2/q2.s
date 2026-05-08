.data

fmt_input:
    .string "%lld %lld"
fmt_output:
    .string "%lld %lld\n"

.text
.globl main

main:

addi sp,sp,-40
sd ra,32(sp)
sd s0,24(sp) #num1
sd s1,16(sp)  #num2

la a0,fmt_input
addi a1,sp,8
addi a2,sp,0
call scanf
ld s0,8(sp)
ld s1,0(sp)

bge s0,s1,fixed_order #s0 should be >=s1
mv t0,s1
mv s1,s0
mv s0,t0

fixed_order:

mv t0,s0
mv t1,s1

gcd_calc:
    rem t2,t0,t1
    beqz t2,finish_gcd
    mv t0,t1
    mv t1,t2
    j gcd_calc

finish_gcd:#t1 will hold gcd

mul t0,s0,s1 #t0 is s0 into s1
div t2,t0,t1 #mult of num by gcd = lcm

la a0,fmt_output
mv a1,t1
mv a2,t2
call printf

ld ra,32(sp)
ld s0,24(sp)
ld s1,16(sp)
addi sp,sp,40
ret 







