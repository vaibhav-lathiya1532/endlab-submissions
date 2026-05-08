.global main

.data
    scan_fmt: .string "%s"
    print_fmt: .string "%d"

.text

main:
    addi sp, sp, -32
    sd ra, 8(sp)
    sd s0, 16(sp)

    li a0, 105
    call malloc
    mv s0, a0

    la a0, scan_fmt
    mv a1, s0
    call scanf

    li t0, 0

while:
    add t4, s0, t0
    lb t4, 0(t4)

    beq t4, zero, while_end

    addi t0, t0, 1
    j while

while_end:

    li t1, 0

while_main:
    bge t1, t0, while_main_end

    li t2, 48
    li t3, '49

    add t4, s0, t1
    lb t4, 0(t4)

    blt t4, t2, false
    bgt t4, t3, false
    j true

true:
    addi sp, sp, -8
    sub t5, t4, t2
    sd t5, 0(sp)

    addi t1, t1, 1
    j while_main

false:
    ld t5, 0(sp)
    ld t6, 8(sp)
    addi sp, sp, 16

    li t2, 43
    beq t4, t2, adder

    li t2, 45
    beq t4, t2, subt

    li t2, 42
    beq t4, t2, mult

adder:
    add t6, t6, t5
    addi t1, t1, 1
    addi sp, sp, -8
    sd t6, 0(sp)
    j while_main

subt:
    sub t6, t6, t5
    addi t1, t1, 1
    addi sp, sp, -8
    sd t6, 0(sp)
    j while_main

mult:
    mul t6, t6, t5
    addi t1, t1, 1
    addi sp, sp, -8
    sd t6, 0(sp)
    j while_main


while_main_end:

    la a0, print_fmt
    ld a1, 0(sp)
    addi sp, sp, 8
    call printf

    ld ra, 8(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret