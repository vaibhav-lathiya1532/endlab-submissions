.section .data
percnlld: .string "%lld"
percnlldnewl: .string "%lld\n"
n: .space 8
arr: .space 800000

.section .text
.global main

main:
addi sp,sp,-64
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)
sd s4,40(sp)
sd s5,48(sp)
sd s6,56(sp)
la a0,percnlld
la a1,n
call scanf
la t0,n
ld s0,0(t0)       #s0==n
add s1,x0,x0      #s1=i 
add s3,x0,x0      # s2=sum from the end

input_loop:
beq s1,s0,input_done
la t0,arr
slli t1,s1,3
add t1,t1,t0
la a0,percnlld
add a1,x0,t1
call scanf
la t0,arr
slli t1,s1,3
add t1,t1,t0
ld t2,0(t1)
add s3,s3,t2
addi s1,s1,1
j input_loop

input_done:
add s1,x0,x0
add s2,x0,x0     #sum from the start

check_loop:
beq s1,s0,not_found
slli t1,s1,3
la t0,arr
add t1,t1,t0
ld t2,0(t1)
sub s3,s3,t2
beq s2,s3,found
add s2,s2,t2
addi s1,s1,1
j check_loop

found:
la a0,percnlldnewl
add a1,x0,s1
call printf
j wraps

not_found:
la a0,percnlldnewl
addi a1,x0,-1
call printf

wraps:
ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
ld s5,48(sp)
ld s6,56(sp)
addi sp,sp,64
ret





