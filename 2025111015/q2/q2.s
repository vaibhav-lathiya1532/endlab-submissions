.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld "
.section .data
N: .dword 0
M: .dword 0
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
    lla a0, fmt_in 
    lla a1, M
    call scanf
    lla t0, M
    sd s1, 0(t0) 
    li s3, 0 #s3 is lcm
    li s4, 0 #s4 is gcd
    li s5, 1 #s5 is i
    li s6, 1 #s6 is j
    li s2, 1 # is I
    li s7, 1 #is J
    li t4, 0

outerloop1:
    bgt s5, s0, done2
    ble s5, s0, innerloop1
    addi s5, s5, 1
    j outerloop1

innerloop1:
    bgt s6, s1, outerloop1
    li t1, 0
    mul t1, s5, s0
    li t2, 0
    mul t2, s6, s1
    beq t1, t2, done1
    addi s6, s6, 1
    j innerloop1

outerloop2:
    bgt s2, s0, done2
    ble s2, s0, innerloop2
    addi s2, s2, 1
    j outerloop2

innerloop2:
    bgt s7, s1, outerloop2
    li t1, 0
    rem t1, s0, s2
    li t2, 0
    rem t2, s1, s7
    mv s5, t1
    mv s6, t2
    beq s5, s6, is_factor
    addi s7, s7, 1
    j innerloop2

is_factor:
    mv s4, s5
    j innerloop2

done1:
    mv s3, t2
    bgt s4, t4, done2
    j innerloop2

done2:
    lla a0, fmt_out
    mv a1, s3
    call printf
    lla a0, fmt_out
    mv a1, s4
    call printf
    li a0, 0
    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 32(sp)
    ld s4, 24(sp)
    ld s5, 16(sp)
    ld s6, 8(sp)
    ld s7, 0(sp)
    addi sp, sp, 80







    
