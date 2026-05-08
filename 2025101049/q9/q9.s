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
li s3 , 0 # our answer
li s2 , 0 # no of iterations
li s4 , 10
li s5 , 1
li s6 , 100
logic:
    beq s0 , s5 , changeans
    beq s2 , s6 , exit
    addi s2 , s2 , 1
    li s1 , 0 # we will hold the sum in this
    mv t0 , s0
    loop:
        ble t0 , x0 , changenum
        rem t1 , t0 , s4 # now t1 holds the digit
        mul t1 , t1 , t1 # t1 squared
        divu t2 , t0 , s4
        mv t0 , t2
        add s1 , s1 , t1
        j loop

    changenum:
    mv s0 , s1
    j logic

    changeans:
    li s3 , 1
    j exit

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
