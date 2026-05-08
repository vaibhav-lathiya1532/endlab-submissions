.global main

.data
scan_int: .asciz "%lld"
scan_val: .asciz "%d"
print_val: .asciz "%d\n"
num1: .dword 0

.bss
array: .space 400000

.text
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    sd s5, 8(sp)

    la a0, scan_int
    la a1, num1
    call scanf

    la t0, num1
    la s2, array
    ld s0, 0(t0)
    mv s1, x0
    mv s3, x0 
    mv s4, s0
    addi s4, s4, -1
    slli s4, s4, 2

read_arr:
    beq s1, s0, read_done
    slli t3, s1, 2
    add t3, t3, s2

    la a0, scan_val
    mv a1, t3
    call scanf

    addi s1, s1, 1
    j read_arr

read_done:
    add s3, s3, s2
    add s4, s4, s2
    li t0, 0
    li t1, 0

while_loop:
    addi t3, s3, 4
    beq t3, s4, check
    bge t0, t1, inc_right
    lw t3, 4(s4)
    add t1, t1, t3
     addi s4, s4, -4
    j while_loop

inc_right:
    lw t3, 0(s3)
    add t0, t0, t3
    addi s3, s3, 4
    j while_loop

check:
    beq t0, t1, yes
    li a1, -1
    j done

yes:
    sub s3, s3, s2
    li t5, 4
    div a1, s3, t5
    addi a1, a1, 1

done:
    la a0, print_val
    call printf
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)
    ld s5, 8(sp)
    addi sp, sp, 64
    li a0, 0
    ret






