.section .data
fmt_n: .asciz "%d %d"
fmt_o: .asciz "%d %d %d %d\n"
num1: .dword 0
num2: .dword 0

.section .text
.global main
.extern scanf
.extern printf

main:
    addi sp,sp,-16
    sd ra, 8(sp)

    la a0, fmt_n
    la a1, num1
    la a2, num2
    call scanf

    ld t0, num1
    ld t1, num2

    sub t0, t1,t0
    li t1,0
    li t2,0  
    li t3,0
    li t4,0

loop25:
    li t5, 25
    blt t0, t5, loop10
    addi t1,t1,1
    sub t0,t0,t5
    j loop25

loop10:
    li t5, 10
    blt t0, t5, loop5
    addi t2,t2,1
    sub t0,t0,t5
    j loop10

loop5:
    li t5, 5
    blt t0, t5, loop1
    addi t3,t3,1
    sub t0,t0,t5
    j loop5

loop1:
    li t5, 1
    blt t0, t5, done
    addi t4,t4,1
    sub t0,t0,t5
    j loop1

done:
    la a0, fmt_o
    mv a1, t1
    mv a2, t2
    mv a3, t3
    mv a4, t4
    call printf

    ld ra, 8(sp)
    addi sp,sp,16
    ret

