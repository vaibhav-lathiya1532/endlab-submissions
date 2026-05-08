.globl main
.extern printf
.extern scanf

.section .data
fmt_in: .asciz "%ld %ld"
fmt_out: .asciz "%ld %ld %ld %ld\n"

.section .bss
price: .space 8
inserted: .space 8

.section .text
main:
    addi sp, sp, -48
    sd ra, 8(sp) 
    sd s0, 16(sp)
    sd s1, 24(sp)
    sd s2, 32(sp)
    sd s3, 40(sp)
    sd s4, 0(sp)

    la a0, fmt_in
    la a1, price
    la a2, inserted
    call scanf

    la t0, price
    ld t1, 0(t0)

    la t0, inserted
    ld t2, 0(t0)

    sub s0, t2,t1 #change variable

    li s1,0
    li s2,0
    li s3,0
    li s4,0

    quarter_loop:
        li t0, 25
        blt s0,t0, dimes_loop
        addi s1,s1,1
        sub s0,s0,t0
        j quarter_loop
    
    dimes_loop:
        li t0, 10
        blt s0,t0, nickel_loop
        addi s2,s2,1
        sub s0,s0,t0
        j dimes_loop

    nickel_loop:
        li t0, 5
        blt s0,t0, penny_loop
        addi s3,s3,1
        sub s0,s0,t0
        j nickel_loop
    
    penny_loop:
        li t0, 1
        blt s0,t0, print_res
        addi s4,s4,1
        sub s0,s0,t0
        j penny_loop

print_res:
    la a0, fmt_out
    mv a1,s1
    mv a2,s2
    mv a3,s3
    mv a4,s4
    call printf

ld ra, 8(sp) 
ld s0, 16(sp)
ld s1, 24(sp)
ld s2, 32(sp)
ld s3, 40(sp)
ld s4, 0(sp)
addi sp, sp, 48
ret


