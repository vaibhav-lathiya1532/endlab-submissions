.global main

.data
    scan_fmt: .string "%lld"

.text

main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)

    la a0, scan_fmt
    mv a1, sp

    call scanf
    ld s0, 0(sp)

    li s2, 0
    li s1, 0

while_i:
    bge s2, s0, while_i_end

    la a0, scan_fmt
    mv a1, sp

    call scanf
    ld t1, 0(sp)

    li t0, 1
    li t2, 2

    li t5, 1
    beq t1, t5, dont_add

    li t5, 2
    beq t1, t5, while_j_end  


while_j:
    bge t2, t1, while_j_end
    rem t3, t1, t2
    li t0, 1
    beq t3, zero, divisible
    addi t2, t2, 1
    j while_j
    
divisible:
    li t0, 0
    j while_j_end

while_j_end:
    beq t0, zero, dont_add
    add s1, s1, t1

dont_add:
    addi s2, s2, 1
    j while_i

while_i_end:

    la a0,scan_fmt
    mv a1, s1
    call printf
    
    ld ra, 40(sp)
    ld s0, 32(sp)
    ld s1, 24(sp)
    ld s2, 16(sp)
    addi sp, sp, 48

    li a0, 0
    ret