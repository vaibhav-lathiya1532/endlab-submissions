.section .rodata
fmt: .string "%d"
yes: .string "TRUE"
no: .string "FALSE"

.section .bss
x: .space 4

.section .text
.globl main
.extern printf,scanf

main:
    addi sp,sp,-88
    sd ra, 80(sp)
    sd s0, 72(sp) 
    sd s1, 64(sp) #s1=n
    sd s2, 56(sp) #s2=counter for loop
    sd s3, 48(sp) #s3=cur num
    sd s4, 40(sp) #s4=cur remainder
    sd s5, 32(sp) #s5=last rem
    sd s6, 24(sp)
    sd s7, 16(sp) #s7=2
    sd s8, 8(sp)

    la a0, fmt
    la a1, x
    call scanf

    lw s1, x

    addi s2, zero, 1   #one num alr processed

    la a0, fmt
    la a1, x
    call scanf

    lw s8, x
    li s7, 2
    rem s5, s8, s7    #first nums rem is saved

    beq s1, s2, ansno

input:
    beq s1,s2,ansyes   #if all n inputs pass the test, ans true

    la a0, fmt
    la a1, x
    call scanf

    lw s3, x
    rem s4, s3, s7

    beq s4, s5, ansno

    add s5, s4, zero

    addi s2,s2,1
    j input

ansyes:
    la a0, yes
    call printf
    j done

ansno:
    la a0, no
    call printf
    j done

done:
    ld ra, 80(sp)
    ld s0, 72(sp) 
    ld s1, 64(sp) #s1=n
    ld s2, 56(sp) #s2=counter for loop
    ld s3, 48(sp) #s3=cur num
    ld s4, 40(sp) #s4=cur remainder
    ld s5, 32(sp) #s5=last rem
    ld s6, 24(sp)
    ld s7, 16(sp) #s7=2
    ld s8, 8(sp)

    addi sp, sp, 88

    ret
