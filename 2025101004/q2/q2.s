.globl main
.section .data

inp_fmt: .string "%ld"
out_fmt: .string "%ld\n"
n: .space 8
arr: .space 8000000

.section .text

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    sd s5, 8(sp)
    sd s6, 0(sp)

    la a0, inp_fmt
    la a1, n
    call scanf
    la t0, n
    ld s0, 0(t0)
    la s1, arr
    li s2, 0
    li t0, 0

whle:
    beq s2, s0, whilend
    add t0, t0, s2
    slli t0, t0, 3
    add t0, t0, s1
    la a0, inp_fmt
    mv a1, t0
    call scanf
    j whle
whilend:
    ld s4, 0(s1)
    li s3, 0
    li t0, 0
whle2:
    beq s3, s0, whilend2
    add t0, t0, s3
    slli t0, t0, 3
    add t0, t0, s1
    ld t3, 0(t0)
    blt s4, t3, newmax1
    j whle2
whilend2:

newmax1:
    addi sp, sp, -32
    sd t3, 0(sp)




#the approach uses two stacks, the first stack takes the maximum, second stack takes all other elements that are smaller than first stack but larger than that of second stack.
#you can then push sp down -32 for the first stack pushes, and push sp down -16 for second stack pushes. then, at the end, just check length of both and if stack 1 only has one length, just check stack 2 top.


