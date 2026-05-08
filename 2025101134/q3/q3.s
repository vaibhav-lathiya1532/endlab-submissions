.section .data
input_fmt: .asciz "%lld"
output_fmt: .asciz "%lld\n"

.section .bss
N: .quad 0

.section .text
.globl main
.extern printf
.extern scanf
.extern malloc
.extern free

main:
    addi sp,sp,-48
    sd ra,40(sp)
    sd s0,32(sp)
    sd s1,24(sp)
    sd s2,16(sp)
    sd s3,8(sp)
    sd s4,0(sp)

    la s0,N
    la a0,input_fmt
    la a1,N
    call scanf

    ld t0,0(s0)
    slli t0,t0,3
    mv a0,t0
    call malloc
    mv s2,a0

    mv t6,s0
    ld s0,0(t6)
    li s1,0
    li s3,0
    li s4,0

    j scanloop


specialcase:
    la a0,output_fmt
    la a1,0
    call printf
    j done

scanloop:
    bge s1,s0,scandone
    
    mv t1,s1
    slli t1,t1,3
    add t1,t1,s2

    la a0,input_fmt
    mv a1,t1
    call scanf

    j scan_plus

scan_plus:
    addi s1,s1,1
    j scanloop

scandone:
    li s1,0
    li t5,1
    beq t5,s0,specialcase
    j total

total:
    bge s1,s0,totaldone

    mv t1,s1
    slli t1,t1,3
    add t1,t1,s2
    ld t2,0(t1)
    
    add s3,s3,t2
    addi s1,s1,1
    j total

totaldone:
    li s1,0
    mv t1,s1
    slli t1,t1,3
    add t1,t1,s2
    ld t2,0(t1)
    addi s1,s1,1
    add s4,s4,t2

check:
    bge s1,s0,no

    mv t1,s1
    slli t1,t1,3
    add t1,t1,s2
    ld t2,0(t1)

    mv t6,s3
    sub t6,t6,t2
    sub t6,t6,s4

    beq s4,t6,yes
    addi s1,s1,1
    add s4,s4,t2
    j check

yes:
    la a0,output_fmt
    mv a1,s1
    call printf
    j done

no:
    la a0,output_fmt
    li a1,-1
    call printf
    j done

done:
    

    ld ra,40(sp)
    ld s0,32(sp)
    ld s1,24(sp)
    ld s2,16(sp)
    ld s3,8(sp)
    ld s4,0(sp)
    addi sp,sp,48
    ret



