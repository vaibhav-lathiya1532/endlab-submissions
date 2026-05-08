.section .rodata
fmt_in: .string "%d"
fmt_out: .string "%d\n"

.data
n: .space 4
array: .space 8000000
target: .space 4

.section .text
.global main

main :
    addi sp, sp, -56
    sd ra, 48(sp)
    sd s0, 40(sp)    #save n
    sd s1, 32(sp)    #save array address
    sd s2, 24(sp)    #save target
    sd s3, 16(sp)   #save result
    sd s4, 8(sp)
    sd s5, 0(sp)

    #input n
    la a0, fmt_in
    la a1, n
    call scanf
    la s0, n

    li s4, 0
    j input_arr

input_arr:
    bge s4, s0, input_done   #s4 keeping count of index

    slli t0, s4, 2      #t1=s4*8
    add s1, t0, s1

    la a0, fmt_in
    la a1, array
    call scanf
    la s1, array


    li s4, 1
    j input_done

input_done :
    la a0, fmt_in
    la a1, target
    call scanf
    la s2, target   #target at s2; n at s0; array at s1

    li s4, 0
    li t3, -1
    j binary

binary:
    bge s4, s0, loop_done
    #s4 becomes left, s3 will be right, t0 will be mid

    li s3, 0
    addi s3, s1, -1

    add t0, s3, s4
    srai t0, t0, 1


    slli t1, s4, 2
    slli t2, t0, 2
    add t1, s1, t1  #t4 got leftmost value, t5 got mid value
    add t2, s1, t2
    ld t4, 0(t1)
    ld t5, 0(t2)

    beq t5, s2, found


    bgt t4, t5, right_sorted

    j left_sorted

left_sorted:
    blt s2, t4, check_right
    bgt s2, t5, check_right

    addi s3, t0, -1
    j binary

right_sorted:
    slli t1, s3, 2
    add t1, s1, t1   #t4 got rightmost value
    ld t6, 0(t1)

    blt s2, t5, check_left
    bgt s2, t6, check_left

    addi s4, t0, 1
    j binary

check_right:
    addi s4, t0, 1
    j binary

check_left:
    addi s3, t0, -1
    j binary

found:
    add a1, t5, x0
    la a0, fmt_out
    call printf
    j done

loop_done:
    la a0, fmt_out
    li a1, -1
    call printf
    j done

done:
    ld ra, 48(sp)
    ld s0, 40(sp)    #save n
    ld s1, 32(sp)    #save array address
    ld s2, 24(sp)    #save target
    ld s3, 16(sp)   #save result
    ld s4, 8(sp)
    ld s5, 0(sp)

    addi sp, sp, 56

    jalr x0, ra

