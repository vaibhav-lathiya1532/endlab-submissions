.section .data

input_format: .string "%ld"
output_format: .string "%ld\n"
rushil: .string "%ld %ld %ld\n"


n: .space 8
array: .space 900
prev: .space 900
after: .space 900
temp: .space 8

.text
.globl main

main: 
    addi sp, sp, -16
    sd ra, 8(sp)
    la a0, input_format
    la a1, n
    call scanf
    la s0, n
    ld s0, 0(s0) # s0 = n
    li s1, 0 # i=0
    la s10, array

loop:
    bge s1, s0, input_done
    la a0, input_format
    la a1, temp
    call scanf
    la t0, temp
    ld t0, 0(t0)
    slli t1, s1, 3
    add t1, s10, t1 # &arr[i]
    sd t0, 0(t1) # arr[i] = number
    addi s1, s1, 1
    j loop

input_done:
    la s2, prev # s2 = &prev
    li s1, 0 # i = 0
    li s11, 0 # prev
prev_loop:
    beq s1, s0, prev_done
    slli t0, s1, 3
    add t0, t0, s2 # &prev[i] 
    sd s11, 0(t0)
    # ===================
    # la a0, rushil
    # mv a1, s11
    # call printf
    # =========================
    slli t0, s1, 3
    add t0, t0, s10 # &arr[i] 
    ld t0, 0(t0)
    add s11, s11, t0
    addi s1, s1, 1
    j prev_loop
prev_done:
    la s3, after # s3 = &after
    addi s1, s0, -1# i = n - 1
    li s11, 0 # prev

after_loop:
    blt s1, zero, after_done    
    slli t0, s1, 3
    add t0, t0, s3 # &prev[i] 
    sd s11, 0(t0)
    # ===================
    # la a0, rushil
    # mv a1, s11
    # call printf
    # =========================
    slli t0, s1, 3
    add t0, t0, s10 # &arr[i] 
    ld t0, 0(t0)
    add s11, s11, t0
    addi s1, s1, -1
    j after_loop
after_done:
    li s1, 0 # i=0
    la s2, prev # s2 = &prev
    la s3, after # s2 = &prev
    
check:
    bge s1, s0, check_done
    slli s7, s1, 3
    add s7, s7, s2 #&prev[i]
    ld s7, 0(s7)
    slli s8, s1, 3
    add s8, s8, s3 #&after[i]
    ld s8, 0(s8)
    # =================
    # la a0, rushil
    # mv a1, s1
    # mv a2, s7
    # mv a2, s8
    # call printf
    # =================
    beq s8, s7, found
    addi s1, s1, 1
    j check

found:
    la a0, output_format
    mv a1, s1
    call printf
    j exit_code

check_done:
    la a0, output_format
    li a1, -1
    call printf
    j exit_code

exit_code:
    ld ra, 8(sp)
    addi sp, sp, 16
    ret