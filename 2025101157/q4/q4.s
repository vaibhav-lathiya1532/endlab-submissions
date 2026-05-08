.section .rodata
fmt: .string "%d"
yes: .string "TRUE"
no: .string "FALSE"
out: .string "%d "

.section .bss
x: .space 4
y: .space 4

.section .text
.globl main
.extern printf,scanf

main:
    addi sp,sp,-88
    sd ra, 80(sp)
    sd s0, 72(sp) #s0=change to make
    sd s1, 64(sp) #s1= num of 25
    sd s2, 56(sp) #s2= num of 10
    sd s3, 48(sp) #s3= num of 5
    sd s4, 40(sp) #s4= num of 1
    sd s5, 32(sp) #s5=25
    sd s6, 24(sp) #s6=10
    sd s7, 16(sp) #s7=5
    sd s8, 8(sp)  #s8=1

    la a0, fmt
    la a1, x
    call scanf

    lw s1, x

    la a0, fmt
    la a1, y
    call scanf

    lw s2, y

    sub s0, s2, s1

    add s1,zero,zero
    add s2,zero,zero
    add s3,zero,zero
    add s4,zero,zero

    li s5,25
    li s6,10
    li s7,5
    li s8,1

quarters:
    blt s0,s5,dimes

    addi s1,s1,1
    addi s0,s0,-25

    j quarters

dimes:
    blt s0,s6,nickels

    addi s2,s2,1
    addi s0,s0,-10

    j dimes

nickels:
    blt s0,s7,ones

    addi s3,s3,1
    addi s0,s0,-5

    j nickels

ones:
    beqz s0, done

    addi s4,s4,1
    addi s0,s0,-1

    j ones

done:
    la a0, out
    mv a1, s1
    call printf
    la a0, out
    mv a1, s2
    call printf
    la a0, out
    mv a1, s3
    call printf
    la a0, out
    mv a1, s4
    call printf

    ld ra, 80(sp)
    ld s0, 72(sp) #s0=change to make
    ld s1, 64(sp) #s1= num of 25
    ld s2, 56(sp) #s2= num of 10
    ld s3, 48(sp) #s3= num of 5
    ld s4, 40(sp) #s4= num of 1
    ld s5, 32(sp) #s5=25
    ld s6, 24(sp) #s6=10
    ld s7, 16(sp) #s7=5
    ld s8, 8(sp)  #s8=1

    addi sp,sp,88

    ret
