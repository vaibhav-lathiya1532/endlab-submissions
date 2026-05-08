.data
fmt_in: .string "%d"
fmt_out: .string "%d "
new_line: .string "\n"
fmt_db: .string "YES\n"

.bss
.align 3
n: .space 4
arr: .space 4000000

.text
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

la a0,fmt_in
la a1,n 
call scanf

la t0,n
lw s0,0(t0)

mul s1,s0,s0

li s2,0


ip_outer_loop:
beq s2,s0,end_ip 

li s3,0

ip_inner_loop:
beq s3,s0,end_inner_ip

mv t0,s3
addi t1,s0,-1
sub t1,t1,s2

mul t2,t0,s0
add t2,t2,t1
slli t2,t2,2

la t4,arr
add t2,t2,t4

#t2 has the address to take input 
la a0,fmt_in
mv a1,t2
call scanf

addi s3,s3,1
j ip_inner_loop


end_inner_ip:
addi s2,s2,1
j ip_outer_loop

#--------------------------------------#

end_ip:


li s2,0


#-----------------DZ-----------------------#

p_outer_loop:

beq s2,s0,p_end
li s3,0

p_inner_loop:
beq s3,s0,end_inner_p 

mul t0,s2,s0
add t0,t0,s3
slli t0,t0,2

la t4,arr
add t0,t0,t4

lw a1,0(t0)
la a0,fmt_out
call printf

addi s3,s3,1

j p_inner_loop


end_inner_p:

addi s2,s2,1

la a0,new_line 
call printf

j p_outer_loop

#-----------------------------------#

p_end:

ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
ld s5,48(sp)

addi sp,sp,64
ret


