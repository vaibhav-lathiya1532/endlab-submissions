.data
fmt_in: .string "%lld %lld"
fmt_out: .string "%lld "
fmt_nl: .string "\n"

.text
.globl main
.extern printf
.extern scanf

main:
    addi sp, sp, -32
    sd ra, 16(sp)
    addi a1, sp, 0
    addi a2, sp, 8

    lla a0, fmt_in
    call scanf

    ld s1, 0(sp)
    ld s2, 8(sp)

    sub s3, s2, s1
    li a1, 25
    mv t0, s3 # t0 remainder
    li t1, 0 # t1 is division
    while:
        blt t0, a1, done
        sub t0, t0, a1
        addi t1, t1, 1
        j while
    done:
    mv s3, t0
    mv a1, t1
    lla a0, fmt_out
    call printf

    li a1, 10
    mv t0, s3 # t0 remainder
    li t1, 0 # t1 is division
    while1:
        blt t0, a1, done1
        sub t0, t0, a1
        addi t1, t1, 1
        j while1
    done1:
    mv s3, t0
    mv a1, t1
    lla a0, fmt_out
    call printf

    li a1, 5
    mv t0, s3 # t0 remainder
    li t1, 0 # t1 is division
    while2:
        blt t0, a1, done2
        sub t0, t0, a1
        addi t1, t1, 1
        j while2
    done2:
    mv s3, t0
    mv a1, t1
    lla a0, fmt_out
    call printf

    li a1, 1
    mv t0, s3 # t0 remainder
    li t1, 0 # t1 is division
    while3:
        blt t0, a1, done3
        sub t0, t0, a1
        addi t1, t1, 1
        j while3
    done3:
    mv s3, t0
    mv a1, t1
    lla a0, fmt_out
    call printf

    lla a0, fmt_nl
    call printf

    done4:
    ld ra, 16(sp)
    addi sp, sp, 32
    ret

