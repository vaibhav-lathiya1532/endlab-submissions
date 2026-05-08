.data
    fmtint: .string "%lld"
    fmtout: .string "%lld\n"
    input: .space 800008

    n: .quad 0

.text
.globl main
main:
    addi sp, sp, 40
    sd ra, 32(sp)
    sd s0, 24(sp)
    sd s1, 16(sp)
    sd s2, 8(sp)
    sd s3, 0(sp)

    la a0, fmtint
    la a1, n
    call scanf
    ld s1, n

    slli t0, s1, 3
    mv a0, t0
    call malloc
    ld s0, input

    mv t0, s0
    li t1,0
    li s2, 0

read_loop:
    bge t1, s1, read_done
    
    la a0, fmtint
    mv a1, t0
    call scanf

    ld t5, 0(t0)
    add s2, s2, t5

    addi t0, t0, 8
    addi t1, t1, 1
    j read_loop

read_done:
    li t0, 0
    add t3, t0, s0
    ld t5, 0(t3)
    sub t2, s2, t5
    li s3, 0
    li t1, 0

loop:
    bge t0, s1, invalid
    beq s1, s3, win

    slli t3, t0, 3
    add t3, t3, s0
    ld t5, 0(t3)
    add s3, t5, s3
    addi t0, t0, 1

    slli t3, t0, 3
    add t3, t3, s0
    ld t5, 0(t3)

    sub s2, s2, t5

    j loop

win:
    la a0, fmtout
    mv a1, t0
    call printf

    ld s3, 0(sp)
    ld s2, 8(sp)
    ld s1, 16(sp)
    ld s0, 24(sp)
    ld ra, 32(sp)
    addi sp, sp, 40

    ret

invalid:
    la a0, fmtout
    li a1, -1
    call printf

    ld s3, 0(sp)
    ld s2, 8(sp)
    ld s1, 16(sp)
    ld s0, 24(sp)
    ld ra, 32(sp)
    addi sp, sp, 40

    ret
