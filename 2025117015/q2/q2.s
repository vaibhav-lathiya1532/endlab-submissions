.section .data
fmt_in: .string "%lld%lld"
fmt_out: .string "%lld %lld"
N: .dword 0
M: .dword 0

.section .text
.globl main

main:
    addi sp, sp, -40
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp) #stores gcd
    sd s3, 32(sp) #stores lcm

    la a0, fmt_in
    la a1, N
    la a2, M
    call scanf

    la t0, N
    ld s0, 0(t0)
    la t0, M
    ld s1, 0(t0)

    #scanned n and m

    mv s2, s0

    gcd:
        rem t0, s0, s2
        beq t0, x0, gcd1
        addi s2, s2, -1
        j gcd
        gcd1:
            rem t0, s1, s2
            beq t0, x0, gcd_done
            addi s2, s2, -1
            j gcd
    
    gcd_done:

    mv s3, s0
    li t1, 1

    lcm:
        rem t0, s3, s1
        beq t0, x0, lcm_done
        addi t1, t1, 1
        add s3, s3, s0
        j lcm
    lcm_done:
    

    la a0, fmt_out
    mv a1, s2
    mv a2, s3
    call printf

    
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp) 
    addi sp, sp, 40

    ret

