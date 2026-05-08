.text
.globl main

main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)
    sd s2, 0(sp)

    la a0, fmt_in
    la a1, N_val
    call scanf
    la t0, N_val
    ld s0, 0(t0)

    li t0, 1
    beq s0, t0, false
    slli a0, s0, 3
    call malloc
    mv s1, a0

    li s2, 0
insert:
    bge s2, s0, inp_end
    slli a1, s2, 3
    add a1, a1, s1
    la a0, fmt_in
    call scanf
    addi s2, s2, 1
    j insert
inp_end:
    li s2, 0
    li t2, 1
    ld t0, 0(s1)
    andi t1, t0, 1
    addi s2, s2, 1
    beq t1, x0, odd
even: 
    bge s2, s0, true
    slli t3, s2, 3
    add t3, t3, s1
    ld t0, 0(t3)
    andi t1, t0, 1
    addi s2, s2, 1
    beq t1, x0, odd
    beq t1, t2, false
odd:
    bge s2, s0, true
    slli t3, s2, 3
    add t3, t3, s1
    ld t0, 0(t3)
    andi t1, t0, 1
    addi s2, s2, 1
    beq t1, x0, false
    beq t1, t2, even
true:
    la a0, fmt_out
    la a1, p_t
    call printf
    j end

false:
    la a0, fmt_out
    la a1, p_f
    call printf

end:
    li a0, 0
    ld ra, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    ld s2, 0(sp)
    addi sp, sp, 32
    ret

.section .bss
N_val: .quad 0

.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%s"
p_t: .string "TRUE"
p_f: .string "FALSE"