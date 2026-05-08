.section .data 
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld\n"

.section .text

.globl main

main:
# stack operations 
addi sp, sp, -32 
sd ra, 24(sp)
sd s0, 16(sp)
sd s1, 8(sp)
sd s2, 0(sp)

addi sp, sp, -16
la a0, fmt_in
add a1, sp, x0
call scanf 
ld s0, 0(sp)
addi sp, sp, 16

# s0=n 

addi s1, x0, 100 # iterations 

add s2, x0, x0 # our final answer

add t0, x0, x0 # curr_iter

loop:
beq t0, s1, exit 

add t1, x0, x0
addi t2, x0, 10 

inner_loop:
beq s0, x0, inc
rem t3, s0, t2
mul t3, t3, t3
add t1, t1, t3

div s0, s0, t2
beq x0, x0, inner_loop 

inc:
add s0, x0, t1
addi t4, x0, 1
beq s0, t4, make_1
addi t0, t0, 1
beq x0, x0, loop

make_1:
addi s2, x0, 1
beq x0, x0, exit 

exit:
la a0, fmt_out 
add a1, s2, x0 
call printf

ld s2, 0(sp)
ld s1, 8(sp)
ld s0, 16(sp)
ld ra, 24(sp)

addi sp, sp, 32
ret