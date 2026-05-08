.section .rodata
fmt1:
.string "%s"
fmt2:
.string "%d\n"
fmt3:
.string "%s"


.global main
.section .text
main:
    addi sp, sp, -96
    sd ra, 88(sp)
    sd s0, 80(sp)
    sd s1, 72(sp)
    sd s2, 64(sp)
    sd s3, 56(sp)
    sd s4, 48(sp)
    sd s5, 40(sp)
    sd s6, 32(sp)
    sd s7, 24(sp)
    sd s8, 16(sp)
    sd s9, 8(sp)

    addi a0, x0, 100
    call malloc
    mv s0, a0 #s0=starting address of array

    mv a1, s0
    lla a0, fmt1
    call scanf

    mv s1, s0 #string iterator
    addi s3, x0, 48
loop:
    lbu s2, 0(s1)
    beq s2, zero, exit
    addi s1, s1, 1
    blt s2, s3, operator 
    sub s4, s2, s3
    addi sp, sp, -8
    sd s4, 0(sp)
    beq x0, x0, loop
operator:
    ld s5, 8(sp)
    ld s6, 0(sp)
    addi sp, sp, 8

    addi t0, x0, 43
    beq s2, t0, doadd

    addi t0, x0, 45
    beq s2, t0, dosub

    mul s5, s5, s6
    sd s5, 0(sp)
    beq x0, x0, loop
doadd:
    add s5, s5, s6
    sd s5, 0(sp)
    beq x0, x0, loop
dosub:
    sub s5, s5, s6
    sd s5, 0(sp)
    beq x0, x0, loop
exit:
    lla a0, fmt2
    ld a1, 0(sp)
    call printf
    addi sp, sp, 8
    ld ra, 88(sp)
    ld s0, 80(sp)
    ld s1, 72(sp)
    ld s2, 64(sp)
    ld s3, 56(sp)
    ld s4, 48(sp)
    ld s5, 40(sp)
    ld s6, 32(sp)
    ld s7, 24(sp)
    ld s8, 16(sp)
    ld s9, 8(sp)
    addi sp, sp, 96
    ret;


