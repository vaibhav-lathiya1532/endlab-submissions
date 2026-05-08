.section .rodata
scan_fmt: .string "%lld"
print_yes: .string "TRUE\n"
print_no: .string "FALSE\n"

.global main
.section .text
main:
addi sp,sp,-64
sd ra,56(sp)
sd s0,48(sp)
sd s1,40(sp)
sd s2,32(sp)
sd s3,24(sp)

la a0,scan_fmt
addi a1,sp,8
call scanf
ld s0,8(sp)   #s0=n

li s1,0    #s1=loop_counter
li s2,2
li s3,0   #holds_previous_element_parity=s3
#read_first_element
la a0,scan_fmt
add a1,sp,8
call scanf
ld t2,8(sp)
addi s1,s1,1

rem s3,t2,s2

read_rest:
bge s1,s0,succ
la a0,scan_fmt
add a1,sp,8
call scanf
ld t2,8(sp)
rem t3,t2,s2
beq t3,s3,fail
mv s3,t3
addi s1,s1,1
j read_rest

succ:
la a0,print_yes
call printf
j epi

fail:
la a0,print_no
call printf
j epi

epi:
ld ra,56(sp)
ld s0,48(sp)
ld s1,40(sp)
ld s2,32(sp)
ld s3,24(sp)
addi sp,sp,64
ret


