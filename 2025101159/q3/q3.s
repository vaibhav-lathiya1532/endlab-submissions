.section .bss
    buffer: .space 800000

.section .data
    fmt_in: .string "%lld"
    fmt_out: .string "%lld\n"

.section .text
.globl main

main:
    addi sp, sp, -80
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)

    la a0, fmt_in
    addi a1, sp, 24
    call scanf

    ld s0, 0(a1)
    li t0, 0
    li s1, 0
    j readloop

readloop:

    beq t0, s0, setupcalc
    
    la a0, fmt_in
    addi a1, sp, 24
    call scanf

    la a2, buffer
    mv t1, t0
    slli t1, t1, 3
    add a2, a2, t1

    ld t2, 0(a1)
    sd t2, 0(a2)

    addi t0, t0, 1
    j readloop

setupcalc:

    beq s1, s0, notfound

    mv t0, s1       #index
    li t1, 0        #lsum
    li t2, 0        #rsum
    li t3, 0        #lptr
    mv t4, s0
    addi t4, t4, -1     #rptr
    j leftsum

leftsum:

    beq t3, t0, rightsum

    slli t3, t3, 3
    la a2, buffer
    add a2, a2, t3
    ld t5, 0(a2)

    add t1, t1, t5
    addi t3, t3, 1
    j leftsum

rightsum:

    beq t4, t0, check

    slli t4, t4, 3
    la a2, buffer
    add a2, a2, t4
    ld t5, 0(a2)

    add t2, t2, t5
    addi t4, t4, -1
    j rightsum

check:

    beq t1, t2, found

    addi s1, s1, 1
    j setupcalc

found:

    la a0, fmt_out
    mv a1, s1
    call printf

    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 80
    ret

notfound:

    la a0, fmt_out
    li s1, -1
    mv a1, s1
    call printf
    
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 80
    ret




