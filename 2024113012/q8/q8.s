.global main

.section .data
    fmtin: .string "%d"
    fmtout: .string "%d\n"

.section .bss
    num: .space 4
    array: .space 400004
    target: .space 4

.section .text

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmtin
    la a1, num
    call scanf


    la t0, num
    lw s0, 0(t0)        # s0 holds n
    mv s1, zero         # iteration number
    la s2, array        # array beg = s2
                        # array address = s2 + s1 * 4
    

read_loop:
    bge s1, s0, end_read

    la a0, fmtin
    slli a3, s1, 2      # a3 = s1 * 4
    add a3, s2, a3      # a3 = t2 + s2
    mv a1, a3
    call scanf

    addi s1, s1, 1
    j read_loop

end_read:
    #    la a0, fmtout
    #    lw a1, 8(s2)
    #    call printf

    # now we find the target
    la a0, fmtin
    la a1, target
    call scanf
    la t0, target
    lw s3, 0(t0)        # s3 holds the target NUMBER
    mv s4, zero         # s4 holds start index
    addi s5, s0, -1     # s5 holds end index

    #   add s6, s4, s5
    #   srai s6, s6, 1  # s6 holds mid address = s5 + s6 / 2


b_sort:

    bgt s4, s5, not_found
    add s6, s4, s5
    srai s6, s6, 1      # s6 has mid index now

    # load mid num into memory
    slli t3, s6, 2
    add t3, s2, t3
    lw t2, 0(t3)        # t2 holds mid num

    beq t2, s3, found

    # load start num into memory
    slli t3, s4, 2
    add t3, s2, t3
    lw t4, 0(t3)        # t4 holds start num

    # load end num into memory
    slli t3, s5, 2
    add t3, s2, t3
    lw t5, 0(t3)        # t5 holds end num

    # check which one is sorted

    ble t4, t2, left_could


right_is_sorted:
    bge t2, s3, go_left
    bgt s3, t5, go_left
    j go_right

left_could:
    beq t4, t2, go_right 
    j left_is_sorted

left_is_sorted:
    bgt t4, s3, go_right
    bge s3, t2, go_right
    j go_left

go_right:
    addi s4, s6, 1
    j b_sort

go_left:
    addi s5, s6, -1
    j b_sort

not_found:
    li s6, -1

found:
    # value is in s6
    la a0, fmtout
    mv a1, s6
    call printf

    mv a0, zero
    ld ra, 8(sp)
    addi sp, sp, 16

    ret
     