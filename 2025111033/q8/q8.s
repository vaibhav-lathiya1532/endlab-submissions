# 2025111033

.section .rodata
.align 3
input_fmt: .string "%lld"
output_fmt: .string "%lld\n"


.text
.globl main
.align 2

main:
    addi sp, sp, -80
    sd ra, 72(sp)

    la a0, input_fmt
    addi a1, sp, 64
    call scanf

    ld s0, 64(sp) # s0 = N

    slli a0, s0, 3 # a0 = N*8
    call malloc # now a0 will hold base address of the array

    mv s1, a0 # now s1=base address of the array


    li t0, 0 # t0 = i =0
    array_input_loop:
        bge t0, s0, target_input #if i is more than or equal to N, then go get the next input
        la a0, input_fmt
        mv a1, s1 # a1=arr
        slli t1, t0, 3 #t1=8*i
        add a1, a1, t1 # a1 = arr + 8*i, which is &arr[i]
        call scanf

        addi t0, t0, 1 # i++
        j array_input_loop
    

    target_input:
        la a0, input_fmt
        addi a1, sp, 64
        call scanf
        ld s2, 64(sp) #s2=target
        
    li t0, 0 # low = t0 = 0
    addi t1,s0,-1 # high = t1 = N-1
    li t2, -1 #ans=t2=-1

    loop:
    bgt t0, t1, final_print # while low<=high. if low>high, break
    mv t3, t0 # t3=t0=low
    sub t4, t1, t0 # t4 = high-low
    srli t4, t4, 1 # t4 = (high - low)/2
    add t3, t3, t4 # t3 = mid = low + (high-low)/2

    slli t4, t3, 3 # t4 = 8*mid
    add t4, t4, s1 # t4 = &arr[mid]
    ld t4, 0(t4) # t4 = arr[mid]

    bne t4, s2, left_side_sorted # if arr[mid]!=target, then go to left side left_side_sorted
    #if you are here, then arr[mid]==target
    mv t2, t3
    j final_print

    left_side_sorted:
    
    slli t5, t0, 3 #t5=low*8
    add t5, t5, s1 # t5 = low*8 + arr
    ld t5, 0(t5) # t5 = arr[low]

    bgt t5, t4, right_side_sorted


        bgt t5, s2, else_leftsorted
        ble t4, s2, else_leftsorted
        addi t1, t3, -1
        j loop
        else_leftsorted:
        addi t0, t3, 1
        j loop

    right_side_sorted:

        slli t5, t1, 3 # t5 = high*8
        add t5, t5, s1 # t5 = arr + high*8
        ld t5, 0(t5) # t5 = arr[high]

        blt t5, s2, else_rightsorted
        bge t4, s2, else_rightsorted
        addi t0, t3, 1
        j loop
        else_rightsorted:
        addi t1, t3, -1
        j loop

final_print:
    la a0, output_fmt
    mv a1, t2
    call printf

    ld ra, 72(sp)
    addi sp,sp,80
    addi a0, zero, 0
    ret
