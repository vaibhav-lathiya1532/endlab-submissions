.section .rodata
scan_fmt: .string "%lld"
print_yes: .string "TRUE\n"
print_no: .string "FALSE\n"

.global main
.section .text
main:
addi sp,sp,-48
sd ra,40(sp)
sd s0,32(sp)
sd s1,24(sp)
sd s2,16(sp)

la a0,scan_fmt
addi a1,sp,8
call scanf
ld s0,8(sp)   #s0=n

mv t0,s0
li s1,0
li s2,0       #s2=number of digits 
li t2,10
while:
beqz t0,done
div t0,t0,t2
addi s2,s2,1
j while

done:
li t6,0
mv s1,s0
li t2,10
loop:
beqz s1,print
rem t3,s1,t2   #t3=base
div s1,s1,t2
mv t4,s2       #t4=power
addi s2,s2,-1
li t5,1
power:
beqz t4,add_result
mul t5,t5,t3
addi t4,t4,-1
j power

add_result:
add t6,t6,t5
j loop

print:
beq t6,s0,succ
la a0,print_no
call printf
j epi

succ:
la a0,print_yes
call printf

epi:
ld ra,40(sp)
ld s0,32(sp)
ld s1,24(sp)
ld s2,16(sp)
addi sp,sp,48
ret

