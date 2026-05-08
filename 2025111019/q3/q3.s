.global main

.section .rodata
fmt_num: .string "%lld "
fmt_endl: .string "%lld\n"

.section .text
main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    sd s4, 0(sp)

    ld s0, a1
    ld s1, 8(s0)

    li t1, s1       #t1 = n
    li t0, 0        #t0 = 1

    la a0, fmt_endl
    
read_loop:
    


