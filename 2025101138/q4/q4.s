.section .data
    fmt_in : .string "%d"
    fmt_out : .string "%d "

.section .bss
    price : .word 0
    inserted : .word 0

.section .text
.globl main

main:
    addi sp,sp,-80
    sd ra, 72(sp)
    sd s7, 64(sp)
    sd s6, 56(sp)
    sd s5, 48(sp)
    sd s4, 40(sp)
    sd s3, 32(sp)
    sd s2, 24(sp)
    sd s1, 16(sp)
    sd s0, 8(sp)

    la a0, fmt_in
    la a1, price
    call scanf
    lw s0, price                

    la a0, fmt_in
    la a1, inserted
    call scanf  
    lw s1, inserted             

    sub s0, s1,s0               # s0 = change
    li s1, 0                    # s1 = count

go_initial:
    li s2, 25                   # s2 = curr
    j while_loop


go_ten:
    li s2, 10
    j while_loop

go_five:
    li s2, 5
    j while_loop

go_one:
    li s2, 1
    j while_loop


while_loop:
    blt s0, s2, after_while
    sub s0, s0, s2
    addi s1, s1, 1
    j while_loop

after_while:
    la a0, fmt_out
    mv a1, s1
    call printf
    li s1, 0

    li t0, 25
    li t1, 10
    li t2, 5

    beq s2, t0, go_ten
    beq s2, t1, go_five
    beq s2, t2, go_one


return:
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    ld s7, 64(sp)
    ld ra, 72(sp)
    addi sp,sp,80

    li a0, 0
    ret
