.section .data
    input_fmt: .asciz "%d %d"
    output_fmt: .asciz "%d "

.section .bss
    input: .space 8

.section .text
.global main
.extern printf
.extern scanf
main:
    la a0, input_fmt
    la a1, input
    call scanf

    sw s0, 0(a1) #m
    sw s1, 4(a1) #n

    li t2, 1 #starts at 1
    li t3, 0 #always 0 for reference
    blt s0, s1, keep
swap:
    mv t0, s1
    mv t1, s0
    j gcd_loop
keep:
    mv t0, s0
    mv t1, s1
gcd_loop:
    bgt t2, t0, print_fail
    rem t4, t1, t2
    beq t4, t3, print_pass
    addi t2, t2, 1
    j gcd_loop
print_fail:
    la a0, output_fmt
    li a1, 1
    call printf
print_pass:
    la a0, output_fmt
    mv a1, t2
    call printf

li t2, 1
mv t5, t0
mv t6, t1
lcm_mul:
    mul t5, t0, t2
    blt t5, t6, lcm_keep
lcm_swap:
    mv t0, t6
    mv t1, t5
    j lcm_check
lcm_keep:
    mv t0, t5
    mv t1, t6
lcm_check:
    rem t4, t6, t5
    beq t4, t3, print_lcm
    addi t2, t2, 1
    j lcm_mul
print_lcm:
    la a0, output_fmt
    mv a1, t6
    call printf
    ret
