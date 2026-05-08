    .section .rodata
fmt_in: .string "%d"

    .section .text
    .globl main

main:
    addi sp, sp, -64
    sd ra, 48(sp)
    sd s0, 40(sp) # number of blocks
    sd s1, 32(sp) # array pointer 
    sd s2, 24(sp) # loop counter
    sd s3, 16(sp) # to store total sum
    sd s4, 8(sp)

    lla a0, fmt_in
    addi a1, sp, 56
    call scanf

    lw s0, 56(sp)

    slli a0, s0, 2
    call malloc

    mv s1, a0

    li s2, 0 # input loop counter
input_loop:
    bge s2, s0, input_taken
    lla a0, fmt_in

    mv t0, s2
    slli t0, t0, 2
    add a1, t0, s1
    call scanf

    addi s2, s2, 1
    j input_loop
    
input_taken:
    li s2, 0
    li s3, 0 # to store sum till now
prefix_sum:
    bge s2, s0, sum_taken
    mv t0, s2
    slli t0, t0, 2
    add t0, t0, s1

    lw t1, 0(t0)
    add s3, s3, t1
    sw s3, 0(t0)

    addi s2, s2, 1
    j prefix_sum

# s3 now stores the total sum

sum_taken:
    li s2, 0
    li s4, 0
result:
    bge s2, s0, not_found
    mv t0, s2
    slli t0, t0, 2
    add t0, t0, s1

    lw t1, 0(t0)
    sub t2, s3, t1

    beq t2, s4, found_index

    addi s2, s2, 1
    mv s4, t1
    j result


found_index:
    lla a0, fmt_in
    mv a1, s2
    call printf
    j end_prog

not_found:
    lla a0, fmt_in
    li a1, -1
    call printf


end_prog:
    ld ra, 48(sp)
    ld s0, 40(sp)
    ld s1, 32(sp) 
    ld s2, 24(sp)
    ld s3, 16(sp)
    ld s4, 8(sp)

    addi sp, sp, 64
    li a0, 0
    ret
