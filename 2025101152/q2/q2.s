.section .rodata
fmt: 
    .string "%lld %lld"
fmt2:
    .string "%lld\n"
fmt3:
    .string "%lld"

.globl .main
.section text

main:
    addi sp, sp, -48
    sd ra, 32(sp)
    sd s0, 24(sp)
    sd s1, 16(sp)

    addi a1, sp, 0
    addi a2, sp, 8
    lla a0, fmt
    call scanf
    ld s0, 0(sp)
    ld s1, 8(sp)

    li a3, 0
    mv a4, s0

input:
    ble a4, x0, done

    lla a0, fmt3
    addi a1, sp, 0
    call scanf

    mv t0, a1
    add a3, a3, t0
    addi a4, a4, -1
    j input


done:
    rem a5, a3, s1
    div a3, a3, s1

    beq a5, x0, add

noAdd:
    la a0, fmt2
    mv a1, a3
    call printf

add:
    addi a3, a3, 1
    la a0, fmt2
    mv a1, a3
    call printf

addi sp, sp, 48
ld ra, 32(sp)
ld s0, 24(sp)
ld s1, 16(sp)