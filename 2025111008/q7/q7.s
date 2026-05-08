.data
    fmt_int: .asciz "%lld"
    fail_str: .string "FALSE\n"
    pass_str: .string "TRUE\n"

.text
.globl main

main:
    addi sp, sp, -32
    sd ra, 8(sp)

    la a0, fmt_int
    addi a1, sp, 16
    call scanf
    ld s0, 16(sp)
    addi s1, s0, 0
    addi s2, s0, 0
    li s3, 0
    li s4, 0
    li s5, 0
    li t3, 10
    j count

count:
    beqz s2, compute
    div s2, s2, t3
    addi s3, s3, 1
    j count

compute:
    beqz s1, final
    rem t0, s1, t3
    div s1, s1, t3
    sub t1, s3, s4
    addi t2, t0, 0
    j power

power:
    addi t1, t1, -1
    beqz t1, next
    mul t2, t2, t0
    j power

next:
    add s5, s5, t2
    addi s4, s4, 1
    j compute

final:
    beq s0, s5, pass
    j fail

fail:
    la a0, fail_str
    call printf

    ld ra, 8(sp)
    addi sp, sp, 32
    
    li a0, 0
    ret

pass:
    la a0, pass_str
    call printf

    ld ra, 8(sp)
    addi sp, sp, 32

    li a0, 0
    ret

