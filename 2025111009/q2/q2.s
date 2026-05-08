.data
    fmtint: .string "%lld"
    fmtout: .string "%lld "
    val: .quad 0
    
.text
.globl main
main:
    addi sp, sp, -48
    sw ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    la a0, fmtint
    la a1, val
    #call scanf
    ld s0, val
    #gcd

    li t0, 1





    la a0, fmtout
    mv a1, s1
    call printf

    ret