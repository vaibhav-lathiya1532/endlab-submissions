.data
scan:   .asciz "%d"
print:  .asciz "%d\n"
n:      .space 4
target: .space 4
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
sd s4, 16(sp)
sd s5, 8(sp)
sd s6, 0(sp)

la a1, n
la a0, scan 
call scanf
la t0, n 
lw s0, 0(t0)        # s0 = n

li s4, 0            # s4 = i = 0
la s1, arr          # s1 = base add  

input:
bge s4, s0, input_done

slli t0, s4, 2
add t0, t0, s1 

mv a1, t0 
la a0, scan 
call scanf

addi s4, s4, 1
j input

input_done:
la a1, target 
la a0, scan 
call scanf 

la t0, target 
lw s2, 0(t0)       # s2 = target

li s3, 0            # s3 = 0 = left 
addi s5, s0, -1     # s5 = n-1 = right 

loop:
bge s3, s5, loop_done

add s4, s3, s5
srli s4, s4, 1      # s4 = mid 

slli t0, s4, 2
add t0, t0, s1      # t0 = add of mid 

slli t1, s5, 2
add t1, t1, s1      # t1 = add of right 

lw t2, 0(t0)        # t2 = arr[mid]
lw t3, 0(t1)        # t3 = arr[right]

ble t2, t3, go_left

go_right:
addi s3, s4, 1 
j loop 

go_left:
mv s5, s4 
j loop 

loop_done:
# s0 = n
# s1 = base arr 
# s2 = target 

mv s3, s3   # s3 = index of pivote

beq s3, zero, binary

lw t0, 0(s1)        # t0 = arr[0]
slli t1, s3, 2
add t1, t1, s1 
lw t2, 0(t1)

ble s2, t0, right_case
bgt s2, t2, right_case

left_case:
li s4, 0
mv s6, s3 
j binary 

right_case:
mv s4, s3 
addi s6, s0, -1 
j binary 

binary:
bge s4, s6, not_found 

add s5, s4, s6 
srli s5, s5, 1      # s5 = mid 

slli t0, s5, 2
add t0, t0, s1 
lw t1, 0(t0)        # t1 = arr[mid]

beq t1, s2, found 
slli t1, s3, 2
add t1, t1, s1
lw t2, 0(t1)        # t2 = target 

blt s2, t1, binary_left

binary_right:
mv s4, s5 
j binary

binary_left:
mv s6, s5 
j binary

found:
mv a1, s5 
la a0, scan 
call printf 
j exit

not_found:
li a1, -1
la a0, print 
call printf 
j exit 

exit:
ld ra, 56(sp)
ld s0, 48(sp)
ld s1, 40(sp)
ld s2, 32(sp)
ld s3, 24(sp)
ld s4, 16(sp)
ld s5, 8(sp)
ld s6, 0(sp)
addi sp, sp, 64

li a0, 0
ret 


