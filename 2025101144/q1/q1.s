.section .rodata
fmt1:
.string "%lld"
fmt2:
.string "TRUE\n"
fmt3:
.string "FALSE\n"

.section .bss
n:
.skip 8
array:
.skip 800008

.section .text
.globl main

main:
addi sp,sp,-80
sd ra,72(sp)
sd s0,64(sp)
sd s1,56(sp)
sd s2,48(sp)
sd s3,40(sp)

la a0,fmt1
la a1,n
call scanf

la t0,n
ld s0,0(t0)

la s1,array
li s2,0

input_loop:

beq s2,s0,fin_input

slli s3,s2,3
add s3,s3,s1
mv a1,s3
la a0,fmt1
call scanf

ld t0,0(s3)
andi t1,t0,1
sd t1,0(s3)

addi s2,s2,1
j input_loop

fin_input:
li s2,0
li s3,1

output_loop:
beq s3,s0,fin_output

slli t0,s2,3
add t0,t0,s1
ld s4,0(t0)

li t0,0

slli t0,s3,3
add t0,t0,s1
ld s5,0(t0)

beq s4,s5,fin

addi s2,s2,1
addi s3,s3,1

j output_loop

fin:
la a0,fmt3
call printf
j end

fin_output:
la a0,fmt2
call printf
j end

end:
ld ra,72(sp)
sd s0,64(sp)
sd s1,56(sp)
sd s2,48(sp)
sd s3,40(sp)

addi sp,sp,80
li a0,0
ret

