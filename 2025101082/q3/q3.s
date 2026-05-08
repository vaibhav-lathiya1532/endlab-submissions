.section .data
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"

.section .bss
.align 3
arr: .space 8000

.globl main
main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s1, 32(sp) #n
    sd s2, 24(sp) #i
    sd s3, 16(sp) #j

    la a0, fmt_in
    call scanf
    sd a1, 8(sp)
    li t1, 0

read_loop:
    bge t1, s1, end_read_loop
    slli t3, t1, 3
    la t2, arr
    add t2, t2, t3
    la a0, t2
    call scanf
    sd a1, 0(t2)
    addi t1, t1, 1
    j check_prime
end_read_loop:
    j loop
check_prime:
    ld 0(t2), t0
    srli t4, t0, 1
    li s2, 0
outer_loop:
    bge s2, s1, end_outer_loop
    li s3, 0
    inner_loop:
        bge s3, t4, end_inner_loop
        ld t0, 
