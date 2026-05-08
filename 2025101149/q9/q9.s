    .section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%d\n"

    .section .text
    .globl main
main:
    addi sp, sp, -64
    sd ra, 48(sp)
    sd s0, 40(sp) # input number
    sd s1, 32(sp) # 100
    sd s2, 24(sp)
    sd s3, 16(sp)
    sd s4, 8(sp)

    lla a0, fmt_in
    addi a1, sp, 56
    call scanf

    ld s0, 56(sp)

    li s1, 100
    li s3, 1
    li s4, 0 # loop counter
    mv s2, s0
    li t1, 10

happy_number:
    beq s2, s3, print_happy
    bge s4, s1, not_happy

    mv t0, s2
    li s2, 0
inner_loop:
    beqz t0, inner_end
    rem t2, t0, t1
    mul t2, t2, t2
    add s2, s2, t2

    div t0, t0, t1
    j inner_loop

inner_end:
    addi s4, s4, 1
    j happy_number


print_happy:
    lla a0, fmt_out
    li a1, 1
    call printf
    j end_prog

not_happy:
    lla a0, fmt_out
    li a1, 0
    call printf
    

end_prog:
    ld ra, 48(sp)
    ld s0, 40(sp)
    ld s1, 32(sp) 
    ld s2, 24(sp)
    ld s3, 16(sp)
    ld s4, 8(sp)

    addi sp, sp, 64
    li a0, 0
    ret
