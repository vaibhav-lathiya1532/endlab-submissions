.data
fmt_in: .string "%lld"
fmt_true: .string "TRUE"
fmt_false: .string "FALSE"

.text
.globl main

main: 
    addi sp, sp, -40
    sd ra, 0(sp)
    sd s0, 8(sp) # <- number
    sd s1, 16(sp) # <-position
    sd s2, 24(sp) # <- final sum
    sd s3, 32(sp) # <- to hold current number

    la a0, fmt_in
    addi a0, sp, 0
    call scanf
    ld s0, 0(sp) 

    li s1, 1 
    li s2, 0

loop:
    mv t0, s1
    slli t0, 2
    add t1, s0, t0

    mv s3, t1

    addi s1, 1


mult
    mv a0, s1
    mv a1, s3

    beqz a0, loop

    mul a1, a1
    addi a0, a0, -1

    j mult

add:
    mv a2, 0(s2)
    mv a3,.0(s3)

    add a2, a2, a3

    j loop

read:
    mv a4, 0(s2)
    mv a5, 0(s0)

    beq a5, a4, true

false: 
    la a6, fmt_false
    mv a7, 0
    call printf

    j done

true:
    la a6, fmt_true
    mv a7, 0
    call printf

done:
    addi sp, sp, 40
    ld ra 0(sp)
    ld s0 8(sp) 
    ld s1 16(sp) 
    ld s2 24(sp) 
    ld s3 32(sp) 

    li a0, 0
    ret