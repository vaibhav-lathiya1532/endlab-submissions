# 2025111033

.section .rodata
.align 3
input_fmt: .string "%lld %lld"
output_fmt: .string "%lld %lld\n"

.text
.globl main
.align 2

main:
    addi sp, sp, -80
    sd ra, 72(sp)

    la a0, input_fmt
    addi a1, sp, 64
    addi a2, sp, 56
    call scanf

    ld s0, 64(sp) # s0 = n
    ld s1, 56(sp) # s1 = m

    bge s1, s0, start # if m>=n, then just start, otherwise you must swap so n is the smaller one
    mv t0, s1 # temp = m
    mv s1, s0
    mv s0, t0

    start:
        li t1, 1 # t1 = gcd = 1
        li s2, 2 # s2 = i = 2
        mv s3, s0 # s3 = n
        addi s3, s3, 1 # s3 = n+1

        loop:
            bge s2, s3, calc_lcm # if i>=n+1, then go and calculate lcm

            rem t2, s0, s2 # t2 = n%i
            bnez t2, loop_end #if n%i is not zero, then go to the loop_end
            rem t2, s1, s2 # t2 = m%i
            bnez t2, loop_end # if m%i is not zero, then go to the loop_end

            #if you're here, then both remainders must have been zero, otherwise you'd have gone to the next iteration
            mv t1, s2

        loop_end:
            addi s2, s2, 1 # i++
            j loop

    calc_lcm:
        mul t3, s0, s1 # t3=n*m
        div t4, t3, t1 # t4 = lcm = n*m / gcd

    la a0, output_fmt
    mv a1,  t1
    mv a2, t4
    call printf

    ld ra, 72(sp)
    li a0, 0
    addi sp, sp, 80
    ret
