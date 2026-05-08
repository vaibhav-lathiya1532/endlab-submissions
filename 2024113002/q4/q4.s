.data
    fmt_in: .asciz "%d %d"
    fmt_out: .asciz "%d %d %d %d\n"

    price : .word 0
    inserted: .word 0

.text
.globl main
.extern scanf
.extern printf

main:

    la a0, fmt_in
    la a1, price
    la a2, inserted

    call scanf   #called scanf with a0 for format and a1, a2 as values

    ld t0, price
    ld t1, inserted

    sub t2, t1,t0 #calculating change = inserted - price, t2 = change

    #initialize counters

    li s0, 0 #quarters
    li s1, 0 #dimes
    li s2, 0 #nickels
    li s3, 0 #pennies


q_loop:

    li t3,25 #loading quarter value
    blt t2, t3, d_loop    #if change < 25, move to dimes

    addi s0, s0, 1  #incrementing counter
    sub t2, t2, t3 #subtracting value of penny for next run

    j q_loop #jumps to q_loop

d_loop:

    li t3, 10 #loading dime value
    blt t2, t3, n_loop #if change < 10, move to nickels

    addi s1, s1, 1 #incrementing counter
    sub t2, t2, t3  #change -= dime

    j d_loop #jumps to d_loop

n_loop:

    li t3, 5 #loading nickel value
    blt t2, t3, p_loop #if change < 5, move to pennies

    addi s2, s2, 1 #incrementing counter
    sub t2, t2, t3  #change -= nickel

    j n_loop #jumps to n_loop

p_loop:

    li t3, 1 #loading penny value
    blt t2, t3, result #if change < 1, change = 0

    addi s3, s3, 1 #incrementing counter
    sub t2, t2, t3  #change -= penny

    j p_loop #jumps to p_loop

result:

    la a0, fmt_out
    mv a1, s0
    mv a2, s1
    mv a3, s2
    mv a4, s3 #moved all counters to print them

    call printf #print

    li a0, 0
    ret 