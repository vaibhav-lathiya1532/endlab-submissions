.section .rodata

str_inp:
.string "%10s\0"

str_yes:
.string "TRUE\n\0"

str_no:
.string "FALSE\n\0"

.section .text

.extern scanf
.extern printf
.extern atoi

power:          # a0 = num, a1 = exp
    mv t0, a0   # t0 has num
    li t1, 0
    li a0, 1

    power_loop:
        bge t1, a1, power_exit
        mul a0, a0, t0
        addi t1, t1, 1
        jal x0, power_loop
    power_exit:
    ret

.globl main
main:
    addi sp, sp, -64
    sd ra, 16(sp)
    sd s0, 24(sp)   # str pointer
    sd s1, 32(sp)   # sum
    sd s2, 40(sp)   # counter
    sd s3, 48(sp)   # copy of num

    lla a0, str_inp
    mv a1, sp
    call scanf
    mv s0, sp       # pointer is in s0
    li s2, 0        # counter
    li s1, 0        # zero sum

    loop:
        li t0, 10
        bgt s2, t0, exit

        add t0, s2, s0      # t0 has address of char
        lb t1, 0(t0)

        beq t1, x0, exit
        addi s3, t1, -48    # t1 has digit

        mv a0, s3
        addi a1, s2, 1

        call power

        add s1, s1, a0

        addi s2, s2, 1
        jal x0, loop

    exit:

    mv a0, s0
    call atoi

    beq s1, a0, yup

    lla a0, str_no
    call printf
    jal x0, cleanup

    yup:
    lla a0, str_yes
    call printf

    cleanup:

    ld s3, 48(sp)
    ld s2, 40(sp)
    ld s1, 32(sp)
    ld s0, 24(sp)
    ld ra, 16(sp)
    addi sp, sp, 64
    ret
