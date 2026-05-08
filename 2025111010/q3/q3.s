    .data
in: .string "%d"
out: .string "%d\n"
val: .word 0
stor: .space 440
ah: .space 440
    .text
    .global main
main:
    addi sp, sp, -80
    sd ra, 0(sp)
    sd s0, 72(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)
    sd s6, 56(sp)
    sd s7, 64(sp)
    la s0, stor
    la s2, stor
    la s5, ah
    la s6, ah
    la s7, val
    li s4, 0
    la a0, in
    la a1, val
    call scanf
    mv t0, s7
    lw s1, 0(t0)
    li t0, 0
    sw t0, 0(s2)
    mv s3, s1
loop:
    beq s3, zero, kms
    addi s2, s2, 4
    la a0, in
    la a1, val
    call scanf
    mv t0, s7
    lw t1, 0(t0)
    add s4, s4, t1
    sw s4, 0(s2)
    sw t1, 0(s6)
    addi s6, s6, 4
    addi s3, s3, -1
    j loop
kms:
    #s0- untouched stor
    #s1- number of elements
    #s2- touched stor
    #s3- 0
    #s4- sum
    #s5- untouched number
    #s6- touched number
    mv s2, s0
    mv s6, s5
    li s3, 0
lop:
    beq s3, s1, end
    lw t0, 0(s2)
    lw t1, 0(s6)
    addi s2, s2, 4
    addi s6, s6, 4
    sub t2, s4, t0
    sub t2, t2, t1
    beq t2, t0, match
    addi s3, s3, 1
    j lop
match:
    la a0, out
    mv a1, s3
    call printf
    ld ra, 0(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    ld s7, 64(sp)
    ld s0, 72(sp)
    addi sp, sp, 80
    ret
end:
    la a0, out
    li a1, -1
    call printf
    ld ra, 0(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    ld s7, 64(sp)
    ld s0, 72(sp)
    addi sp, sp, 80
    ret
