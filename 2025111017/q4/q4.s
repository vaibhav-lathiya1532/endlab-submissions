.data
    fmt_s: .string "%lld %lld"
    fmt_o: .string "%lld"
    spc: .string " "

.text
.global main

main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)


insert:
    la a0, fmt_s
    addi a1, sp, 0
    addi a2, sp, 8
    call scanf

    ld s0, 0(sp)
    ld s1, 8(sp)
    sub s2, s1, s0

quarters:
    li t0, 0 #quarters
    li t1, 25

qu_loop:
    blt s2, t1, dimes
    sub s2, s2, t1
    addi t0, t0, 1
    j qu_loop

dimes:
    la a0, fmt_o
    mv a1, t0
    call printf
    la a0, spc
    call printf

    li t2, 0 #dimes
    li t1, 10

di_loop:
    blt s2, t1, nickels
    sub s2, s2, t1
    addi t2, t2, 1
    j di_loop

nickels:
    la a0, fmt_o
    mv a1, t2
    call printf
    la a0, spc
    call printf

    li t3, 0 #nickels
    li t1, 5

ni_loop:
    blt s2, t1, pennies
    sub s2, s2, t1
    addi t3, t3, 1
    j ni_loop

pennies:
    la a0, fmt_o
    mv a1, t3
    call printf
    la a0, spc
    call printf

    mv t4,s2 #pennies

    la a0, fmt_o
    mv a1, t4
    call printf
    
end:
    li a0, 0
    ld ra, 40(sp)
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    addi sp, sp, 48
    ret
