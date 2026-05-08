.section .rodata
fmtin:
    .string "%lld"
fmtout:
    .string "%lld\n"

.section .text
.global main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    addi t0, sp, 32
    lla a0, fmtin
    mv a1, t0
    call scanf
    addi s0, a0 ,0
    li s1, 0
    li t1, 0

foundloop:
    li t6, 100
    beq s1, t6, notfound
    li t5, 1
    beq s0, t5, found   

loop:
    beqz s0, next
    li t2, 10
    rem t3, s0, t2
    div s0, s0, t2
    mul t4, t3, t3
    add t1, t1, t4
    j loop

next:
    addi s1, s1, 1
    j foundloop

notfound:
    lla a0, fmtout
    addi a1, x0, 0
    call printf
    j clear

found:
    lla a0, fmtout
    addi a1, x0, 1
    call printf
    j clear

clear:
    mv a0, x0
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    addi sp, sp, 64
    ret