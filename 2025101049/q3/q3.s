.section .rodata
integer: .string "%lld"
output: .string "%lld\n"
.section .text
.globl main
main:

addi sp  , sp , -160
sd ra , 0(sp)
sd s0 , 8(sp)
sd s1 , 16(sp)
sd s2 , 24(sp)
sd s3 , 32(sp)
sd s4 , 40(sp)
sd s5 , 48(sp)

lla a0 , integer
addi a1 , sp , 56
call scanf
ld s0 , 56(sp) # we have the number stored in s0

slli a0 , s0 , 3 # n * 8
call malloc # now we have the pointer to the malloced array
mv s1 , a0 # in s1
li s2 , 0 # let this be the index

taking_input:
beq s2 , s0 , logic
slli t0 , s2 , 3 # i * 8
add t0 , s1 , t0 # array[i]
mv a1 , t0
lla a0 , integer
call scanf
addi s2 , s2 , 1
j taking_input


logic:
li s2 , 0 # index
li s3 , 0 # this will be the sum
li t4 , 2
li t5 , 3
numberloop:
    beq s2 , s0 , exit
    slli t0 , s2 , 3
    add t0 , s1 , t0
    ld t0 , 0(t0) # now we have the number in t0
    beq t0 , t4 , addnum
    beq t0 , t5 , addnum
    srli t1 , t0 , 1 # this will be number/2
    li t2 , 2
    
    loop:
        bgt t2 , t1 , nextnum
        rem t3 , t0 , t2
        beq t3 , x0 , nextnum
        beq t2 , t1 , addnum
        addi t2 , t2 , 1
        j loop
    nextnum:
        addi s2 , s2 , 1
        j numberloop
    addnum:
        add s3 , s3 , t0
        addi s2 , s2,  1
        j numberloop
exit:
lla a0 , integer
mv a1 , s3
call printf
li a0 , 0
ld ra , 0(sp)
ld s0 , 8(sp)
ld s1 , 16(sp)
ld s2 , 24(sp)
ld s3 , 32(sp)
ld s4 , 40(sp)
ld s5 , 48(sp)
addi sp , sp , 160
ret

