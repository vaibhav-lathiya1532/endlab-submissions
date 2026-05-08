.section .rodata
scan_str: .string "%lld"
print_first_str: .string "%lld"
print_str: .string " %lld"
newline_str: .string "\n"

.section .text
.globl main

main:
    addi sp, sp, -64
    sd ra, 56(sp)   # store ra
    sd s0, 46(sp)   # store s0 = base address of the array
    sd s1, 40(sp)   # store s1 = N 
    sd s2, 32(sp)   # store s2 = i
    sd s3, 24(sp)   # store s3 = j
    sd s4, 16(sp)   # store s4 = left
    sd s5, 8(sp)    # store s5 = right

    addi sp, sp, -16
    la a0, scan_str
    addi a1, sp, 0
    call scanf
    ld s1, 0(sp)    # store s1 = N
    addi sp, sp, 16

    mul t0, s1, s1  # N*N
    slli t0, t0, 3  # N*N*8
    addi a0, t0, 0  # size arg for malloc
    call malloc
    addi s0, a0, 0  # store the base address of array that malloc returns in s0

# ===================================================================
#            TAKE INPUT FOR THE ARRAY
# ===================================================================

input:
    addi s2, x0, 0  # i = 0

outer_i:
    bge s2, s1, transpose  # i goes from 0 to N-1
    addi s3, x0, 0  # j=0

inner_j:
    bge s3, s1, next_row

    # calculate address of the ele
    mul t0, s2, s1  # i*N
    add t0, t0, s3  # (i*N)+j 
    slli t0, t0, 3  # ((i*N)+j)*8
    add t0, t0, s0  # &a[i][j] = base(s0) + ((i*N)+j)*8

    addi sp, sp, -16
    la a0, scan_str
    addi a1, t0, 0
    call scanf          # scanf directly stores ele at t0 address 
    addi sp, sp, 16

    addi s3, s3, 1  # j++
    j inner_j

next_row:
    addi s2, s2, 1  #  i++
    j outer_i

# =============================================================================
#            TAKE TRANSPOSE FOR THE ARRAY i.e. SWAP a[i][j] and a[j][i]
# =============================================================================
transpose:
    addi s2, x0, 0  # i = 0

trans_outer_i:
    bge s2, s1, reverse  # i goes from 0 to N-1
    addi s3, s2, 1  # j=i+1

trans_inner_j:
    bge s3, s1, trans_next_row  # j goes from i+1 to N-1

    # calculate address of the ele a[i][j]
    mul t0, s2, s1  # i*N
    add t0, t0, s3  # (i*N)+j 
    slli t0, t0, 3  # ((i*N)+j)*8
    add t0, t0, s0  # &a[i][j] = base(s0) + ((i*N)+j)*8 stored in t0

    # calculate address of the ele a[j][i]
    mul t1, s3, s1  # j*N
    add t1, t1, s2  # (j*N)+i
    slli t1, t1, 3  # ((j*N)+i)*8
    add t1, t1, s0  # &a[j][i] = base(s0) + ((j*N)+i)*8 stored in t1

    # swap a[i][j] and a[j][i]
    ld t2, 0(t0)    # t2 = a[i][j]
    ld t3, 0(t1)    # t3 = a[j][i]
    sd t3, 0(t0)    # a[i][j] = a[j][i]
    sd t2, 0(t1)    # a[j][i] = old a[i][j]

    addi s3, s3, 1  # j++
    j trans_inner_j

trans_next_row:
    addi s2, s2, 1  #  i++
    j trans_outer_i


# =============================================================================
#       REVERSE THE ROWS FOR THE ARRAY i.e. SWAP a[i][left] and a[i][right]
# =============================================================================
reverse:
    addi s2, x0, 0  # i = 0

reverse_outer_i:
    bge s2, s1, print  # i goes from 0 to N-1
    
    addi s4, x0, 0  # s4 = left = 0
    addi s5, s1, -1 # s5 = right = N-1

reverse_inner_j:
    bgt s4, s5, reverse_next_row  # loop till left>right

    # calculate address of the ele a[i][left]
    mul t0, s2, s1  # i*N
    add t0, t0, s4  # (i*N)+left
    slli t0, t0, 3  # ((i*N)+left)*8
    add t0, t0, s0  # &a[i][left] = base(s0) + ((i*N)+left)*8 stored in t0

    # calculate address of the ele a[i][right]
    mul t1, s2, s1  # i*N
    add t1, t1, s5  # (i*N)+right
    slli t1, t1, 3  # ((i*N)+right)*8
    add t1, t1, s0  # &a[i][right] = base(s0) + ((i*N)+right)*8 stored in t1

    # swap a[i][left] and a[i][right]
    ld t2, 0(t0)    # t2 = a[i][left]
    ld t3, 0(t1)    # t3 = a[i][right]
    sd t3, 0(t0)    # a[i][left] = a[i][right]
    sd t2, 0(t1)    # a[i][right] = old a[i][left]

    addi s4, s4, 1  # left++
    addi s5, s5, -1 # right--
    j reverse_inner_j

reverse_next_row:
    addi s2, s2, 1  #  i++
    j reverse_outer_i


# ===================================================================
#                     PRINT THE ARRAY
# ===================================================================
print:
    addi s2, x0, 0  # i = 0

print_outer_i:
    bge s2, s1, done  # i goes from 0 to N-1

    # calculate address of the ele a[i][0]
    mul t0, s2, s1  # i*N
    slli t0, t0, 3  # (i*N)*8
    add t0, t0, s0  # &a[i][0] = base(s0) + (i*N)*8

    la a0, print_first_str
    ld a1, 0(t0)
    call printf

    addi s3, x0, 1  # j=1

print_inner_j:
    bge s3, s1, print_next_row  # j from 1 to N-1

    # calculate address of the ele
    mul t0, s2, s1  # i*N
    add t0, t0, s3  # (i*N)+j 
    slli t0, t0, 3  # ((i*N)+j)*8
    add t0, t0, s0  # &a[i][j] = base(s0) + ((i*N)+j)*8

    la a0, print_str
    ld a1, 0(t0)
    call printf

    addi s3, s3, 1  # j++
    j print_inner_j

print_next_row:
    addi s2, s2, 1  #  i++
    la a0, newline_str
    call printf
    j print_outer_i

# ===================================================================
#                     CLEANUP
# ===================================================================

done:
    addi a0, s0, 0
    call free

    ld s5, 8(sp)   
    ld s4, 16(sp)   
    ld s3, 24(sp)   
    ld s2, 32(sp)   
    ld s1, 40(sp)   
    ld s0, 48(sp)   
    ld ra, 56(sp)    
    addi sp, sp, 64

    jalr x0, ra, 0
