.global main

.data
scan_str: .asciz "%s"
print_int: .asciz "%lld\n"
buffer: .space 128

.text
main:
    addi sp, sp, -16
    sd ra, 8(sp)
    sd s0, 0(sp)

    la a0, scan_str
    la a1, buffer
    call scanf

    la s0, buffer

loop:
    mv t0, x0
    lb t1, 0(s0)
    beq t1, t0, done

    li t2, 48
    bge t1, t2, num_found

    ld t3, 0(sp)
    addi sp, sp, 8

    ld t4, 0(sp)
    li t5, '+'
    beq t1, t5, addit
    li t5, '-'
    beq t1, t5, subtr
    li t5, '*'
    beq t1, t5, multi

num_found:
    addi sp, sp, -8
    sub t1, t1, t2
    sd t1, 0(sp)
    addi s0, s0, 1
    j loop

addit:
    add t3, t3, t4
    sd t3, 0(sp)
    addi s0, s0, 1
    j loop

subtr:
    sub t3, t4, t3
    sd t3, 0(sp)
    addi s0, s0, 1
    j loop

multi:
    mul t3, t3, t4
    sd t3, 0(sp)
    addi s0, s0, 1
    j loop

done:
    ld t0, 0(sp)
    addi sp, sp, 8

    la a0, print_int
    mv a1, t0
    call printf

    add a0, x0, x0
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    ret
