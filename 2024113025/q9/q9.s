.section .rodata
fmt_in:
    .string "%lld"
fmt_out:
    .string "%lld\n"
.section .text
.global main

main:
    addi sp, sp, -32
    sd ra, 0(sp)
    sd s0, 8(sp) 
    sd s1, 16(sp) 
    
    addi a1, sp, 24
    la a0, fmt_in
    call scanf
    ld s0, 24(sp) #has N


    addi s1, x0, 0 #has no. of iterations
    addi t0, x0, 0 #Contains a duplicate of the number where we add squares
    addi t1, x0, 10 #always contains 10
    addi t2, x0, 0 #will be used for remainder
loop:
    addi t3, x0, 100
    bge s1, t3, not_happy
    addi s1, s1, 1
    addi t0, x0, 0
    
square_loop:
    beq s0, x0, end_sq
    rem t2, s0, t1
    div s0, s0, t1
    mul t2, t2, t2
    add t0, t0, t2
    jal x0, square_loop

end_sq:
    addi s0, t0, 0
    addi t3, x0, 1
    beq s0, t3, happy
    jal x0, loop

happy:
    la a0, fmt_out
    addi a1, x0, 1
    call printf
    jal x0, end

not_happy:
    la a0, fmt_out
    addi a1, x0, 0
    call printf
    jal x0, end

end:
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 32
    li a0, 0
    ret
