.section .rodata

fmt_in : .string "%lld %lld"
fmt_out : .string "%lld %lld %lld %lld\n"

.section .text 
.global main 
main :
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s1, 48(sp)
    sd s2, 40(sp)
    sd s3, 32(sp)
    sd s4, 24(sp)
    sd s5, 16(sp)

    lla a0, fmt_in
    sd a1, 8(sp)
    sd a2, 0(sp)
    call scanf
    
    li s1, 0
    ld t1, a1
    ld t2, a2
    sub s1, a2, a1

    li s2, 0
    li s3, 0
    li s4, 0
    li s5, 0

q_loop :
    li t3, 25
    blt s1, t3, n_loop
    sub s1, s1, t3
    addi s2, s2, 1
    j q_loop

n_loop :
    li t4, 10
    blt s1, t4, d_loop
    sub s1, s1, t4
    addi s3, s3, 1
    j n_loop

d_loop :
    li t5, 5
    blt s1, t5, p_loop
    sub s1, s1, t5
    addi s4, s4, 1
    j d_loop

p_loop :
    mv s5, s1

    lla a0, fmt_out
    mv a1, s2
    mv a2, s3
    mv a3, s4
    mv a4, s5
    call printf

    li a0, 0
    ld ra, 56(sp)
    ld s1, 48(sp)
    ld s2, 40(sp)
    ld s3, 32(sp)
    ld s4, 24(sp)
    ld s5, 16(sp)
    add sp, sp, 64 
    ret

 