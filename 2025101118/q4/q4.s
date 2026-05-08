.data
scanf_fmt: .string "%lld"
printf_fmt: .string "%lld\n"
print_debug: .string "%lld "

.text
.globl main
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp) #price
    sd s1, 40(sp) #inserted
    sd s2, 32(sp) #quarter
    sd s3, 24(sp) #dime
    sd s4, 16(sp) #nickel
    sd s5, 8(sp) #penny

    la a0, scanf_fmt
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)
    la a0, scanf_fmt
    addi a1, sp, 0
    call scanf
    ld s1, 0(sp)

    li s2, 0
    li s3, 0
    li s4, 0
    li s5, 0

    sub t0, s1, s0 # t0=inserted-price
    li t1, 25
    bge t0, t1, quarter
    li t1, 10
    bge t0, t1, dime
    li t1, 5
    bge t0, t1, nickel
    li t1, 1
    bge t0, t1, penny
    j done

quarter:
    beqz t0, done
    li t1, 25
    blt t0, t1, dime
    sub t0, t0, t1
    addi s2, s2, 1
    j quarter

dime:
    beqz t0, done
    li t1, 10
    blt t0, t1, nickel
    sub t0, t0, t1
    addi s3, s3, 1
    j dime

nickel:
    beqz t0, done
    li t1, 5
    blt t0, t1, penny
    sub t0, t0, t1
    addi s4, s4, 1
    j nickel

penny:
    beqz t0, done
    li t1, 1
    sub t0, t0, t1
    addi s5, s5, 1
    j penny

done:
    la a0, print_debug
    mv a1, s2
    call printf

    la a0, print_debug
    mv a1, s3
    call printf


    la a0, print_debug
    mv a1, s4
    call printf


    la a0, printf_fmt
    mv a1, s5
    call printf

    ld ra, 56(sp)
    ld s0, 48(sp) #price
    ld s1, 40(sp) #inserted
    ld s2, 32(sp) #quarter
    ld s3, 24(sp) #dime
    ld s4, 16(sp) #nickel
    ld s5, 8(sp) #penny
    addi sp, sp, 64

    li a0, 0
    ret
