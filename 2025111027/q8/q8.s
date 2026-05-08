.section .rodata
input: .string "%lld"
negative: .string "-1\n"
output: .string "%lld\n"

.section .text
.globl main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    
    lla a0, input
    addi a1, sp, 16
    call scanf

    ld s0, 16(sp)

    slli a0, s0, 3
    call malloc
    mv s1, a0

    li s3, 0 # i = 0
input_loop:
    bge s3, s0, input_target # i >= N 

    lla a0, input
    slli a1, s3, 3 # a1 = i * 8
    add a1, a1, s1 # a1 = 
    call scanf

    addi s3, s3, 1
    j input_loop

input_target:
    lla a0, input
    addi a1, sp, 8
    call scanf

    ld s2, 8(sp)

    li t0, 0        # left = 0
    addi t1, s0, -1 # right = n - 1

binary_search_loop:
    bgt t0, t1, not_found # left > right, then not_found

    add t2, t0, t1 # t2 = left + right
    srli t2, t2, 1 # t2 = left + right / 2

    slli t6, t2, 3 # i * 8
    add t6, t6, s1 # base + i * 8
    ld t4, 0(t6)

    beq t4, s2, found 

    slli t6, t0, 3 # i * 8
    add t6, t6, s1 # base + i * 8
    ld t3, 0(t6) 

    slli t6, t1, 3 # i * 8
    add t6, t6, s1 # base + i * 8
    ld t5, 0(t6)

    bgt t3, t4, right_sorted # arr[left] > arr[mid]

    blt s2, t3, search_right # target < arr[left]
    bgt s2, t4, search_right # target > arr[mid]
    j search_left

right_sorted:
    blt s2, t5, search_left
    bgt s2, t4, search_left

search_right:
    addi t0, t2, 1 # left = mid + 1
    j binary_search_loop

search_left:
    addi t1, t2, -1 # right = mid - 1
    j binary_search_loop

found:
    lla a0, output
    mv a1, t2
    call printf
    j end

not_found:
    lla a0, negative
    call printf
    j end

end:
    ld s3, 24(sp)
    ld s2, 32(sp)
    ld s1, 40(sp)
    ld s0, 48(sp)
    ld ra, 56(sp)
    addi sp, sp, 64
    li a0, 0
    ret
