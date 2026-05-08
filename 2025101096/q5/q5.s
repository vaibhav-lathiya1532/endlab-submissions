.section .rodata
input: .string "%lld"
output: .string "%lld "
output_newline: .string "%lld\n"

.text
.global main

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp) # N
    sd s1, 56(sp) # Base Address
    sd s2, 48(sp) # i
    sd s3, 40(sp) # j
    sd s4, 32(sp) # Counter

    lla a0, input
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)
    
    mul a0, s0, s0
    slli a0, a0, 3
    call malloc
    mv s1, a0

    li s2, 0
    mul s4, s0, s0
read_loop:
    bge s2, s4, read_done

    slli t0, s2, 3
    add a1, s1, t0
    lla a0, input
    call scanf

    addi s2, s2, 1
    j read_loop
read_done:
    li s2, 0
transpose_outer:
    bge s2, s0, transpose_done
    addi s3, s2, 1
transpose_inner:
    bge s3, s0, transpose_inner_done

    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, s1, t0

    mul t1, s3, s0
    add t1, t1, s2
    slli t1, t1, 3
    add t1, s1, t1

    ld t2, 0(t0)
    ld t3, 0(t1)
    sd t3, 0(t0)
    sd t2, 0(t1)

    addi s3, s3, 1
    j transpose_inner
transpose_inner_done:
    addi s2, s2, 1
    j transpose_outer
transpose_done:
    li s2, 0
    srai s4, s0, 1
reverse_outer:
    bge s2, s0, reverse_done
    li s3, 0
reverse_inner:
    bge s3, s4, reverse_inner_done

    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, s1, t0

    addi t2, s0, -1
    sub t2, t2, s3
    mul t1, s2, s0
    add t1, t1, t2
    slli t1, t1, 3
    add t1, s1, t1

    ld t2, 0(t0)
    ld t3, 0(t1)
    sd t3, 0(t0)
    sd t2, 0(t1)

    addi s3, s3, 1
    j reverse_inner
reverse_inner_done:
    addi s2, s2, 1
    j reverse_outer
reverse_done:
    li s2, 0
print_outer:
    bge s2, s0, print_done
    li s3, 0
print_inner:
    bge s3, s0, print_inner_done

    mul t0, s2, s0
    add t0, s3, t0
    slli t0, t0, 3
    add t0, t0, s1
    ld a1, 0(t0)

    addi t2, s0, -1
    beq t2, s3, print_newline

    lla a0, output
    call printf
    j print_continue
print_newline:
    lla a0, output_newline
    call printf
print_continue:
    addi s3, s3, 1
    j print_inner
print_inner_done:
    addi s2, s2, 1
    j print_outer
print_done:
    li a0, 0
    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    addi sp, sp, 80
    ret

