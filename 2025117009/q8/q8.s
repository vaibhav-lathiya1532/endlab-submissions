.data
fmtin: .asciz "%lld"
fmtout: .asciz "%lld\n"
fmt_left: .asciz "goes left\n"
fmt_right: .asciz "goes right\n"
n: .quad 0
target: .quad 0
arr: .space 800000

.text
.globl main

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)   # store n
    sd s1, 56(sp)   # array pointer
    sd s2, 48(sp)   # left
    sd s3, 40(sp)   # right
    sd s4, 32(sp)   # mid
    sd s5, 24(sp)   # iterator
    sd s6, 16(sp)   # target

    la a0, fmtin
    la a1, n
    jal ra, scanf

    ld s0, n
    li s5, 0
    la s1, arr

input_loop:
    beq s5, s0, target_input

    addi t0, s5, 0
    slli t0, t0, 3
    la a0, fmtin
    add a1, s1, t0
    jal ra, scanf

    addi s5, s5, 1
    j input_loop

target_input:
    la a0, fmtin
    la a1, target
    jal ra, scanf

    ld s6, target

init:
    li s2, 0
    addi s3, s0, -1

loop:
    bgt s2, s3, target_not_found

    add t0, s2, s3
    srai s4, t0, 1  # value of mid in s4 = (l+r)/2

    addi t0, s4, 0
    slli t0, t0, 3
    add t0, t0, s1
    ld t1, 0(t0)    # t1 = a[mid]

    beq t1, s6, target_found

    addi t0, s2, 0
    slli t0, t0, 3
    add t0, t0, s1
    ld t2, 0(t0)    # t2 = a[l]

    addi t0, s3, 0
    slli t0, t0, 3
    add t0, t0, s1
    ld t3, 0(t0)    # t3 = a[r]

    bgt t2, t1, right_sorted

left_sorted:
    blt s6, t2, go_right
    bge s6, t1, go_right

    j go_left

right_sorted:
    ble s6, t1, go_left
    bgt s6, t3, go_left

    j go_right

go_left:
    addi s3, s4, -1
    j loop

go_right:
    addi s2, s4, 1
    j loop

target_found:
    la a0, fmtout
    addi a1, s4, 0
    jal ra, printf
    j finish_exec

target_not_found:
    la a0, fmtout
    li a1, -1
    jal ra, printf
    j finish_exec

finish_exec:
    ld ra, 72(sp)
    ld s0, 64(sp)   
    ld s1, 56(sp)
    ld s2, 48(sp) 
    ld s3, 40(sp)  
    ld s4, 32(sp)  
    ld s5, 24(sp)  
    ld s6, 16(sp) 
    addi sp, sp, 80
    ret
