.data
    input_fmt: .string "%lld"
    print_fmt: .string "%lld %lld %lld %lld\n"

.text
.global main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s5, 48(sp)
    sd s4, 40(sp)
    sd s3, 32(sp)
    sd s2, 24(sp)
    sd s1, 16(sp)
    sd s0, 8(sp)

    la a0, input_fmt 
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)

    la a0, input_fmt
    addi a1, sp, 0
    call scanf 
    ld s1, 0(sp)

    sub s2, s1, s0

    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0

    li t4, 25
loop1:
    blt s2, t4, end_loop1 
    addi t0, t0, 1
    sub s2, s2, t4
    beq x0, x0, loop1 
end_loop1:

    li t4, 10
loop2:
    blt s2, t4, end_loop2
    addi t1, t1, 1
    sub s2, s2, t4
    beq x0, x0, loop2 
end_loop2: 

    li t4, 5
loop3:
    blt s2, t4, end_loop3
    addi t2, t2, 1
    sub s2, s2, t4 
    beq x0, x0, loop3
end_loop3:

    mv t3, s2 

    la a0, print_fmt
    mv a1, t0 
    mv a2, t1
    mv a3, t2
    mv a4, t3 
    call printf 

end:
    li a0, 0
    ld ra, 56(sp)
    ld s5, 48(sp)
    ld s4, 40(sp)
    ld s3, 32(sp)
    ld s2, 24(sp)
    ld s1, 16(sp)
    ld s0, 8(sp)
    addi sp, sp, 64
    ret