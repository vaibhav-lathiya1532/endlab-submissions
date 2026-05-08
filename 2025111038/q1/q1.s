.section .rodata

str_inp:
.string "%ld\0"

str_yes:
.string "TRUE\n\0"

str_no:
.string "FALSE\n\0"

.section .text

.extern scanf
.extern printf

parity:     # 1 -> odd, 0 -> even
    andi a0, a0, 1
    ret

.globl main
main:
    addi sp, sp, -48
    sd ra, 8(sp)
    sd s0, 16(sp)
    sd s1, 24(sp)
    sd s2, 32(sp)

    lla a0, str_inp
    mv a1, sp
    call scanf
    ld s0, 0(sp)

    li s1, -1   # save last parity, -1 = uninitialized
    li s2, 0
    loop:
        bge s2, s0, yes

        lla a0, str_inp
        mv a1, sp
        call scanf
        ld a0, 0(sp)

        call parity

        beq a0, s1, no
        mv s1, a0

        addi s2, s2, 1
        jal x0, loop

    no:
    lla a0, str_no
    call printf
    jal x0, exit

    yes:
    lla a0, str_yes
    call printf

    exit:

    ld s1, 24(sp)
    ld s0, 16(sp)
    ld ra, 8(sp)
    addi sp, sp, 48
    ret
