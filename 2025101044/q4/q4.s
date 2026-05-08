.section .rodata
fmt1:
    .string "%d %d"
fmt2:
    .string "%d %d %d %d\n"
.section .text
.globl main
main:
    addi sp, sp, -80
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    lla a0, fmt1
    addi a1, sp, 48
    addi a2, sp, 52
    call scanf
    lw t0, 48(sp)
    lw t1, 52(sp)
    sub s0, t1, t0
    addi s1, x0, 0
    addi s2, x0, 0
    addi s3, x0, 0
    addi s4, x0, 0
    addi t0, x0, 25
loop1:
    blt s0, t0, loop2start
    addi s1, s1, 1
    sub s0, s0, t0
    jal x0, loop1
loop2start:
    addi t0, x0, 10
loop2:
    blt s0, t0, loop3start
    addi s2, s2, 1
    sub s0, s0, t0
    jal x0, loop2
loop3start:
    addi t0, x0, 5
loop3:
    blt s0, t0, loop4start
    addi s3, s3, 1
    sub s0, s0, t0
    jal x0, loop3
loop4start:
    addi s4, s0, 0
    lla a0, fmt2
    addi a1, s1, 0
    addi a2, s2, 0
    addi a3, s3, 0
    addi a4, s4, 0
    call printf
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    addi sp, sp, 80
    jalr x0, 0(ra)