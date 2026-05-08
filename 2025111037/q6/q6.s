.section .rodata
fmt_in:
    .asciz "%s"
fmt_out:
    .asciz "%lld\n"

.section .bss
buffer:
    .space 128

.text
.globl main

main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)
    sd s2, 0(sp)

    ld a0, buffer
    call malloc

    la a0, fmt_in
    ld a1, 0(sp)


    call scanf

    ld s0, 0(sp)

print_result:
    la a0, fmt_out
    mv a1, s0
    call printf

    j exit

exit:
ld a0, buffer
    call free

    li a0, 0
    ld ra, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    ld s2, 0(sp)
    addi sp, sp, 32
    ret
