.section .data
in_fmt: .string "%lld %lld"
out_fmt: .string "%lld %lld %lld %lld"

.section .text
.global main
main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    sd s4, 0(sp)

    addi sp, sp, -16
    la a0, in_fmt
    addi a1, sp, 0
    addi a2, sp, 8
    call scanf
    ld s0, 0(sp)
    ld s1, 8(sp)
    addi sp, sp, 16

    sub s2, s1, s0

    li t0, 25
    li s3, 0
loop25:
    bgt t0, s2, done25
    sub s2, s2, t0
    addi s3, s3, 1
    j loop25
done25:

    li t0, 10
    li s4, 0
loop10:
    bgt t0, s2, done10
    sub s2, s2, t0
    addi s4, s4, 1
    j loop10
done10:

    li t0, 5
    li s1, 0
loop5:
    bgt t0, s2, done5
    sub s2, s2, t0
    addi s1, s1, 1
    j loop5
done5:

printfunc:
    la a0, out_fmt
    mv a1, s3
    mv a2, s4
    mv a3, s1
    mv a4, s2
    call printf

    ld ra, 40(sp)
    ld s0, 32(sp)
    ld s1, 24(sp)
    ld s2, 16(sp)
    ld s3, 8(sp)
    ld s4, 0(sp)
    addi sp, sp, 48
    li a0, 0
    ret



