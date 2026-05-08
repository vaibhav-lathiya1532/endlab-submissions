.section .rodata
input1: .string "%lld %lld"
input2: .string "%lld"
output: .string "%lld\n"

.text
.global main

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp) # n
    sd s1, 56(sp) # L
    sd s2, 48(sp) # Base Address
    sd s3, 40(sp) # Left
    sd s4, 32(sp) # Right
    sd s5, 24(sp) # Ans
    sd s6, 16(sp) # Counter

    lla a0, input1
    addi a1, sp, 0
    addi a2, sp, 8
    call scanf
    ld s0, 0(sp)
    ld s1, 8(sp)

    slli a0, s0, 3
    call malloc
    mv s2, a0

    li s6, 0
read_loop:
    bge s6, s0, read_done

    slli t0, s6, 3
    add a1, s2, t0
    lla a0, input2
    call scanf

    addi s6, s6, 1
    j read_loop
read_done:
    li s3, 0
    addi s4, s0, -1
    li s5, 0
search:
    bgt s3, s4, search_done
    addi s5, s5, 1

    slli t0, s3, 3
    add t0, s2, t0
    ld t1, 0(t0)

    slli t2, s4, 3
    add t2, s2, t2
    ld t3, 0(t2)

    add t4, t3, t1

    ble t4, s1, two_loads
    addi s4, s4, -1
    j search
two_loads:
    addi s3, s3, 1
    addi s4, s4, -1
    j search
search_done:
    lla a0, output
    mv a1, s5
    call printf

    li a0, 0
    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    ld s6, 16(sp)
    addi sp, sp, 80
    ret
