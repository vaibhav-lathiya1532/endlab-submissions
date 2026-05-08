.section .data
fmt_n: .asciz "%d"
fmt_o: .asciz "%d\n"
fmt: .asciz "%d %d\n"
num1: .dword 0

.section .text
.global main
.extern scanf
.extern printf

main:
    addi sp,sp,-16
    sd ra, 8(sp)

    la a0, fmt_n
    la a1, num1
    call scanf
    ld s5, num1
    

    li s1, -1000001
    li s0, -1000001
    

loop:
    beqz s5, done


    la a0, fmt_n
    la a1, num1
    call scanf
    ld s4, num1

    

    bgt s4, s0, check
    j next_int

check:
    beq s1, s4, next_int
    bgt s4, s1, all
    addi s0,s4,0
    j next_int


all:
    addi s0,s1,0
    addi s1,s4,0
    j next_int


next_int:
    addi s5,s5,-1
    j loop

done:
    la a0, fmt_o
    mv a1, s0
    call printf
    ld ra, 8(sp)
    addi sp,sp,16
    ret