.data
input:  .asciz "%s"
output: .asciz "%lld\n"
s:  .space 105

.text
.globl main
.extern scanf
.extern printf

main:
    addi sp, sp, -1024
    sd ra, 1016(sp)

    la a0, input
    la s0, s
    addi a1, s0, 0
    call scanf
    la s0, s                    # s0 has base address

    li t0, 0                    # for loop i
loop1:
    add t1, s0, t0
    lb t2, 0(t1)                # t2 has c 
    beq t2, x0, exit
    li t3, 48                   # t3 has '0'
    li t4, 57                   # t4 has '9'
    blt t2, t3, else
    blt t4, t2, else
    addi t2, t2, -48
    addi sp, sp, -8
    sd t2, 0(sp)

    addi t0, t0, 1
    jal x0, loop1
else:
    ld t4, 0(sp)                # t4 has b
    addi sp, sp, 8
    ld t5, 0(sp)                # t5 has a
    addi sp, sp, 8
    li s1, 42                   # s1 has *
    li s2, 43                   # s2 has +
    li s3, 45                   # s3 has -
    beq t2, s1, multi
    beq t2, s2, addd
    beq t2, s3, subtr
multi:
    mul t6, t5, t4
    addi sp, sp, -8
    sd t6, 0(sp)

    addi t0, t0, 1
    jal x0, loop1
addd:
    add t6, t5, t4
    addi sp, sp, -8
    sd t6, 0(sp)

    addi t0, t0, 1
    jal x0, loop1  
subtr:
    sub t6, t5, t4
    addi sp, sp, -8
    sd t6, 0(sp)

    addi t0, t0, 1
    jal x0, loop1

exit:
    la a0, output
    ld s5, 0(sp)
    addi a1, s5, 0
    call printf
    sd s5, 0(sp);
    ld ra, 1016(sp)
    addi sp, sp, 1024
    li a0, 0
    ret 
