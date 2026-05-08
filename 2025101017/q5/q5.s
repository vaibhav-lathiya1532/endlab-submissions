.data
N:.dword 0
fmt_inp: .asciz "%lld"
fmt_op: .asciz "%lld"
fmt_nl: .asciz "\n"
fmt_sp: .asciz " "
array: .space 8000000

.text
.globl main
.extern scanf
.extern printf

main:
    addi sp, sp, -80
    sd ra, 0(sp)
    sd s0, 8(sp) # N
    sd s1, 16(sp) # n*n 
    sd s2, 24(sp) # array ptr/(base address)
    sd s3, 32(sp) # j
    sd s4, 40(sp) # i
    sd s5, 48(sp) 

    # read N 
    la a0, fmt_inp
    la a1, N 
    call scanf
    #need to store the val not address
    la t0, N 
    ld s0, 0(t0) # N 
    la s5, array # base address

    li s2, 1
    li s3, 1 # j=1
    li s4, 1 # is it 1 or 0 ?
    # create  n*n 
    mul s1, s0, s0

loop_inp:
    bge s2, s1, inp_done  # i>n*n
    # crete address and call scanf into
    mul t1, s2, s0  # i*n 
    add t1, t1, s3  # i*n +j
    slli t1, t1, 3
    add t1, t1, s2

    mv a0, t1
    la a1, fmt_inp
    call scanf

    addi s2, s2, 1 # incr the iterator
    j loop_inp


inp_done:
    # reset to 0
    li s2, 0


transpose_rows:
    bge s2, s0, transpose_done
    #reset col 
    li s3, 0
    
transpose_cols:
    bge s2, s0, transpose_next_row
    # find address to get arr[i][j] and ji
    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, t0, s2

    mul t1, s3, s0
    add t1, t1, s2
    slli t1, t1, 3
    add t1, t1, s2

    ld t2, 0(t0)
    ld t3, 0(t1)

    sd t2, 0(t1)
    sd t3, 0(t0)

    addi s2, s2, 1
    j transpose_cols


transpose_next_row: # what it do?
    # this is for addi
    addi s2, s2, 1
    li s3, 1
    j transpose_rows


transpose_done:
    # reset
    li s2, 1

    
reverse_row:
    bge s2, s0, reverse_done
    #reset col 
    li s3, 0

reverse_cols:
    bge s2, s0, reverse_next_row
    # find address to get arr[i][j] and ji
    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, t0, s2

    mul t1, s3, s0
    add t1, t1, s2
    slli t1, t1, 3
    add t1, t1, s2

    ld t2, 0(t0)
    ld t3, 0(t1)

    sd t2, 0(t1)
    sd t3, 0(t0)

    addi s2, s2, 1
    j transpose_cols

reverse_next_row: # what it do?
    # this is for addi
    li s3, 1
    addi s2, s2, 1
    j reverse_row


reverse_done:
    # reset
    li s2, 1
    # done

print_row:
    bge s2, s0, reverse_done
    #reset col 
    li s3, 0

print_cols:
    bge s2, s0, print_next_row

    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, t0, s2

    
    la a0, fmt_op
    mv a0, t0
    call printf
    

    addi s2, s2, 1
    j transpose_cols

print_next_row: 
    # this is for addi
    addi s2, s2, 1
    j print_row


print_done:
    # reset
    # li s2, 1
    la a0, fmt_nl
    call printf

    # done
    sd ra, 48(sp)
    sd s5, 40(sp)
    sd s4, 32(sp)
    sd s3, 24(sp)
    sd  s2, 16(sp)
    sd s1, 8(sp)
    sd ra, 0(sp)

    li a0, 0
    ret






