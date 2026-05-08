.section .bss
mk: .space 8

.section .rodata
fmt: .string "%d"
fmt_ans: .string "%d\n"

.section .text
.global main
main:
    addi sp,sp,-48
    sd s0,8(sp)
    sd ra,16(sp)
    sd s1,24(sp)
    sd s2,32(sp)
    sd s3,40(sp)

    la a0,fmt
    la a1,mk
    call scanf
    ld s0,mk

    addi s2,x0,0   # index no
    addi s3,x0,0   # sum no

loop:
    beq s2,s0,done
    addi s2,s2,1
    la a0,fmt
    la a1,mk
    call scanf
    ld s1,mk
    addi t0,x0,1
    beq s1,t0,loop

loop1:
    addi t0,t0,1
    bge t0,s1,add
    rem t1,s1,t0
    beq t1,x0,loop
    beq x0,x0,loop1

add:
    add s3,s1,s3
    beq x0,x0,loop

done:
    la a0,fmt_ans
    mv a1,s3
    call printf
    
    ld s0,8(sp)
    ld ra,16(sp)
    ld s1,24(sp)
    ld s2,32(sp)
    ld s3,40(sp)
    addi sp,sp,48
    li a0,0
    ret
