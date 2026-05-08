.data 
scan1:      .asciz "%d %d"
scan:       .asciz "%d"
print:      .asciz "%d\n"

n:      .space 4
load:   .space 4
arr:    .space 400000

.text 
.global main 

main:
addi sp, sp, -64
sd ra, 56(sp)
sd s0, 48(sp)
sd s1, 40(sp)
sd s2, 32(sp)
sd s3, 24(sp)

la a1, n 
la a2, load 
la a0, scan1
call scanf 
la t0, n 
lw s0, 0(t0)        # s0 = n 

la t0, load 
lw s3, 0(t0)        # s3 = load 

li s2, 0

input:
bge s2, s0, input_done

slli t0, s2, 2
add t0, t0, s1 

mv a1, t0 
la a0, scan 
call scanf 

addi s2, s2, 1
j input 

input_done:
la s1, arr      # s1 = arr 

li t0, 0         # t0 = left 
addi t1, s0, -1  # t1 = right 
li t2, 0         # t2 = count 

while:
bge t0, t1, whileDone

slli t3, t0, 2
add t3, t3, s1 
lw t5, 0(t3)        # t5 = arr[left]

slli t4, t1, 2
add t4, t4, s1 
lw t6, 0(t4)        # t6 = arr[right]

add t5, t5, t6

ble t5, s3, add

addi t2, t2, 1
addi t1, t1, -1
j while 

add:
addi t2, t2, 1
addi t0, t0, 1
addi t1, t1, -1
j while 

whileDone:
mv s2, t2 
mv a1, s2 
la a0, print
call printf 

ld ra, 56(sp)
ld s0, 48(sp)
ld s1, 40(sp)
ld s2, 32(sp)
ld s3, 24(sp)
addi sp, sp, 64

li a0, 0
ret 


