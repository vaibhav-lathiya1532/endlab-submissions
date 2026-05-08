.section .rodata
fmt_in: .asciz "%ld"
fmt_out: .asciz "%ld\n"
fmt_1: .asciz "-1\n"

.text
# s0: 8*n
# s1: a
# s2: 8*i
# 0(sp): n
# 32(sp): target
.globl main
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)

    la a0, fmt_in
    mv a1, sp
    call scanf
    ld s0, 0(sp)

    slli s0, s0, 3

    mv a0, s0
    call malloc
    mv s1, a0

    li s2, 0
    loop1:
        bge s2, s0, continue1

        la a0, fmt_in
        add a1, s1, s2
        call scanf
        addi s2, s2, 8

    j loop1
    continue1:

    la a0, fmt_in
    add a1, sp, 32
    call scanf

    # t0: 8*l
    # t1: 8*h
    # t2: 8*m
    # t3: target
    # a0: a[l]
    # a1: a[m]
    # a2: a[h]
    # s0: 8*n
    # s1: a
    # s2: 8*i
    # 0(sp): n
    # 32(sp): target

    li t0, 0
    mv t2, s0
    addi t1, s0, -8
    ld t3, 32(sp)
    
    loop2:
        bgt t0, t1, continue2
        sub t4, t1, t0
        srli t4, t4, 1
        add t2, t0, t4

        # a[m] calculation
        add a1, s1, t2
        ld a1, 0(a1)

        bne a0, t3, else1

        la a0, fmt_out
        srli a1, t2, 3
        call printf
        j exit

        else1:
        # a[m] calculation
        add a1, s1, t2
        ld a1, 0(a1)

        # a[l] calculation
        add a0, s1, t0
        ld a0, 0(a0)

        # a[h] calculation
        add a2, s1, t1
        ld a2, 0(a2)

        bgt a0, a1, else2
            bgt a0, t3, else21
            bgt t3, a1, else21
            addi t1, t2, -8
            j loop2
            else21:
                addi t0, t2, 8
                j loop2

        else2:
            bgt a1, t3, else22
            bgt t3, a1, else22
            addi t0, t2, 8
            j loop2
            else22:
                addi t1, t2, -8

    j loop2
    continue2:
    la a0, fmt_1
    call printf

exit:
ld s2, 24(sp)
ld s1, 16(sp)
ld s0, 8(sp)
ld ra, 56(sp)
addi sp, sp, 64
li a0, 0
ret
