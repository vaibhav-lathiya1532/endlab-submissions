.section .rodata
input: 
    .string "%lld"
output:
    .string "%lld\n"

.section .text
.global main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s5, 48(sp)
    sd s4, 40(sp)
    sd s3, 32(sp)
    sd s2, 24(sp)
    sd s1, 16(sp)
    sd s0, 8(sp)
    
    lla a0, input
    mv a1, sp
    call scanf
    ld s0, 0(sp)        # s0 = n

    slli a0, s0, 3
    call malloc
    mv s1, a0           # s1 = &arr

    li s2, 0            # s2 = i

read_loop:
    bge s2, s0, read_done

    lla a0, input
    mv a1, sp
    call scanf
    ld t0, 0(sp)

    slli t1, s2, 3
    add t1, t1, s1
    sd t0, 0(t1)

    addi s2, s2, 1
    j read_loop

read_done:
    lla a0, input
    mv a1, sp
    call scanf
    ld s2, 0(sp)        # s2 = target

    li s3, 0            # s3 = left
    addi s4, s0, -1     # s4 = right
    li a1, -1           # a1 = ans

binary_search:
    bgt s3, s4, print

    sub s5, s4, s3
    srai s5, s5, 2
    add s5, s5, s3      # s5 = mid

    slli t0, s5, 3
    add t0, t0, s1
    ld t0, 0(t0)        # t0 = arr[mid]

    beq t0, s2, found

    slli t1, s3, 3
    add t1, t1, s1
    ld t1, 0(t1)        # t1 = arr[left]

    blt t0, t1, right_sorted

left_sorted:
    blt s2, t1, update_left
    bgt s2, t0, update_left
    j update_right

right_sorted:
    slli t2, s4, 3
    add t2, t2, s1
    ld t2, 0(t2)        # t2 = arr[right]

    blt s2, t0, update_right
    bgt s2, t2, update_right
    j update_left

update_left:
    addi s3, s5, 1
    j binary_search

update_right:
    addi s4, s5, -1
    j binary_search

found:
    mv a1, s5

print:
    lla a0, output
    call printf

    mv a0, s1
    call free

    ld ra, 56(sp)
    ld s5, 48(sp)
    ld s4, 40(sp)
    ld s3, 32(sp)
    ld s2, 24(sp)
    ld s1, 16(sp)
    ld s0, 8(sp)
    addi sp, sp, 64

    li a0, 0
    ret
    