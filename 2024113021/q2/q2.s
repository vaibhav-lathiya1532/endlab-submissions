.section .rodata
scanf_fmt: .string "%lld"
printf_fmt: .string "%lld "
printf_newline: .string "\n"

    .section .text
    .globl main
    .align 2

main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    addi s0, sp, 48

    la a0, scanf_fmt
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)

    # ==== s0 = a ====

    la a0, scanf_fmt
    addi a1, sp, 8
    call scanf
    ld s1, 8(sp)

    # ==== s1 = b ====
    mv t2, s0
    mv t3, s1

    bge s0, s1, ulta_gcd
    j find_gcd
    
ulta_gcd:
    mv t2, s1
    mv t3, s0

find_gcd:
    li t0, 1 
    j while
    # ==== temp = 1 ====
while:
    blez t0, exit_while
    rem t0, t3, t2
    mv t3, t2
    mv t2, t0
    j while

exit_while: 
    mv s3, t3
    j print_gcd

print_gcd: 
    la a0, printf_fmt
    mv a1, s3
    call printf
    j print_lcd

print_lcd:
    mul t4, s0, s1
    div t4, t4, s3

    la a0, printf_fmt
    mv a1, t4
    call printf

    la a0, printf_newline
    call printf

    ld ra, 40(sp)
    ld s0, 32(sp)
    ld s1, 24(sp)
    ld s2, 16(sp)
    ld s3, 8(sp)
    addi sp, sp, 48
    li a0, 0
    ret