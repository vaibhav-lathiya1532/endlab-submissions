.section .rodata
fmt1:
.string "%lld"
fmt2:
.string "%lld\n"

.section .text
.globl main
main:
addi sp,sp,-64
sd ra,56(sp)
sd s0,48(sp)
sd s1,40(sp)
sd s2,32(sp)
sd s3,24(sp)
sd s4,16(sp)
sd s5,8(sp)

lla a0,fmt1
addi a1,sp,0
call scanf
ld s0,0(sp) # s0=n

slli a0,s0,3 # make s0*8 bytes space for array as doubleword
call malloc
mv s1,a0 # s1 stores the base address of the array

li s5,0 # i=0
read_array: beq s5,s0,proccess
slli s4,s5,3 
add s4,s1,s4 # address = base address+offset
lla a0,fmt1
addi a1,sp,0
call scanf
ld t0,0(sp)
sd t0,0(s4)
addi s5,s5,1
j read_array

proccess:
li s2,-1000001 # largest element
li s3,-1000002 # second largest element
li s5,0 # i=0

single_pass: beq s5,s0,exit
slli t0,s5,3
add t0,s1,t0 # address = base address + offset
ld s4,0(t0)
check_equal: beq s4,s2,next
ble s4,s2,check_second
mv s3,s2
mv s2,s4
j next

check_second: ble s4,s3,next
mv s3,s4

next:
addi s5,s5,1
j single_pass

exit:
lla a0,fmt2
mv a1,s3
call printf
ld s5,8(sp)
ld s4,16(sp)
ld s3,24(sp)
ld s2,32(sp)
ld s1,40(sp)
ld s0,48(sp)
ld ra,56(sp)
ret



