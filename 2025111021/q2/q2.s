.section .data
fmt: .string "%d %d"

.section .text
.global main

main:
    addi sp sp -24
    sd ra 16(sp)

    la a0 fmt
    la a1 0(sp)
    la a2 8(sp)
    call scanf

    loop1:
        

    ld ra 16(sp)
    addi sp sp 24
    ret