.data
    fmt_s: .string "%lld"
    print_t: .string "TRUE\n"
    print_f: .string "FALSE\n"
    arr: .space 800008

.text
.global main

main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s1, 32(sp)

input:
    la a0, fmt_s
    addi a1, sp, 0
    call scanf

    ld s0, 0(sp)

    li t0, 0

inp_loop:
    beq t0, s0, check
    la t1, arr
    slli t2, t0, 3
    add a1, t1, t2
    la a0, fmt_s
    call scanf

    addi t0, t0, 1
    j inp_loop

check:
    li s1, 0 #count

    li t3, 2
    li t4, 1
    li t5, 0

    la t0, arr
    slli t2, s1, 3
    add t2, t2, t0
    ld t1, 0(t2)

    rem t2, t1, t3
    beq t2, t4, check_even

check_odd:
    addi s1, s1, 1
    beq s1, s0, print_true

    la t0, arr
    slli t2, s1, 3
    add t2, t0, t2
    ld t1, 0(t2)

    rem t2, t1, t3
    beq t2, t5, print_false
    j check_even

check_even:
    addi s1, s1, 1
    beq s1, s0, print_true

    la t0, arr
    slli t2, s1, 3
    add t2, t0, t2
    ld t1, 0(t2)

    rem t2, t1, t3
    beq t2, t4, print_false
    j check_odd

print_true:
    la a0, print_t
    call printf
    j end

print_false:
    la a0, print_f
    call printf

end:
    li a0, 0
    ld ra, 40(sp)
    ld s0, 0(sp)
    ld s1, 32(sp)
    addi sp, sp, 48
    ret
