.section .rodata
fmt_in: .asciz "%ld %ld"
fmt_out: .asciz "%ld %ld\n"
fmt_one: .asciz "%ld\n"

.text
.globl main
# t0: m
# t1: n
# t2: i
# t3: 2147483647
# t4: 9223372036854775807
# t5: mod m
# t6: mod n
# a1: gcd
# a2: lcm
main:
addi sp, sp, -32
sd ra, 0(sp)

    la a0, fmt_in
    addi a1, sp, 8
    addi a2, sp, 16
    call scanf

    ld t0, 8(sp)
    ld t1, 16(sp)

    li t2, 0
    li t3, 2147483647
    li t4, 9223372036854775807

    loop1:
        addi t2, t2, 1
        bge t2, t3, continue1

        rem t5, t0, t2
        rem t6, t1, t2

        bnez t5, loop1
        bnez t6, loop1

        mv a1, t2

        beq t2, t0, continue1
        beq t2, t1, continue1
    j loop1
    continue1:

    li t2, 0
    loop2:
        addi t2, t2, 1
        bge t2, t4, continue2

        rem t5, t2, t0
        rem t6, t2, t1

        bnez t5, loop2
        bnez t6, loop2

        la a0, fmt_out
        mv a2, t2
        call printf
        j exit

    j loop2
    continue2:

exit:
ld ra, 0(sp)
addi sp, sp, 16
li a0, 0
ret
