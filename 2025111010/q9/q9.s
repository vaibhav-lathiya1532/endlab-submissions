    .data
in: .string "%lld"
out: .string "%lld\n"
val: .dword 0
    .text
    .global main
main:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s0, 16(sp)
    sd s1, 24(sp)
    sd s2, 32(sp)
    sd s3, 40(sp)
    li s0, 100
    la s1, val
    la a0, in
    la a1, val
    call scanf
    ld s2, 0(s1)
    li s3, 0
lop:
    beq s2, zero, loop
    li t0, 10
    rem t1, s2, t0
    mul t1, t1, t1
    add s3, s3, t1
    div s2, s2, t0
    j lop
loop:
    li t0, 1
    beq s3, t0, happyending
    addi s0, s0, -1
    mv s2, s3
    li s3, 0
    bge s0, zero, lop
    #sad ending
    la a0, out
    li a1, 0
    call printf
    ld ra, 0(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    ld s3, 40(sp)
    addi sp, sp, 64
    ret
happyending:
    la a0, out
    li a1, 1
    call printf
    ld ra, 0(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    ld s3, 40(sp)
    addi sp, sp, 64
    ret
