.data
    input_fmt: .asciz "%d"
    output_fmt: .asciz "%d\n"
    n: .space 4
    t: .space 4
    notFound: .asciz "-1\n"

.global main
.extern scanf
.extern printf
.extern malloc

.text

main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp) 
    sd s1, 24(sp) 
    sd s2, 16(sp) 
    sd s3, 8(sp) 
    sd s4, 0(sp) 

    la a0, input_fmt
    la a1, n
    call scanf
    la t0, n
    lw s0, 0(t0)
    li s2, 0 
    li s3, 0 

    mv a0, s0
    slli a0, a0, 2
    call malloc
    mv s1, a0

input_loop:
    beq s3, s0, input_done
    mv a1, s3
    slli a1, a1, 2
    add a1, a1, s1
    la a0, input_fmt
    call scanf
    addi s3, s3, 1
    j input_loop

input_done:
    addi s3, s3, -1
    la a0, input_fmt
    la a1, t
    call scanf
    la t0, t
    lw s4, 0(t0)

search:
    blt s3, s2, not_found
    sub t1, s3, s2
    li t2, 2
    div t1, t1, t2
    add t1, t1, s2 

    mv t3, t1
    slli t3, t3, 2
    add t3, t3, s1
    lw t3, 0(t3) 

    beq t3, s4, found

    mv t4, s2
    slli t4, t4, 2
    add t4, t4, s1
    lw t4, 0(t4) 

    mv t5, s3
    slli t5, t5, 2
    add t5, t5, s1
    lw t5, 0(t5) 

check_sorted:
    bge t3, t4, left_sorted
    j right_sorted

left_sorted:
    blt s4, t4, go_right
    blt t3, s4, go_right
    j go_left

right_sorted:
    blt s4, t3, go_left
    blt t5, s4, go_left
    j go_right

go_left:
    addi s3, t1, -1
    j search

go_right:
    addi s2, t1, 1
    j search

found:
    la a0, output_fmt
    mv a1, t1
    j end

not_found:
    la a0, notFound

end:
    call printf
    li a0, 0
    ld ra, 40(sp)
    ld s0, 32(sp) 
    ld s1, 24(sp) 
    ld s2, 16(sp) 
    ld s3, 8(sp) 
    ld s4, 0(sp) 
    addi sp, sp, 48
    ret
