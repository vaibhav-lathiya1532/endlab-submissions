.data
fmt_in: .string "%lld"
fmt_out: .string "%d\n"
fmt_one: .string "1\n"
fmt_zer: .string "0\n"

.text
.global main

main:
addi sp,sp,-48
sd s0,0(sp)
sd s1,8(sp)
sd ra,16(sp)
sd s2,24(sp)
sd s3,32(sp)

addi sp,sp,-8
mv a1,sp
la a0,fmt_in
call scanf
ld s0,0(sp)     #HERE s0 is holding N
addi sp,sp,8
li s1,0         #This s1 is the sum 
mv s2,s0        #Here s2 also has N(so basically it is the current value of N and keeps updating)
li s3,0         #THis s3 is the iteration

outer_loop:
li t0,100
bge s3,t0,not_happy
li t0,1
beq s2,t0,is_happy

li s1,0         #reinitialize sum
li t1,10

calculate_SOSOD:
beq s2,x0,done_with_sum
rem t2,s2,t1
div s2,s2,t1
mul t2,t2,t2
add s1,s1,t2
j calculate_SOSOD

done_with_sum:
mv s2,s1
addi s3,s3,1            #iteration++
j outer_loop

is_happy:
la a0,fmt_one
call printf
j end_prog

not_happy:
la a0,fmt_zer
call printf

end_prog:
ld s0,0(sp)
ld s1,8(sp)
ld ra,16(sp)
ld s2,24(sp)
ld s3,32(sp)
addi sp,sp,48
li a0,0
ret
