.section .rodata
int_fmt: .string "%lld"
true: .string "1\n"
false: .string "0\n"

.section .text
.global main

main:
    addi sp, sp, -96
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)

    addi s1, sp, 56
    addi a1, sp, 56
    la a0, int_fmt
    call scanf
    ld s0, 0(s1)

    li s4, 0
    mv s5, x0

inputloop:
    beq s4, s0, inputdone
    addi s4, s4, 1
    addi s1, sp, 56
    addi a1, sp, 56
    la a0, int_fmt
    call scanf
    ld a0, 0(s1)
    call addprime
    j inputloop

inputdone:
    mv a0, s5
    call printf
end:
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    addi sp, sp, 100
    ret


addprime:
    addi sp, sp, -16
    sd ra, 0(sp)
    mv t1, a0
    li t2, 2

checkdiv:
    bge t1, t2, prime
    rem t3, t1, t2
    beqz t3, notprime
    addi t2, t2,1
    j checkdiv

prime:
    add s5, s5, t1

notprime:
    ld ra, 0(sp)
    addi sp, sp, 16






    


