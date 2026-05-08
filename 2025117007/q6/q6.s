.section .rodata
fmt_in: .string "%s"
fmt_out: .string "%lld\n"

.section .bss
buffer: .space 105

.section .text
.globl main

main:
    addi sp,sp,-80
    sd ra,72(sp)
    sd s0,64(sp)            #s0=string
    sd s1,56(sp)            #s1=pointer
    sd s2,48(sp)
    sd s3,40(sp)
    sd s4,32(sp)
    sd s5,24(sp)
    sd s6,16(sp)

    la a0,fmt_in
    la a1,buffer
    call scanf

    la s0,buffer
    mv s1,s0

loop:
    lb s2,0(s1)
    beq s2,x0,print

    addi s3,x0,48
    addi s4,x0,57

    blt s2,s3,operator
    bgt s2,s4,operator

digit:
    lb s2,0(s1)
    addi s2,s2,-48

    addi sp,sp,-8
    sd s2,0(sp)
    beq x0,x0,next

operator:
    lb s2,0(s1)

    li t0,'+'
    beq s2,t0,add

    li t1,'-'
    beq s2,t1,sub

    li t2,'*'
    beq s2,t2,mul

mul:
    ld s5,0(sp)
    addi sp,sp,8

    ld s6,0(sp)
    addi sp,sp,8

    mul t3,s6,s5

    addi sp,sp,-8
    sd t3,0(sp)

    beq x0,x0,next

add:
    ld s5,0(sp)
    addi sp,sp,8

    ld s6,0(sp)
    addi sp,sp,8

    add t3,s6,s5

    addi sp,sp,-8
    sd t3,0(sp)

    beq x0,x0,next

    
sub:
    ld s5,0(sp)
    addi sp,sp,8

    ld s6,0(sp)
    addi sp,sp,8

    sub t3,s6,s5
    
    addi sp,sp,-8
    sd t3,0(sp)

    beq x0,x0,next

next:
    addi s1,s1,1
    beq x0,x0,loop

print:
    ld s4,0(sp)
    addi sp,sp,8

    la a0,fmt_out
    mv a1,s4
    call printf

done:

    ld ra,72(sp)
    ld s0,64(sp)            #s0=string
    ld s1,56(sp)            #s1=pointer
    ld s2,48(sp)
    ld s3,40(sp)
    ld s4,32(sp)
    ld s5,24(sp)
    ld s6,16(sp)

    addi sp,sp,80

    ret
