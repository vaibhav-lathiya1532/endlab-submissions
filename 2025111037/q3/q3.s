.section .rodata
fmt_in:
    .asciz "%lld"
fmt_out:
    .asciz "%lld\n"
fmt_inv:
    .asciz "-1\n"

.extern scanf
.extern printf

.text
.globl main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)   #s0=n
    sd s1, 40(sp)   #s1=base address
    sd s2, 32(sp)   #s2=left sum
    sd s3, 24(sp)   #s3=right sum
    sd s4, 16(sp)   #s4=cur_idx
    sd s5, 8(sp)    #s5=result index
    sd s6, 0(sp)    #s6=total sum

    la a0, fmt_in
    mv a1, sp
    call scanf

    ld s0, 0(sp)    #s0 stores n

    li s4, 0

input_loop:
    beq s4, s0, calc_sum
    slli t0, s4, 3
    add t1, s1, t0

    la a0, fmt_in
    mv a1, t1
    call scanf

    addi s4, s4, 1 #increment idx=idx+1
    j input_loop

calc_sum:
    li s4, 0
    li s6, 0

sum_loop:
    beq s4, s0, process_loop

    slli t0, s4, 3
    add t1, s1, t0

    ld t2, 0(t1)
    add s6, s6, t2

    addi s4, s4, 1
    j sum_loop

#now s6 contains the total sum


process_loop:
    li s4, 0
    li s2, 0
    ld t0, 0(s1)
    sub s3, s6, t0

check:
    beq s4, s0, print_invalid
    beq s2, s3, print_result

    slli t0, s4, 3
    add t1, s1, t0
    ld t2, 0(t1)

    add s2, s2, t2
    
    addi s4, s4, 1

    slli t0, s4, 3
    add t1, s1, t0
    ld t2, 0(t1)

    sub s3, s3, t2
    j check


print_result:
    la a0, fmt_out
    mv a1, s4
    call printf

    j exit

print_invalid:
    la a0, fmt_inv
    call printf

exit:
    li a0, 0
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)
    ld s5, 8(sp)
    ld s6, 0(sp)
    addi sp, sp, 64
    ret


