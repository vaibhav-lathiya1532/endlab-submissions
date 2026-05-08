.data  
    input_fmt: .string "%lld"
    print_fmt: .string "%lld\n"

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

    slli a0, s0, 3
    call malloc 
    mv s1, a0 

    li s2, 0
iploop:
    bge s2, s0, end_iploop

    slli t0, s2, 3
    add t0, s1, t0

    la a0, input_fmt
    mv a1, t0 
    call scanf

    addi s2, s2, 1
    beq x0, x0, iploop
end_iploop:

    li s3, -1000001
    li s4, -1000001

    li s2, 0
loop:
    bge s2, s0, end_loop

    slli t0, s2, 3
    add t0, s1, t0 
    ld t0, 0(t0)

    blt s3, t0, moreThanMax1

    beq s3, t0, before_end_loop

    blt s4, t0, moreThanMax2

    beq x0, x0, before_end_loop
moreThanMax2:
    mv s4, t0 
    beq x0, x0, before_end_loop

moreThanMax1:
    mv s4, s3 
    mv s3, t0 

before_end_loop:
    addi s2, s2, 1
    beq x0, x0, loop 
end_loop:

    la a0, print_fmt
    mv a1, s4 
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