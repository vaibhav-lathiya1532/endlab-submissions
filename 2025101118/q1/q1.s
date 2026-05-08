.data
buffer: .space 800000
scanf_fmt: .string "%lld"
printf_true: .string "TRUE\n"
printf_false: .string "FALSE\n"

.text
.globl main
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp) # N
    sd s1, 40(sp) # buffer
    sd s2, 32(sp)

    la a0, scanf_fmt
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)

    li s2, 0
    la s1, buffer

input_loop:
    beq s2, s0, next
    slli t0, s2, 3  #t0=s2*8
    add a1, s1, t0 
    la a0, scanf_fmt
    call scanf
    addi s2, s2, 1
    j input_loop

next:
    li s2, 0
    slli t0, s2, 3
    add t0, s1, t0
    ld t1, 0(t0) #t1=number in the array
    addi s2, s2, 1
    andi t2, t1, 1
    li t3, 0
    li t4, 1
    beq t2, t3, odd
    beq t2, t4, even

odd:
    beq s2, s0, passed
    slli t0, s2, 3
    add t0, s1, t0
    ld t1, 0(t0)
    addi s2, s2, 1
    andi t2, t1, 1
    li t4, 1
    beq t2, t4, even
    j failed

even:
    beq s2, s0, passed
    slli t0, s2, 3
    add t0, s1, t0
    ld t1, 0(t0)
    addi s2, s2, 1
    andi t2, t1, 1
    li t3, 0
    beq t2, t3, odd
    j failed

passed:
    la a0, printf_true
    call printf
    j done

failed:
    la a0, printf_false
    call printf
    
done:
    ld ra, 56(sp)
    ld s0, 48(sp) # N
    ld s1, 40(sp) # buffer
    ld s2, 32(sp)
    addi sp, sp, 64
    li a0, 0
    ret