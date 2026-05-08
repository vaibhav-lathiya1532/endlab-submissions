.data
    fmt_in: .string "%lld"
    fmt_out: .string "%lld "
    fmt_out_last: .string "%lld\n"

.text
.globl main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s1, 48(sp)       # n
    sd s2, 40(sp)       # pointer to array base idx
    sd s3, 32(sp)       
    sd s4, 24(sp)       
    sd s5, 16(sp)       

    la a0, fmt_in
    addi a1, sp, 0
    call scanf

    ld s1, 0(sp)        # s1 now will have n

    li t0, 1
    mul t0, s1, s1      # n square

    mv a0,t0
    call malloc

    mv s2, a0           # pointer to array ka base index

    li s3, 0            # iterator i for taking input_loop
    li s4, 0            # iterator j

input_outer_loop:
    bge s3, s1, input_done

    li s4, 0

input_inner_loop:
    bge s4, s1, next_row_input      # j >= n

    li t0, 0
    add t0, t0, s3              # i 
    mul t0, t0, s1          # i * n
    add t0, s4, t0          # i*n + j

    li t1, 8

    mul t0, t0, t1          # i*n+j * 8
    add t0, s2, t0          # add to base address

    la a0, fmt_in
    mv a1, t0
    call scanf

    addi s4, s4, 1

    jal x0, input_inner_loop        # j ++

next_row_input:
    addi s3, s3, 1

    jal x0, input_outer_loop

input_done:
    li s3, 0
    li s4, 0                        # reset iterators
    addi s4, s1, -1
    
print_outer:
    bge s3, s1, done

    addi s4, s1, -1

print_inner:
    blt s4, zero, print_next_row

    beq s4, zero, print_last          #if j == n-1

    li t0, 0
    add t0, t0, s4              #i*n
    mul t0, t0, s1
    add t0, s3, t0  
                # + j
    li t1, 8

    mul t0, t0, t1                 # * 8
    add t0, s2, t0              # add to base add

    ld t3, 0(t0)

    la a0, fmt_out
    mv a1, t3
    call printf

    addi s4, s4, -1

    jal x0, print_inner

print_last:
    li t0, 0
    add t0, t0, s4
    mul t0, t0, s1
    add t0, s3, t0

    li t1, 8

    mul t0, t0, t1
    add t0, s2, t0

    ld t3, 0(t0)

    la a0, fmt_out_last
    mv a1, t3
    call printf

    addi s4, s4, -1
    jal x0, print_inner

print_next_row:
    addi s3, s3, 1

    jal x0, print_outer

done:
    ld ra, 56(sp)
    ld s1, 48(sp)       # n
    ld s2, 40(sp)       # pointer to array base idx
    ld s3, 32(sp)       
    ld s4, 24(sp)       
    ld s5, 16(sp)   

    addi sp, sp, 64

    li a0, 0
    ret
