.section .data
fmt_in: .string "%lld %lld"
fmt_out: .string "%lld %lld %lld %lld\n"
#fmt_test: .string "%lld %lld %lld \n"
.section .text
.globl main
main:
addi sp,sp,-48
sd ra,16(sp)
sd s0,24(sp)
sd s1,32(sp)
la a0,fmt_in
mv a1,sp
addi a2,a1,8
call scanf
ld a0,0(sp)
ld a1,8(sp)
sub t0,a1,a0

#printcheck:
#mv s0,a0
#mv s1,a1
#la a0,fmt_test
#mv a1,s0
#mv a2,s1
#mv a3,t0
#call printf
#mv a0,s0
#mv a1,s1


sub t0,a1,a0
mv a0,t0

li t5,25
mv a1,t5
call dividefunction

li t5,10
mv t1,a2
mv a1,t5
call dividefunction

li t5,5
mv t2,a2
mv a1,t5
call dividefunction

li t5,1
mv t3,a2
mv a1,t5
call dividefunction

mv t4,a2

la a0,fmt_out
mv a1,t1
mv a2,t2
mv a3,t3
mv a4,t4
call printf

ld ra,16(sp)
ld s0,24(sp)
ld s1,32(sp)
addi sp,sp,48
ret


dividefunction:
mv a2,x0
loop:
blt a0,a1,loopend
sub a0,a0,a1
addi a2,a2,1
beq x0,x0,loop
loopend:
#remainder is in a0,a2 has number of coins
ret

