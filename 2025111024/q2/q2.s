.data
n : .dword 0
m: .dword 0
fmt: .string "%lld %lld"
fmtop: .string "%lld %lld\n"


.text
.globl main

main:
    addi sp, sp, -112
    sd ra, 104(sp)
    sd s0, 96(sp)
    sd s1, 88(sp)
    sd s2, 80(sp)
    sd s3, 72(sp)
    sd s4, 64(sp)
    sd s5, 56(sp)
    sd s6, 48(sp)
    sd s7, 40(sp)
    sd s8, 32(sp)
    sd s9, 24(sp)
    sd s10, 16(sp)
    sd s11, 8(sp)

    #input
    la a0, fmt
    la a1, m 
    la a2, n 
    call scanf

    la t0, n 
    la t1, m 

    ld s0, 0(t0) #s0 = n
    ld s1, 0(t1) #s1 = m

    #choose num
    bge s1, s0, choosem
    add s3, s0, x0
    beq x0, x0, next_step
    choosem:
        add s3, s1, x0
    
    next_step:
    addi s11, x0, 1 #possible gcd
    addi s4, x0, 1 #loop variable

    gcd:
        bgt s4, s3, exitgcd
        rem s5, s0, s4
        rem s6, s1, s4
        beq s5, x0, checktrue
        addi s4, s4, 1
        j gcd
        checktrue:
            beq s6, x0, poss
            addi s4, s4, 1
            j gcd
        poss:
            add s11, x0, s4
            addi s4, s4, 1
            j gcd
    exitgcd:
    #s11 contains gcd
    #lcm * gcd = m* n
    mul s10, s0, s1
    div s10, s10, s11
    #s10 contains lcm

    la a0, fmtop
    add a1, x0, s11
    add a2, x0, s10
    call printf

    ld s11, 8(sp)
    ld s10, 16(sp)
    ld s9, 24(sp)
    ld s8, 32(sp)
    ld s7, 40(sp)
    ld s6, 48(sp)
    ld s5, 56(sp)
    ld s4, 64(sp)
    ld s3, 72(sp)
    ld s2, 80(sp)
    ld s1, 88(sp)
    ld s0, 96(sp)
    ld ra, 104(sp)
    addi sp, sp, 112

    add a0, x0, x0
    ret
