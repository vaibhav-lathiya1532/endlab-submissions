.section .data
in_fmt: .string "%lld"
out_true: .string "TRUE\n"
out_false: .string "FALSE\n"
ou_check: .string "%lld\n"

.section .bss
.align 3
arr: .space 900005

.section .text
.global main
main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    sd s4, 0(sp)

    addi sp, sp, -16
    la a0, in_fmt
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)
    addi sp, sp, 16

    la s1, arr
    li s2, 0

readloop:
    bge s2, s0, readdone
    slli t0, s2, 3
    add t0, t0, s1
    la a0, in_fmt
    mv a1, t0
    call scanf
    addi s2, s2, 1
    j readloop
readdone:
    li t0, 1
    beq s0, t0, con_false

    li s3, 0
    slli t0, s3, 3
    add t0, t0, s1
    ld s4, 0(t0)
    li t2, 2
    rem s4, s4, t2
    addi s2, s4, 0

    li s3, 1
checkloop:
    bge s3, s0, con_true
    slli t0, s3, 3
    add t0, t0, s1
    ld s4, 0(t0)
    li t2, 2
    rem s4, s4, t2
    beq s2, s4, con_false
    addi s2, s4, 0
    addi s3, s3, 1
    j checkloop

con_true:
    la a0, out_true
    call printf
    j end

con_false:
    la a0, out_false
    call printf

end:
    ld ra, 40(sp)
    ld s0, 32(sp)
    ld s1, 24(sp)
    ld s2, 16(sp)
    ld s3, 8(sp)
    ld s4, 0(sp)
    addi sp, sp, 48
    li a0, 0
    ret





