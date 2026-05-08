.section .rodata
fmt1: .string "%lld"
fmt2: .string "%lld\n"
fmt3: .string "\n"

.section .text
.globl .main
main:
    addi sp, sp, -64
    ld x1, 56(sp)
    ld s0, 48(sp)
    ls s1, 40(sp)
    ld s2, 32(sp)

    lla x10, fmt1
    addi x11, sp, 0
    call scanf
    ld s0, 0(x11)

    lla x10, fmt1
    addi x11, sp, 0
    call malloc
    ld s2, 0(x11)

    addi x12, x0, 0

inputloop:
    addi x13, x0, 0
    colloop:
        beq x13, s0, colend
        lla x10, fmt1
        addi x11, sp, 0
        call scanf
        ld s0, 0(x11)




    