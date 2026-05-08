.data
fmtone: "%lld %lld"
fmtout: "%lld\n"
.text
.globl main
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    addi a1, sp, 0
    addi a2, sp, 8
    la a0, fmtone
    call scanf
    