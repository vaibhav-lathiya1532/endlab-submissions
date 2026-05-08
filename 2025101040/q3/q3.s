.section .rodata
fmt1:
.string "%d"
fmt2:
.string "%d\n"

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

    addi sp, sp, -16
    mv a1, sp
    lla a0, fmt1
    call scanf
    ld s0, 0(sp) #s0=n

    addi s1, x0, 4 #s1=4

    li a0, 4000
    call malloc
    mv s2, a0    #s2 is the starting address of the array

    addi s3, x0, 0 #s3=0
    addi s7, x0, 0
input:
    ble s3, s0, getout

    mv a1, sp
    lla a0, fmt1
    call scanf

    addi s3, s3, 1
    beq x0, x0, input
getout:
    addi a1, x0, 0
    lla a0, fmt2
    call printf
    addi sp, sp, 16
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
    ret



