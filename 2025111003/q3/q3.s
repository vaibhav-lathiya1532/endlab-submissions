.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"

.section .text
.global main
main:
    addi sp, sp, -48
    sd ra, 0(sp)
    # 8 - scanf

    la a0, fmt_in
    addi a1, sp, 8
    call scanf

    sd s0, 16(sp) # n
    sd s1, 24(sp) # array pointer
    sd s2, 32(sp) # i
    ld s0, 8(sp)
    mv a0, s0
    slli a0, a0, 3
    call malloc

    mv s2, x0

    j read_loop

read_loop:
    beq s2, s0, read_loop_done

    la a0, fmt_in
    mv t0, s2
    slli t0, t0, 3
    add a1, s1, t0
    call scanf

    addi s2, s2, 1
    j read_loop

read_loop_done:
    mv s2, x0
    j check

check:
    beq s2, s0, notfound
    li t0, 0 # left
    li t1, 0 # leftsum
    addi t2, s0, -1 # right
    li t3, 0 # rightsum

    j left_loop

left_loop:
    beq t0, s2, right_loop

    mv t4, t0
    slli t4, t4, 3
    add t4, s1, t4
    ld t4, 0(t4)

    add t1, t1, t4
    addi t0, t0, 1

    j left_loop

right_loop:
    beq s2, t2, check_end

    mv t4, t2
    slli t4, t4, 3
    add t4, s1, t4
    ld t4, 0(t4)

    add t3, t3, t4
    addi t2, t2, -1
    j right_loop

check_end:
    beq t1, t3, found
    addi s2, s2, 1
    j check

notfound:
    li a1, -1
    j end

found:
    mv a1, s2
    j end

end:
    la a0, fmt_out
    call printf

    ld ra, 0(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    addi sp, sp, 48

    mv a0, x0
    ret
