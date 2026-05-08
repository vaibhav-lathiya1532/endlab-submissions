.global main 

.section .data 
    fmtin: .string "%d %d"
    fmtout: .string "%d %d\n"

.section .bss 
    num1: .space 4
    num2: .space 4

.section .text

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmtin
    la a1, num1
    la a2, num2
    call scanf

    la t0, num1
    la t1, num2
    lw s0, 0(t0)    # number 1 is in s0
    lw s1, 0(t1)    # number 2 is in s1
    lw s5, 0(t0)
    lw s6, 0(t1)

gcd_start:
    blt s0, s1, switch  # s0 is always larger
    j gcd

switch:
    mv s3, s1
    mv s1, s0
    mv s0, s3

gcd:
    beqz s1, end
    rem s4, s0, s1
    mv s0, s4
    j gcd_start


end:
    #s0 contains gcd
    mul s7, s5, s6
    div s8, s7, s0

    la a0, fmtout
    mv a1, s0
    mv a2, s8

    call printf

    mv a0, zero
    ld ra, 8(sp)
    addi sp, sp, 16

    ret


