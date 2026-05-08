.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"
.section .data
N: .dword 0
target: .dword 0
nums: .space 80
.section .text
.globl main

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 32(sp)
    sd s4, 24(sp)
    sd s5, 16(sp)
    sd s6, 8(sp)
    sd s7, 0(sp)

    lla a0, fmt_in
    lla a1, N 
    call scanf 
    lla t0, N 
    sd s0, 0(t0)
    li s1, nums
    li s2, 0 #s2 is count
    li s3, 0

read_loop:
    beq s2, s0, extract_done
    lla a0, fmt_in 
    lla a1, nums
    call scanf
    lla t0, nums
    sd s3, 0(t0)
    addi s2, s2, 1


read_done:


search_loop:
    bgt t0, N, not_found
    mv t2, s0
    srai t2, t2, 1
    slli t3, t2, 3
    add t3, s1, t3
    ld t3, 0(t3)
    slli t4, s3, 3
    


right_sorted:
left_sorted:
go_right:
go_left:
found:
not_found:
done:
