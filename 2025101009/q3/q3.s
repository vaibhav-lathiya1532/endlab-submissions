.globl main 

.section .data 
fmt_int: .string "%lld" 
fmt_out: .string "%lld\n" 
n: .space 8 
array: .space 8000 

.section .text 
main: 
addi sp, sp, -56
sd ra, 48(sp)
sd s0, 40(sp) #n 
sd s1, 32(sp) #array index 
sd s2, 24(sp) # sum 
sd s3, 16(sp) #iterations 
sd s4, 8(sp) 
sd s5, 0(sp)

la a0, fmt_int 
la a1, n 
call scanf 

la t0, n 
ld s0, 0(t0)

la t2, array 
ld s1, 0(t2)

li t1, 0 
li t4, 1 
li s4, 1 
li s2, 0 

input_loop: 
beq t1, s0, in_done 
mv t3, t1
slli t3, t3, 3 
add t3, t3, s1
mv a1, t3
la a0, fmt_int 
call scanf 
addi t1, t1, 1 
j input_loop 

in_done: 
li t1, 0 

solve_loop: 
beq t1, s0, solve_done 
mv s3, t1
slli s3, s3, 3 
add s3, s3, s1
srai s5, s3, 1
j check_prime 

check_prime: 
rem s4, s3, s5 
beq s4, zero, not_prime 
addi s5, s5, -1 
bnez s5, check_prime 

prime: 
add s2, s2, s3
addi t1, t1, 1 
j solve_loop 

not_prime: 
addi t1, t1, 1 
j solve_loop 

solve_done: 
la a0, fmt_out
mv a1, s2 
call printf 
ld ra, 48(sp)
ld s0, 40(sp)  
ld s1, 32(sp) 
ld s2, 24(sp) 
ld s3, 16(sp) 
ld s4, 8(sp) 
ld s5, 0(sp)
addi sp, sp, 56
ret 




