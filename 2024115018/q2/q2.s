.section .rodata
fmt_scan: .string "%lld"
fmt_print: .string "%lld\n"

.section .text
.globl main
.type main, @function 

main:
addi sp,sp,-80
sd ra,72(sp)
sd s0,64(sp)
sd s1,56(sp)
sd s2,48(sp)
sd s3,32(sp)
sd s4,24(sp)
sd s5,16(sp)



la a0,fmt_scan
addi a0,sp,0
call scanf

la a0,fmt_scan
addi a0,sp,8
call scanf

lw s1,0(sp)
lw s2,8(sp) #max 

mv t3,s1 #no of ppl
mv t4,s1 #no of ppl

read_loads:
beqz t4,move #done with reading

addi sp,sp,8
la a0,fmt_scan
call scanf
lw a1,0(sp)
addi t4,t4,-1 
j read_loads

li t6,0

move:
mv t2,s1 #populate t2 with no of ppl
li t2,0 #capsule counter 
li t6,0 #min ctr 
li t5,0 #adderrr

move_next:
bge t6,s2,done 
addi sp,sp,8

calc:
ld t3,0(sp)
ld t4,8(sp)
add t5,t3,t4
blt t5,s2,lessthan

addi t6,t6,1
addi t2,t2,1

j move_next

lessthan:
addi t2,t2,1
addi sp,sp,16
j calc



done: 
mv a0,t2
la a0,fmt_print
call printf


ld ra,72(sp)
ld s0,64(sp)
ld s1,56(sp)
ld s2,48(sp)
ld s3,32(sp)
ld s4,24(sp)
ld s5,16(sp)

addi sp,sp,80
li a0,0
ret







