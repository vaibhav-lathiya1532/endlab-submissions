.section .data
input_fmt: .asciz "%lld"
output_fmt: .asciz "%lld\n"

n: .dword 0
l: .dword 0
temp: .dword 0

.section .text

.globl main

main:
    addi sp, sp, -56
    sd s5, 48(sp)   # j -> end
    sd s4, 40(sp)   # i -> initial
    sd s3, 32(sp)   # array
    sd s2, 24(sp)   # count
    sd s1, 16(sp)   # l
    sd s6, 8(sp)    # n
    sd ra, 0(sp)

    # scanf("%lld", n), here n is address
    la a0, input_fmt
    la a1, n
    call scanf

    # t0 = address of input value (&n)
    la t0, n
    # s6 = input value (n)
    ld s6, 0(t0)

    # scanf("%lld", l), here l is address
    la a0, input_fmt
    la a1, l
    call scanf

    # t0 = address of input value (&l)
    la t0, l
    # s1 = input value (l)
    ld s1, 0(t0)

    # s3 = malloc(8*N) (array)
    slli t1, s6, 3
    mv a0, t1
    call malloc
    mv s3, a0

    mv s4, x0    # i = 0
    li s7, 0
    call input_loop

    li s4, 0    # i = 0
    addi s5, s6, -1     # j = n-1

    # count = 0
    li s2, 0

    li s6, 0
    call verify

    ld s5, 48(sp)   # j -> end
    ld s4, 40(sp)   # i -> initial
    ld s3, 32(sp)   # array
    ld s2, 24(sp)   # count
    ld s1, 16(sp)   # l
    ld s6, 8(sp)    # n
    ld ra, 0(sp)
    addi sp, sp, 56

    ret

input_loop:
    bge s4, s6, input_end

    beq s7, x0, store_return

    # scanf("%lld", array + 8*index)
    la a0, input_fmt
    la a1, temp
    call scanf

    # t2 = 8*index
    slli t2, s4, 3
    # t3 = array + 8*index
    add t3, s3, t2

    # t0 = address of input
    la t0, temp
    ld t1, 0(t0)
    sd t1, 0(t3)

    # index++
    addi s4, s4, 1

    j input_loop

store_return:
    addi sp, sp, -8
    sd ra, 0(sp)
    addi s7, s7, 1
    j input_loop

input_end:
    ld ra, 0(sp)
    addi sp, sp, 8

    ret

verify:
    bgt s4, s5, verify_end
    beq s4, s5, index_equal

    beq s6, x0, store_return
    addi s6, s6, 1

    # t0 = array[i]
    slli t0, s4, 3
    add t0, s3, t0
    ld t0, 0(t0)

    # t1 = array[j]
    slli t1, s5, 3
    add t1, s3, t0
    ld t1, 0(t1)

    # t2 = array[i] + array[j]
    add t2, t0, t1

    # if sum > l add only last element
    bgt t2, s1, add_last

    # count++
    addi s2, s2, 1
    # i++
    addi s4, s4, 1
    # j--
    addi s5, s5, -1

    j verify

add_last:
    # count++
    addi s2, s2, 1
    # j--
    addi s5, s5, -1

    j verify

index_equal:
    # count++
    addi s2, s2, 1

verify_end:
    la a0, output_fmt
    addi a1, s2, 0
    call printf

    ld ra, 0(sp)
    addi sp, sp, 8

    ret