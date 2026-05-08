.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmt_in
    addi a1, sp, 0
    call scanf
    
    ld s0, 0(sp)

    addi t0, s0, -48
    mv s1, t0

exit:
    mv a1, s1
    la a0, fmt_out
    call printf

    li a0, 0
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
    
