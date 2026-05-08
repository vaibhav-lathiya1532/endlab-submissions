.data
fmt1: .string "%lld"
fmt2: .string "%lld "
fmt3: .string "%lld\n"

.globl main

.text

main:

    addi sp, sp, -80

   # sd ret, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)

    la a0, fmt1
    addi a1, sp, 8

    call scanf

    ld s0, 8(sp)        # s0 = n

    mul s1, s0, s0      # s1 = n*n

    slli t0, s1, 3

    mv a0, t0
    addi a1, sp, 8

    call malloc

ld s4, 8(sp)        # s4 = base address

    li s2, 0            # s2 = i
    li s3, 0            # s3 = j



scan_loop:

    beqz s1, scan_done

    la a0, fmt1
    addi a1, sp, 8

    call scanf

    ld t1, 8(sp)

    li t0, 0            # t0 = address

    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, t0, s4

    sd t1, 0(t0)

    addi t2, s0, -1

    beq s3, t2, next_row

    addi s3, s3, 1
    addi s1, s1, -1

    j scan_loop

next_row:

    li s3, 0
    addi s2, s2, 1
    addi s1, s1, -1

    j scan_loop

scan_done:

    li s2, 0            # s2 = i
    li s3, 0            # s3 = j

    mul s1, s0, s0      # s1 = n*n

transpose_loop:

    beqz s1, transpose_done

# t0 is i,j  t1 is j,i    t2 has val i,j    t3 has val j, i

    li t0, 0          
    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, t0, s4

    li t1, 0
    mul t1, s3, s0
    add t1, t1, s2
    slli t1, t1, 3
    add t1, t1, s4

    ld t2, 0(t0)
    ld t3, 0(t1)

    sd t3, 0(t0)
    sd t2, 0(t1)

    addi t4, s0, -1

    beq s3, t4, next_row_t

    addi s3, s3, 1
    addi s1, s1, -1

    j transpose_loop

next_row_t:

    li s3, 0
    addi s2, s2, 1
    addi s1, s1, -1

    j transpose_loop


transpose_done:

    li s2, 0            # s2 = i
    li s3, 0            # s3 = j

    mul s1, s0, s0      # s1 = n*n

    li s5, 0            # s5 = current column


swap_col:

    srli t4, s0, 1

    beq t4, s5, swap_done

# t0 is i,j  t1 is j,i    t2 has val i,j    t3 has val j, i

    li s6, 0       # s6 is i 

swap_el:

    beq s0, s6, col_end

    li t0, 0          
    mul t0, s6, s0
    add t0, t0, s5
    slli t0, t0, 3
    add t0, t0, s4

    li t5, -1
    add t5, t5, s0
    sub t5, t5, s5
    addi t2, s0, -1

    beq s3, t2, next_row

    li t1, 0
    mul t1, s6, s0
    add t1, t1, t5
    slli t1, t1, 3
    add t1, t1, s4

    ld t2, 0(t0)
    ld t3, 0(t1)

    sd t3, 0(t0)
    sd t2, 0(t1)

    addi s6, s6, 1

    j swap_el

col_end:

    addi s5, s5, 1
    j swap_col

swap_done:

    li s2, 0            # s2 = i
    li s3, 0            # s3 = j

    mul s1, s0, s0      # s1 = n*n

print_loop:

    beqz s1, print_done

    li t0, 0          
    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, t0, s4

    ld t2, 0(t0)

    addi t3, s0, -1

    beq s3, t3, print_new

    la a0, fmt2
    mv a1, t2

    call printf

    addi s3, s3, 1
    addi s1, s1, -1

    j print_loop


print_new:
    la a0, fmt3
    mv a1, t2

    call printf

    li s3, 0
    addi s2, s2, 1
    addi s1, s1, -1

    j print_loop


print_done:

    
    #ld ret, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    ld s6, 16(sp)
    addi sp, sp, 80

    ret