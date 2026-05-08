.data
    input_fmt: .asciz "%d %d"
    in_fmt: .asciz "%d"
    output_fmt: .asciz "%d\n"
    n: .space 4
    l: .space 4

.global main
.extern scanf
.extern printf
.extern malloc

.text

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp) 
    sd s1, 40(sp) 
    sd s2, 32(sp)
    sd s3, 24(sp) 
    sd s4, 16(sp) 
    sd s5, 8(sp) 

    la a0, input_fmt
    la a1, n
    la a2, l
    call scanf
    la t0, n
    lw s0, 0(t0)
    la t1, l
    lw s4, 0(t1)

    mv a0, s0
    slli a0, a0, 2
    call malloc
    mv s1, a0

    li s3, 0

input_loop:
    beq s3, s0, input_done
    mv a1, s3
    slli a1, a1, 2
    add a1, a1, s1
    la a0, in_fmt
    call scanf
    addi s3, s3, 1

input_done:
    mv s3, s0
    addi s3, s3, -1
    li s2, 0
    li s5, 0
    j loop

loop:
    beq s2, s3, last_count
    blt s3, s2, end

    mv t0, s2
    slli t0, t0, 2
    add t0, t0, s1
    lw t0, 0(t0) 

    mv t1, s3
    slli t1, t1, 2
    add t1, t1, s1
    lw t1, 0(t1)

    add t2, t0, t1
    bge s4, t2, pair_up
    addi s3, s3, -1
    addi s5, s5, 1
    j loop

pair_up:
    addi s2, s2, 1
    addi s3, s3, -1
    addi s5, s5, 1
    j loop

last_count:
    addi s5, s5, 1

end:
    la a0, output_fmt
    mv a1, s5
    call printf

    li a0, 0
    ld ra, 56(sp)
    ld s0, 48(sp) 
    ld s1, 40(sp)
    ld s2, 32(sp) 
    ld s3, 24(sp)  
    ld s4, 16(sp) 
    ld s5, 8(sp) 
    addi sp, sp, 64
    ret
