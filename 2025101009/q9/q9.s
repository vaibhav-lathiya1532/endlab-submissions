.globl main 

.section .data 

fmt_int: .string "%lld" 
n: .space 8 
one: .string "1\n" 
zero: .string "0\n" 

.section .text 

main: 
addi sp, sp, -48 
sd ra, 40(sp)
sd s0, 32(sp) #n 
sd s1, 24(sp) #no of iterations 
sd s2, 16(sp) #sum of squares 
sd s3, 8(sp) 
sd s4, 0(sp) 

la a0, fmt_int 
la a1, n 
call scanf 

la t0, n 
ld s0, 0(t0)

li s1, 0 
li s2, 0 
li t1, 10 
li t3, 1 
li t4, 4
li t2, 100
li t5, 0 

solve: 
beq s0, t5, check 
rem s3, s0, t1
div s0, s0, t1 
mul s3, s3, s3 
add s2, s2, s3 
j solve 

check: 
beq s2, t3, print_one 
beq s2, t4, print_zero 
addi s1, s1, 1 
beq s1, t2, print_zero 
mv s0, s2 
li s2, 0 
j solve 

print_one: 
la a0, one 
call printf 
j done 

print_zero: 
la a0, zero 
call printf 

done: 
ld ra, 40(sp)
ld s0, 32(sp) 
ld s1, 24(sp) 
ld s2, 16(sp) 
ld s3, 8(sp) 
ld s4, 0(sp)
addi sp, sp, 48 
ret 


