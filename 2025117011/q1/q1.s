.data
fmt_in: .asciz "%lld"
fmt_out: .asciz "%s"
fmt_out_num: .asciz "%lld "
yes: .string "TRUE\n"
no: .string "FALSE\n"
input: .space 10010
.text
.globl main
.extern printf
.extern scanf
.extern exit

main:
    addi sp, sp, -16

    la a0, fmt_in
    mv a1, sp
    call scanf
    ld s0, 0(sp)

    li s1, 0
    la s2, input

    li s6, 1

sloop:
    bge s1, s0, prep

    slli t0, s1, 3
    add s7, s2, t0 # s7 = input + s1*8

    la a0, fmt_in
    mv a1, s7
    call scanf

    addi s1, s1, 1
    j sloop

prep:
    li s3, 0
    li s4, 1

loop:
    bge s4, s0, done
    
    slli s5, s3, 3
    add s6, s5, s2
    ld s7, 0(s6)

    slli s8, s4, 3
    add s9, s8, s2
    ld s10, 0(s9)

    andi s7, s7, 1
    andi s10, s10, 1
    xor t6, s7, s10

    #la a0, fmt_out_num
    #mv a1, t6
    #call printf

    beqz t6, fail

    addi s3, s3, 1
    addi s4, s4, 1

    j loop

fail:
    li s6, 0

done:
    li t1, 0
    li t6, 1
    beq t6, s0, nofn
    beq s6, t1, nofn
    j yesfn

yesfn:
    la a0, yes
    call printf
    call exit

nofn:
    la a0, no
    call printf
    call exit 