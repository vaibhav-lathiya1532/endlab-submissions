.section .rodata
input1: .string "%lld"
input2: .string "%lld %lld"
output: .string "%lld\n"

.section .text
.global main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s4, 48(sp)
    sd s3, 40(sp)
    sd s2, 32(sp)
    sd s1, 24(sp)
    sd s0, 16(sp)

    lla a0, input2
    mv a1, sp
    add a2, sp, 8
    call scanf
    ld s0, 0(sp)        # s0 = n
    ld s1, 8(sp)        # s1 = L

    slli a0, s0, 3
    call malloc
    mv s2, a0           # s2 = &arr

    li s3, 0            # s3 = i

read_loop:
    bge s3, s0, read_done

    lla a0, input1
    mv a1, sp
    call scanf
    ld t0, 0(sp)

    slli t1, s3, 3
    add t1, t1, s2
    sd t0, 0(t1)

    addi s3, s3, 1
    j read_loop

read_done:
    li s3, 0            # s3 = left
    addi s4, s0, -1     # s4 = right
    li a1, 0            # a1 = count

assign_loop:
    bgt s3, s4, print

    slli t0, s3, 3
    add t0, t0, s2
    ld t0, 0(t0)        # t0 = arr[left]

    slli t1, s4, 3
    add t1, t1, s2
    ld t1, 0(t1)        # t1 = arr[right]

    add t2, t0, t1      # t2 = arr[left] + arr[right]
    bgt t2, s1, take_right

take_left:
    addi s3, s3, 1
    
take_right:
    addi s4, s4, -1

    addi a1, a1, 1
    j assign_loop

print:
    lla a0, output
    call printf

    mv a0, s2
    call free

    ld ra, 56(sp)
    ld s4, 48(sp)
    ld s3, 40(sp)
    ld s2, 32(sp)
    ld s1, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 64

    li a0, 0
    ret
