.section .data 
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld\n"

.section .text

.globl main

main:
# stack operations 
addi sp, sp, -64 
sd ra, 56(sp)
sd s0, 48(sp)
sd s1, 40(sp)
sd s2, 32(sp)
sd s3, 24(sp)
sd s4, 16(sp)
sd s5, 8(sp)

# scanning n
addi sp, sp, -16 
la a0, fmt_in 
add a1, x0, sp
call scanf
ld s0, 0(sp) # s0=n 
addi sp, sp, 16

# getting base addr 
add s1, s0, x0 
slli s1, s1, 3

add a0, s1, x0 
call malloc 
add s1, a0, x0 # s1 stores base address of our array 

# s2 is going to be our iterator always
add s2, x0, x0 

input:
beq s2, s0, done_1

add s3, s2, x0 
slli s3, s3, 3
add s3, s3, s1 

la a0, fmt_in 
add a1, x0, s3
call scanf 

addi s2, s2, 1
beq x0, x0, input 

done_1:
addi s3, x0, -1 # our curr answer 

# getting base addr of left sum array 
add s4, s0, x0 
slli s4, s4, 3

add a0, s4, x0 
call malloc 
add s4, a0, x0 # s4 stores base address of left array 

# getting base addr of right sum array 
add s5, s0, x0 
slli s5, s5, 3

add a0, s5, x0 
call malloc 
add s5, a0, x0 # s5 stores base address of right array 


add t1, x0, x0 # left sum 
add t2, x0, x0 # right sum 

add s2, x0, x0 

left_sum:
beq s2, s0, done_2

add t3, s2, x0
slli t3, t3, 3
add t3, t3, s4 
sd t1, 0(t3) # storing current left sum in left[i]

add t4, s2, x0
slli t4, t4, 3
add t4, t4, s1
ld t5, 0(t4) # getting current element arr[i]

add t1, t1, t5 # cumulating left sum 
addi s2, s2, 1
beq x0, x0, left_sum



done_2:
addi s2, s0, -1 

right_sum:
blt s2, x0, done_3

add t3, s2, x0
slli t3, t3, 3
add t3, t3, s5 
sd t2, 0(t3)

add t4, s2, x0
slli t4, t4, 3
add t4, t4, s1
ld t5, 0(t4)

add t2, t2, t5 
addi s2, s2, -1
beq x0, x0, right_sum



done_3:
add s2, x0, x0 

check:
beq s2, s0, exit 

# loading left sum value 
add t1, s2, x0 
slli t1, t1, 3
add t1, t1, s4
ld t1, 0(t1)

# loading right sum value 

add t2, s2, x0 
slli t2, t2, 3
add t2, t2, s5
ld t2, 0(t2)


beq t1, t2, make_idx #if equal we change s3  
addi s2, s2, 1
beq x0, x0, check

make_idx:
add s3, x0, s2 
beq x0, x0, exit 

exit:
la a0, fmt_out 
add a1, s3, x0 
call printf 

ld s5, 8(sp)
ld s4, 16(sp)
ld s3, 24(sp)
ld s2, 32(sp)
ld s1, 40(sp)
ld s0, 48(sp)
ld ra, 56(sp)

addi sp, sp, 64 

ret



