.section .data
input_fmt: .asciz "%lld"
output_fmt: .asciz "%lld\n"

n: .dword 0
target: .dword 0
temp: .dword 0

.section .text

.globl main

main:
    addi sp, sp, -56
    sd s5, 48(sp)   # target
    sd s4, 40(sp)   # end
    sd s3, 32(sp)   # mid
    sd s2, 24(sp)   # i or start
    sd s1, 16(sp)   # N
    sd s0, 8(sp)    # array
    sd ra, 0(sp)

    # scanf("%lld", n), here n is address
    la a0, input_fmt
    la a1, n
    call scanf

    # t0 = address of input value (&N)
    la t0, n
    # s1 = input value (N)
    ld s1, 0(t0)

    # s0 = malloc(8*N) (array)
    slli t1, s1, 3
    mv a0, t1
    call malloc
    mv s0, a0

    li s6, 0
    # s2 = index (i)
    li s2, 0
    call input_loop

    # scanf("%lld", target), here target is address
    la a0, input_fmt
    la a1, target
    call scanf

    # t0 = address of target value (&target)
    la t0, target
    # s5 = target value (target)
    ld s5, 0(t0)

    li s2, 0    # s2 = 0 (start)
    addi s4, s1, -1 # s4 = N-1 (end)
    add s3, s2, s4  # s3 = start + end
    srli s3, s3, 1  # s3 = s3 // 2
    call bin_srch

    ld s5, 48(sp)   # target
    ld s4, 40(sp)   # end
    ld s3, 32(sp)   # mid
    ld s2, 24(sp)   # i or start
    ld s1, 16(sp)   # N
    ld s0, 8(sp)    # array
    ld ra, 0(sp)
    addi sp, sp, 56

    ret

input_loop:
    bge s2, s1, input_end

    beq s0, x0, store_return
    addi s0, s0, 1

    # scanf("%lld", array + 8*index)
    la a0, input_fmt
    la a1, temp
    call scanf

    # t2 = 8*index
    slli t2, s2, 3
    # t3 = array + 8*index
    add t3, s0, t2

    # t0 = address of input
    la t0, temp
    ld t1, 0(t0)
    sd t1, 0(t3)

    # index++
    addi s2, s2, 1

    j input_loop

store_return:
    addi sp, sp, -8
    sd ra, 0(sp)
    

input_end:
    ld ra, 0(sp)
    addi sp, sp, 8

    ret

bin_srch:
    bgt s2, s4, not_found
    beq s2, s4, check_ind

    # t4 = array[start]
    slli t4, s2, 3
    add t4, s0, t4
    ld t4, 0(t4)

    # t5 = array[mid]
    slli t5, s3, 3
    add t5, s0, t5
    ld t5, 0(t5)

    # t6 = array[end]
    slli t6, s4, 3
    add t6, s0, t6
    ld t6, 0(t6)

    ble t4, t5, left_sorted
    bgt t4, t5, right_sorted

left_sorted:
    bge s5, t4, move_left

    # start = mid
    mv s2, s3

    blt s5, t4, move_right

right_sorted:
    bgt s5, t6, move_left

    # start = mid
    mv s2, s3

    ble s5, t6, move_right

move_left:
    # end = mid
    mv s4, s3

    # mid = (start + end)//2
    add s3, s2, s4
    srli s3, s3, 1

    j bin_srch

move_right:
    # mid = (start + end)//2
    add s3, s3, s4
    srli s3, s3, 1

    j bin_srch

check_ind:
    # t4 = array[ind]
    slli t4, s2, 3
    add t4, s0, t4
    ld t4, 0(t4)

    beq t4, s5, found

not_found:
    la a0, output_fmt
    li a1, -1
    call printf

    ret

found:
    la a0, output_fmt
    addi a1, s2, 0
    call printf

    ret
