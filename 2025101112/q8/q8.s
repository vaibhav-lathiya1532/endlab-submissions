.section .data
    fmt_in : .string "%lld"
    fmt_out: .string "%lld\n"

.section .text

.globl main


main:
    addi sp, sp, -32
    sd x1, 24(sp)

    la x10, fmt_in
    addi x11, sp, 0
    call scanf

    ld x11, 0(sp)
    li x6, 8

    mul x10, x11, x6
    call malloc
    
    ld x11, 0(sp)
    sd x10, 16(sp)
    li x5, 0

read_loop:
    ld x10, 16(sp)
    bge x5, x11, read_done

    sd x5, 8(sp)
    slli x5, x5, 3
    add x5, x5, x10

    la x10, fmt_in
    mv x11, x5
    call scanf

    ld x11, 0(sp)
    ld x5, 8(sp)
    addi x5,x5,1

    j read_loop

read_done:
    la x10, fmt_in
    addi x11, sp, 8
    call scanf

    ld x11, 0(sp)
    ld x10, 16(sp)
    ld x12, 8(sp)

    call rotate_search

    mv x11, x10
    la x10, fmt_out
    call printf

    ld x10, 16(sp)
    call free

    ld x1, 24(sp)
    addi sp, sp, 32
    ret


rotate_search:
    li x13, 0
    addi x15, x11, -1
    li x20, 8

binary_search_loop:
    bgt x13, x15, not_found

    add x14, x15, x13  #No garbage writing, x15 and x13 are init
    srli x14, x14, 1

    mul x19, x14, x20  #x14 times 8
    add x19, x19, x10
    ld x16, 0(x19)

    beq x16, x12, found_index

    mul x19, x13, x20  #x13 times 8
    add x19, x19, x10
    ld x17, 0(x19)

    bge x16, x17, left_half_sorted

right_half_sorted:
    mul x19, x15, x20
    add x19, x19, x10
    ld x18, 0(x19)

    blt x12, x16, move_left
    bgt x12, x18, move_left

    j move_right

left_half_sorted:
    blt x12, x17, move_right
    bgt x12, x16, move_right

    j move_left

move_right:
    addi x13, x14, 1
    j binary_search_loop

move_left:
    addi x15, x14, -1
    j binary_search_loop

found_index:
    mv x10, x14
    ret 

not_found:
    li x10, -1
    ret


