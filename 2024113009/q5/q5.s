.section .rodata

fmt_in: .asciz "%d"
fmt_out: .asciz "%d "
fmt_out_nl: .asciz "%d\n"

.section .text

.globl main

main:

    addi sp, sp, -128
    sd ra, 120(sp)
    sd s0, 112(sp)
    sd s1, 104(sp)
    sd s2, 96(sp)
    sd s3, 88(sp)
    sd s4, 80(sp)
    sd s5, 72(sp)
    sd s6, 64(sp)
    sd s7, 56(sp)

    la a0, fmt_in
    addi a1, sp, 0
    call scanf

    lw s0, 0(sp) #s0 stores N

    mul t0, s0, s0 #N^2


    slli a0, t0, 2 # for the size of int being 4
    call malloc


    mv s1, a0 #moving N^2 array of integer type to s1

    mul s2, s0, s0 #s2 = N^2
    li s3, 0 #index when reading matrix

readMatrix:

    bge s3, s2, rotateStart

    slli t1, s3, 2 # into 4
    add t1, t1, s1 #address of current element to be read
    mv a1, t1
    la a0, fmt_in
    call scanf

    addi s3, s3, 1

    j readMatrix

rotateStart:

    srli s2, s0, 1 # N/2 = s2

    li s3, 0 # s3 is current layer

layerLoop:

    bge s3, s2, printMatrix

    mv s4, s3 #s4 is first
    addi s5, s0, -1 #s5 is last which N-1-layer

    sub s5, s5, s3 

    mv s6, s4 #s6 is i, goes from first to last-1

iLoop:

    bge s6, s5, nextLayer

    #s7 is offset (i - first)
    sub s7, s6, s4

    #top: first, i (address = row*N + col into 4 then add matrix base)
    mv t0, s4
    mul t0, t0, s0
    add t0, t0, s6
    slli t0, t0, 2
    add t0, t0, s1 #t0 is address of top
    lw t4, 0(t0) #t4 is value of top
    
    #left
    sub t1, s5, s7
    mul t1, t1, s0
    add t1, t1, s4
    slli t1, t1, 2

    add t1, t1, s1 #matrix base added. t1 is addr of left
    lw t5, 0(t1)

    #bottom
    mv t2, s5
    mul t2, t2, s0
    add t2, t2, s5
    sub t2, t2, s7
    slli t2, t2, 2
    add t2, t2, s1
    lw t6, 0(t2)

    #right
    mv t3, s6
    mul t3, t3, s0
    add t3, t3, s5
    slli t3, t3, 2
    add t3, t3, s1
    lw a5, 0(t3)

    sw t5, 0(t0)#top stores left value
    sw t6, 0(t1) #left store bottom value
    sw a5, 0(t2) #bottom stores right value
    sw t4, 0(t3) #right stores top

    addi s6, s6, 1

    j iLoop

nextLayer:

    addi s3, s3, 1

    j layerLoop

printMatrix:

    li s3, 0 #row val

rowLoop:

    bge s3, s0, cleanup

    li s4, 0 #col

colLoop:

    bge s4, s0, nextRow 

    mv s5, s3
    mul s5, s5, s0
    add s5, s5, s4
    slli s5, s5, 2

    add a1, s5, s1

    #before we print, check for if last element in col

    addi t0, s0, -1
    beq s4, t0, printLast

    la a0, fmt_out
    call printf

    j printed

printLast:

    la a0, fmt_out_nl
    call printf

printed:

    addi s4, s4, 1

    j colLoop

nextRow:

    addi s3, s3, 1
    j rowLoop

cleanup:

    mv a0, s1
    call free

    li a0, 0
    ld ra, 120(sp)
    ld s0, 112(sp)
    ld s1, 104(sp)
    ld s2, 96(sp)
    ld s3, 88(sp)
    ld s4, 80(sp)
    ld s5, 72(sp)
    ld s6, 64(sp)
    ld s7, 56(sp)

    addi sp, sp, 128
    ret
