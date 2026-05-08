.data
fmtin: .asciz "%lld"
fmtout: .asciz "%lld "
m: .quad 0
n: .quad 0

.text
.globl main

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)   # store m
    sd s1, 56(sp)   # store n
    sd s2, 48(sp)   # stores smallest among these 2
    sd s3, 40(sp)   # stores gcd
    sd s4, 32(sp)   # stores lcm
    sd s5, 24(sp)   # stores largest among these 2
    sd s6, 16(sp)   

    la a0, fmtin
    la a1, m
    jal ra, scanf
    ld s0, m

    la a0, fmtin
    la a1, n 
    jal ra, scanf
    ld s1, n 

    bgt s0, s1, n_is_smallest

m_is_smallest:
    addi s2, s0, 0
    addi s5, s1, 0

n_is_smallest:
    addi s2, s1, 0
    addi s5, s0, 0

init_gcd:
    addi s3, s2, 0

gcd_loop:
    addi t0, zero, 1
    beq s3, t0, init_lcm

    rem t0, s0, s3
    rem t1, s1, s3

    bne t0, zero, dec_gcd
    bne t1, zero, dec_gcd

    j init_lcm

dec_gcd:
    addi s3, s3, -1
    j gcd_loop

init_lcm:
    addi s4, s5, 0

lcm_loop:
    rem t0, s4, s0
    rem t1, s4, s1

    bne t0, zero, inc_lcm
    bne t1, zero, inc_lcm

    j print_result

inc_lcm:
    addi s4, s4, 1
    j lcm_loop

print_result:
    la a0, fmtout
    addi a1, s3, 0
    jal ra, printf

    la a0, fmtout
    addi a1, s4, 0
    jal ra, printf

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
