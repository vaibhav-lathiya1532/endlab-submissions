.section .rodata
fmt_in: .string "%lld %lld"
fmt_out: .string "%lld %lld %lld %lld\n"

.text
.global main



main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)
    sd s7, 8(sp)
    sd s8, 0(sp)


    addi sp, sp, -16
    lla a0, fmt_in
    addi a1, sp, 0
    addi a2, sp, 8
    call scanf

    ld s0, 0(sp)
    ld s1, 8(sp)
    addi sp, sp, 16

    sub s0, s1, s0

    mv a0, s0
    li a1, 25
    jal ra, division
    mv s2, a0
    mv s0, a1


    mv a0, s0
    li a1, 10
    jal ra, division
    mv s3, a0
    mv s0, a1

    mv a0, s0
    li a1, 5
    jal ra, division
    mv s4, a0
    mv s0, a1

    mv s5, s0




Exit:
    lla a0, fmt_out
    mv a1, s2
    mv a2, s3
    mv a3, s4
    mv a4, s5
    call printf

    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    ld s6, 16(sp)
    ld s7, 8(sp)
    ld s8, 0(sp)
    addi sp, sp, 80

    ret






division:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)
    sd s7, 8(sp)
    sd s8, 0(sp)



    # a0 = x
    # a1 = y

    # s0 = x/y
    # s1 = x%y


    li s0, -1

    div_loop:
        blt a0, x0, div_Exit

        sub a0, a0, a1
        addi s0, s0, 1

        jal x0, div_loop




    div_Exit:
        add s1, a0, a1
        mv a1, s1
        mv a0, s0


        ld ra, 72(sp)
        ld s0, 64(sp)
        ld s1, 56(sp)
        ld s2, 48(sp)
        ld s3, 40(sp)
        ld s4, 32(sp)
        ld s5, 24(sp)
        ld s6, 16(sp)
        ld s7, 8(sp)
        ld s8, 0(sp)
        addi sp, sp, 80

        ret


