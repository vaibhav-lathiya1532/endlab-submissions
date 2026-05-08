.data
    buffer: .space 128
    input: .string "%s"
    output: .string "%lld\n"

.text
.global main
.extern scanf
.extern printf

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a1, buffer
    la a0, input
    call scanf

    la s0, buffer  #s0 has string

    mv s1, s0

    li s4, '+'
    li s5, '-'
    li s6, '*'

loop:
    lbu t0, 0(s1)
    li t1, '\n'
    beq t1, t0, done
    beq t0, zero, done

    addi s1, s1, 1

    beq t0, s4, plus
    beq t0, s5, minus
    beq t0, s6, multi

    addi t0, t0, -48

    addi sp, sp, -8
    sd t0, 0(sp)
    j loop

plus:
    ld t2, 0(sp)
    addi sp, sp, 8

    ld t3, 0(sp)
    addi sp, sp, 8

    add t2, t2, t3

    addi sp, sp, -8
    sd t2, 0(sp)
    j loop

minus:
    ld t2, 0(sp)
    addi sp, sp, 8

    ld t3, 0(sp)
    addi sp, sp, 8

    sub t2, t3, t2

    addi sp, sp, -8
    sd t2, 0(sp)
    j loop

multi:
    ld t2, 0(sp)
    addi sp, sp, 8

    ld t3, 0(sp)
    addi sp, sp, 8

    mul t2, t2, t3

    addi sp, sp, -8
    sd t2, 0(sp)
    j loop

done:
    ld s2, 0(sp)
    addi sp, sp, 8
    la a0, output
    mv a1, s2
    call printf

    ld ra, 8(sp)
    addi sp, sp, 16
    ret