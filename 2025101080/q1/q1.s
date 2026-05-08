.section .data
input: .string "%lld"
output: .string "%lld\n"

.text
.globl main
main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s1,48(sp)
    sd s2,40(sp)
    sd s3,32(sp)
    sd s4,24(sp)
    sd s5,16(sp)
    sd s6,8(sp)

    addi sp,sp,-8
    mv t0,sp
    la a0,input
    mv a1,t0
    call scanf

    ld s1,0(sp)
    addi sp,sp,8

    addi sp ,sp,-8
    mv t0,sp
    la a0,input
    mv a1,t0
    call scanf
    ld s2,0(sp) # s2=arr[0]
    addi sp,sp,8

    addi sp ,sp,-8
    mv t0,sp
    la a0,input
    mv a1,t0
    call scanf
    ld s3,0(sp) #s3=arr[1]
    addi sp,sp,8

    bge s2,s3, au1
    mv s4,s3
    mv s5,s2
    li s6,2
    beq x0,x0,loop

au1:
    mv s4 ,s2
    mv s5,s3
    li s6,2

loop:
    bge s6,s1, exit

    addi sp ,sp,-8
    mv t0,sp
    la a0,input
    mv a1,t0
    call scanf
    ld t1,0(sp)
    addi sp,sp,8

    bgt t1,s4,sub1
    bne s4,t1,sub3
    addi s6,s6,1
    beq x0,x0,loop

sub1:
    mv s5,s4
    mv s4,t1
    addi s6,s6,1
    beq x0,x0,loop

sub3:
    bgt t1,s5,sub2
    addi s6,s6,1
    beq x0,x0,loop

sub2:
    mv s5,t1
    addi s6,s6,1
    beq x0,x0,loop

exit:

    la a0,output
    mv a1,s5
    call printf

   
    ld ra,56(sp)
    ld s1,48(sp)
    ld s2,40(sp)
    ld s3,32(sp)
    ld s4,24(sp)
    ld s5,16(sp)
    ld s6,8(sp)
    addi sp,sp,64

    jalr x0,0(ra)





    








