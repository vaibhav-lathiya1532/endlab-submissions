.section .rodata
    fmt: .asciz "%d"
    fmt_out: .asciz "%d\n"

.section .text
.global main

main:
    addi sp,sp,-64
    sd ra,0(sp)

    # 8(sp) ----> n
    # 16(sp) ---> arr (base address)
    # 24(sp) ---> target
    # 32(sp) ---> left/i
    # 40(sp) ---> right
    # 48(sp) ---> mid

    la a0,fmt
    addi a1,sp,8
    call scanf

    lw t0,8(sp)     # n
    slli a0,t0,2    # n*4
    call malloc

    sd a0,16(sp)

    sw x0,32(sp)    # i = 0

scan_loop:
    lw t0,8(sp)     # n
    lw t1,32(sp)    # i

    bge t1,t0,scan_target

    slli t2,t1,2    # i*4
    ld t3,16(sp)
    add a1,t3,t2    # a1 = &arr[i]

    la a0,fmt
    call scanf

    lw t1,32(sp)    # i
    addi t1,t1,1
    sw t1,32(sp)

    j scan_loop

scan_target:
    la a0,fmt
    addi a1,sp,24
    call scanf

    sw x0,32(sp)    # left = 0
    lw t0,8(sp)
    addi t0,t0,-1
    sw t0,40(sp)    # right = n-1

loop:
    lw t0,8(sp)     # n
    lw t1,32(sp)    # left
    lw t2,40(sp)    # right

    bgt t1,t2,not_found

    sub t3,t2,t1
    srai t3,t3,1
    add t3,t3,t1    # mid

    sw t3,48(sp)

    ld a1,16(sp)    # &arr
    lw a2,24(sp)    # target

    slli t4,t3,2
    add t4,t4,a1    
    lw t5,0(t4)     # arr[mid]

    beq t5,a2,found

    slli t4,t1,2
    add t4,t4,a1
    lw t6,0(t4)     # arr[left]

    ble t6,t5,left_sorted

    bge a2,t5,right_of_right

    slli t4,t2,2
    add t4,t4,a1
    lw t2,0(t4)     # arr[right]

    bgt a2,t2,right_of_right

    addi t1,t3,1
    sw t1,32(sp)

    j loop

right_of_right:
    addi t0,t3,-1
    sw t0,40(sp)
    j loop

left_sorted:
    bgt t6,a2,left_of_left
    ble t5,a2,left_of_left

    addi t0,t3,-1
    sw t0,40(sp)

    j loop

left_of_left:
    addi t0,t3,1
    sw t0,32(sp)
    j loop

found:
    lw a1,48(sp)

    la a0,fmt_out
    call printf

    ld ra,0(sp)
    addi sp,sp,64
    li a0,0
    ret

not_found:
    li a1,-1
    la a0,fmt_out
    call printf

    ld ra,0(sp)
    addi sp,sp,64
    li a0,0
    ret
