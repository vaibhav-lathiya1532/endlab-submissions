.section .rodata
fmtin1 : .string "%lld"
fmtin2 : .string " %lld"
right : .string "TRUE\n"
wrong : .string "FALSE\n"

.section .data
ar: .space 800008

.section .text
.global main
main:
    addi sp,sp,-48
    sd ra,0(sp)
    sd s0,8(sp)    #N
    sd s1,16(sp)   #state
    sd s2,24(sp)   #ar

    la s2,ar

    la a0,fmtin1
    addi sp,sp,-8
    addi a1,sp,0
    call scanf
    ld s0,0(sp)
    addi sp,sp,8
    beq s0,x0,aha

    li t0,1
    la a0,fmtin1
    mv a1,s2
    call scanf
input:
    bge t0,s0,start
    slli t1,t0,3
    addi t0,t0,1
    add t1,t1,s2
    mv a1,t1
    la a0,fmtin2
    call scanf
    j input

start:
    li t0,1
    li t3,2
    ld t1,0(s2)
    rem t2,t1,t3
    mv s1,t2

loop:
    bge t0,s0,aha
    slli t4,t0,3
    add t4,t4,s2
    ld t5,0(t4)
    li t3,2
    rem t2,t5,t3
    beq t2,s1,fatt
    mv s1,t2
    addi t0,t0,1
    j loop

fatt:
    la a0,wrong
    j done

aha:
    la a0,right

done:
    call printf
    li a0,0
    ld ra,0(sp)
    ld s0,8(sp)
    ld s1,16(sp)
    ld s2,24(sp)
    addi sp,sp,48
    ret

