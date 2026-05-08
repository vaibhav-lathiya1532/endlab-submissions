.data
    fmt_in: .string "%lld"
    fmt_out: .string "%lld\n"

.text
.globl main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s1, 48(sp)       # n
    sd s2, 40(sp)       # l
    sd s3, 32(sp)       # store iterator to take arr input
    sd s4, 24(sp)       # store pointer to array
    sd s5, 16(sp)       # save count

    la a0, fmt_in
    addi a1, sp, 0
    call scanf

    ld s1, 0(sp)
                        # s1 now will have n

    la a0, fmt_in
    addi a1, sp, 8
    call scanf

    ld s2, 8(sp)
                            # s2 has l

    li t0, 8
    mul t0, s1, t0          # n * 8
    mv a0, t0
    call malloc

    mv s4, a0           #pointer to base of arr

    li s3, 0        #iterator initliazed

    li s5, 0        # init count

input_loop:
    bge s3, s1, input_done

    li t0, 8
    mul t0, t0, s3
                        # i * 8
    add t0, s4, t0      #points to that index

    la a0, fmt_in
    mv a1, t0
    call scanf

    addi s3, s3, 1

    jal x0, input_loop

input_done:
    li t0, 0            # i = 0
    addi t1, s1, 0          # j = n
    addi t1, t1, -1     # j = n - 1

binary_search:
    beq t0, t1, final_count_add
    bge t0, t1, print_ans

    li t2, 8                        # acces idx t0 that is i
    mul t3, t2, t0              #i * 8
    add t3, t3, s4              #base add + idx
    ld t4, 0(t3)                #arr[i]

    mul t3, t2, t1              #i * 8
    add t3, t3, s4              #base add + idx
    ld t5, 0(t3)  

    li t3, 0
    add t3, t4, t5

    ble t3, s2, increase_count

    addi t1, t1, -1         # if greater than sum
    addi s5, s5, 1                       # j --
                            # count++
    jal x0, binary_search

final_count_add:
    addi s5, s5, 1
    addi t0, t0, 1

    jal x0, binary_search

increase_count:
    addi s5, s5, 1      #count++
    addi t0, t0, 1      # i ++
    addi t1, t1, -1     # j--

    jal x0, binary_search

print_ans:
    mv a1, s5
    la a0, fmt_out
    call printf

done:
    ld ra, 56(sp)
    ld s1, 48(sp)       # n
    ld s2, 40(sp)       # l
    ld s3, 32(sp)
    ld s4, 24(sp)
    ld s5, 16(sp)

    addi sp, sp, 64

    li a0, 0
    ret
