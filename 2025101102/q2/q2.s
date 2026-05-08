.section .rodata
fmt1: .string "%lld"
fmt2: .string "%lld\n"

.section .text
.globl main
main:
    addi sp, sp, -48
    ld x1, 32(sp)
    ld s0, 24(sp)
    ld s1, 16(sp)
    ld s2, 8(sp)

    lla x10, fmt1
    addi x11, sp, 0
    call scanf
    ld s0, 0(x11)

    lla x10, fmt1
    addi x11, sp, 0
    call scanf
    ld s1, 0(x11)

    addi x12, s0, 0

    lla x10, fmt1
    addi x11, sp, 0
    call malloc
    ld s2, 0(x11)

    addi x13, s2, 0

inputloop:
    beq x12, x0, logic

    lla x10, fmt1
    addi x11, sp, 0
    call scanf
    ld x13, 0(x11)

    addi x13, x13, 8
    addi x12, x12, -1
    
    beq x0, x0, inputloop

logic:
    addi x14, x0, 8
    addi x13, s0, 0
    mul x13, x13, x14
    add x28, s2, x13
    addi x28, x28, -8
    addi x29, s2, 0 
    addi x14, x0, 0

    loop:
        blt x28, x29, logicend
        lb x30, 0(x29)
        lb x31, 0(x28)
        add x30, x30, x31
        ble x30, s1, countplus
        bgt x30, s1, rightendminus

    countplus:
        addi x14, x14, 1
        addi x28, x28, -8
        addi x29, x29, 8
        beq x0, x0, loop

    rightendminus:
        addi x28, x28, -8
        beq x0, x0, loop

logicend:
    lla x10, fmt2
    addi x11, x14, 0
    call printf
    beq x0, x0, exit

exit:
    sd s2, 8(sp)
    sd s1, 16(sp)
    sd s0, 24(sp)
    sd x1, 32(sp)
    addi sp, sp, 48
    addi x10, x0, 0
ret