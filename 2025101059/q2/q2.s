.data
fmt_in: .string "%d %d"
fmt_ina: .string "%d"
fmt_out: .string "%d\n"

.bss
.align 3
n1: .space 4
n2: .space 4
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
la a1,n1 
la a2,n2 
call scanf

la t0,n1
lw s0,0(t0)

la t0,n2
lw s1,0(t0)

li s3,0 #counter
la s2,arr

input_loop:

beq s3,s0,end_input

slli t0,s3,2
add t0,t0,s2

addi s3,s3,1

la a0,fmt_ina
mv a1,t0
call scanf

j input_loop


#------------------------#
end_input:

li s3,0
addi s4,s0,-1

li s5,0 #counter for ans

main_loop:

bge s3,s4,check_func
slli t0,s3,2
add t0,t0,s2

slli t1,s4,2
add t1,t1,s2

#t0 and t1 hold the address for left and right

lw t2,0(t0)
lw t3,0(t1)

add t4,t2,t3

bgt t4,s1,large_cap

addi s5,s5,1

addi s3,s3,1
addi s4,s4,-1
j main_loop

large_cap:
addi s5,s5,1
addi s4,s4,-1
j main_loop

#-------------------------#


check_func:

bgt s3,s4,end_main
addi s5,s5,1

end_main:

la a0,fmt_out
mv a1,s5
call printf

ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
ld s5,48(sp)

addi sp,sp,64
ret




