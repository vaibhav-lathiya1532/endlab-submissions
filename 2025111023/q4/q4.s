.section .rodata

fmt:
.string "%lld %lld"
fmt2:
.string "%lld %lld %lld %lld\n"

.globl main

.section .text

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)   
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)

    #read
    lla a0, fmt
    addi a1, sp, 0
    addi a2, sp, 8
    call scanf
    ld s0, 0(sp)    #target
    ld s1, 8(sp)    #input

    li s3, 0
    li s4, 0
    li s5, 0
    li s6, 0

    sub s2, s1, s0

loop:
    beqz s2, end
    li t0, 24
    bgt s2, t0, quarters
    li t1, 9
    bgt s2, t1, dimes
    li t2, 4
    bgt s2, t2, nickles
    addi s2, s2, -1
    addi s6, s6, 1
    j loop

quarters:
    addi s2, s2, -25
    addi s3, s3, 1
    j loop    

dimes:
    addi s2, s2, -10
    addi s4, s4, 1
    j loop

nickles:
    addi s2, s2, -5
    addi s5, s5, 1
    j loop

end:
    lla a0, fmt2
    add a1, x0, s3
    add a2, x0, s4
    add a3, x0, s5
    add a4, x0, s6
    call printf

    #clear
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
