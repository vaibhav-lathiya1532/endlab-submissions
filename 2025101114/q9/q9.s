.section .rodata
fmt: .string "%lld"
fmt2: .string "%d\n"


.section .text
.globl main

main:
    addi sp, sp, -24
    sd ra, 0(sp)
    sd s0, 8(sp)   #number
    sd s1, 16(sp)

    addi a1, sp, 8
    la a0, fmt
    call scanf
    ld s0, 8(sp)

    li t3, 100
    li s1, 0
loop:
    beq t3, x0, nothappy
    beq s0, x0, done
    li t0, 10
    rem t1, s0, t0
    mul t1, t1, t1
    add s1, s1, t1

    div s0, s0, t0
    j loop

done:
    li t0, 0
    beq s1, t0, nothappy
    li t0, 1
    beq s1, t0, happy
    mv s0, s1
    li s1, 0
    addi t3, t3, -1
    j loop
nothappy:
    la a0, fmt2
    li a1, 0
    call printf
    j exit

happy:
    la a0, fmt2
    li a1, 1
    call printf
    j exit

exit:
    li a0, 0
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 24
    ret

    




