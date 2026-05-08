.section .rodata
fmt_in:
    .string "%lld"
fmt_out:
    .string "%lld\n"
.section .text
.global main

main:
    addi sp, sp, -80
    sd ra, 0(sp)
    sd s0, 8(sp) #contains N
    sd s1, 16(sp) #contains the array
    sd s2, 24(sp) #contains left sum
    sd s3, 32(sp) #contains right sum
    sd s4, 40(sp) #contains index i
    sd s5, 56(sp) #contains j
    sd s6, 64(sp)
    sd s7, 72(sp)

    la a0, fmt_in
    addi a1, sp, 48
    call scanf

    ld s0, 48(sp)
    slli a0, s0, 8
    call malloc
    add s1, a0, x0
    addi s4, x0, 0

read_loop:
    bge s4, s0, starting
    slli t0, s4, 8
    add a1, t0, s1
    la a0, fmt_in
    call scanf
    addi s4, s4, 1
    jal x0, read_loop

starting:
    addi s3, x0, 0
    addi s4, x0, 1
start_loop:
    bge s4, s0, end_start_loop
    slli t0, s4, 8
    add t0, t0, s1
    ld t1, 0(t0)
    add s3, s3, t1
    addi s4, s4, 1
    jal x0, start_loop
end_start_loop:
    addi s6, x0, 0
    beq s3, x0, pivot

ending:
    addi s2, x0, 0
    addi s4, x0, 0
    addi t2, s0, -1
end_loop:
    bge s4, t2, end_end_loop
    slli t0, s4, 8
    add t0, t0, s1
    ld t1, 0(t0)
    add s2, s2, t1
    addi s4, s4, 1
    jal x0, end_loop
end_end_loop:
    addi s6, s0, -1
    beq s2, x0, pivot

final_initialization:
    addi s4, x0, 1
    addi s7, s0, -1
final_loop:
    bge s4, s7, end_final_loop
    addi s2, x0, 0
    addi s3, x0, 0
    addi s5, x0, 0
left_loop:
    bge s5, s4, end_left_loop
    slli t0, s5, 8
    add t0, t0, s1
    ld t1, 0(t0)
    add s2, s2, t1
    addi s5, s5, 1
    jal x0, left_loop
end_left_loop:
    addi s5, s4, 1
right_loop:
    bge s5, s0, end_right_loop
    slli t0, s5, 8
    add t0, t0, s1
    ld t1, 0(t0)
    add s3, s3, t1
    addi s5, s5, 1
    jal x0, right_loop
end_right_loop:
    addi s6, s4, 0
    beq s2, s3, pivot
    addi s4, s4, 1
    jal x0, final_loop

pivot:
    addi a1, s6, 0
    la a0, fmt_out
    call printf
    jal x0, end

end_final_loop:
    addi a1, x0, -1
    la a0, fmt_out
    call printf
    jal x0, end

end:
    addi a0, s1, 0
    call free
    ld ra, 0(sp)
    ld s0, 8(sp) #contains N
    ld s1, 16(sp) #contains the array
    ld s2, 24(sp) #contains left sum
    ld s3, 32(sp) #contains right sum
    ld s4, 40(sp) #contains index i
    ld s5, 56(sp) #contains 
    addi sp, sp, 64
    li a0, 0
    ret