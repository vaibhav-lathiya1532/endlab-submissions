.section .data
fmt_in: .asciz "%d"
fmt_out: .asciz "%d\n"

.section .bss
temp: .space 4
arr: .space 400000

.section .text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmt_in
    la a1, temp
    call scanf

    la t0, temp
    lw s0, 0(t0)
    #s0 is arr size

    la a0, fmt_in
    la a1, temp
    call scanf

    la t0, temp
    lw s1, 0(t0)
    #s1 is load

    la s2, arr

    add t0, x0, x0 #I

read_loop:
    bge t0, s0, done_read

    la a0, fmt_in
    la a1, temp
    call scanf

    la t2, temp

    add t1, t0, x0
    slli t1, t1, 2
    add t1, t1, s2

    lw t3, 0(t2)
    sw t3, 0(t1)

    addi t0, t0, 1
    j read_loop

done_read:
    add t2, x0, x0
    add t0, x0, x0
    addi t1, s0, -1
    #t0 start, t1 end, t2 count

calculator:
    bgt t0, t1, hogya

    #calcuatling array[low]
    add t3, t0, x0
    slli t3, t3, 2
    add t3, t3, s2

    lw t4, 0(t3) #arr[low]

     
    add t3, t1, x0
    slli t3, t3, 2
    add t3, t3, s2

    lw t5, 0(t3) #arr[high]

    add t6, t5, t4
    

    ble t6, s1, send_both

    addi t1, t1, -1
    addi t2, t2, 1

    j calculator

send_both:
    addi t1, t1, -1
    addi t0, t0, 1
    addi t2, t2, 1
    j calculator

hogya:
    la a0, fmt_out
    add a1, x0, t2
    #sw t2, 0(a1)
    call printf

    ld ra, 8(sp)
    addi sp, sp, 16
    ret





