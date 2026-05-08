.data
    input: .string "%d %d"
    output: .string "%d %d"
    n1: .word 0
    n2: .word 0
.text
.globl main
.extern scanf
.extern printf
main:
    la a0, input
    lw a1, n1
    lw a2, n2
    call scanf
    li s1, 0
    li s2, 0
    li s3, 0
    li s4, 0
    li s5, 0
    li s6, 0
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0
    addi s1, a1, 0
    addi s2, a2, 0
    mv s5, s1
    mv s6, s2
    rem t0, s1, s2
    rem t1, s2, s1
    beqz t0, big1
    beqz t1, big2
    bge s1, s2, bigs1
    bge s2, s1, bigs2
big1:
    mv s3, s2
    mv s4, s1
    j print
big2:
    mv s4, s2
    mv s3, s1
    j print
bigs1:
    li t5, 1
    beq s6, t5, foundgcd11
    rem t6, s5, s6
    beqz t6, foundgcd10
    mv s6, t6
    j bigs1
bigs2:
    li t5, 1
    beq s5, t5, foundgcd21
    rem t6, s6, s5
    beqz t6, foundgcd20
    mv s5, t6
    j bigs2
foundgcd10:
    mv s3, s6
    mul s4, s1, s2
    div s4, s4, s6
    j print
foundgcd20:
    mv s3, s5
    mul s4, s1, s2
    div s4, s4, s5
    j print
foundgcd11:
    mv s3, s2
    mul s4, s1, s2 
    j print
foundgcd21:
    mv s3, s1
    mul s4, s1, s2 
    j print
print:
    la a0, output
    mv a1, s3
    mv a2, s4
    call printf
    li a0, 0
    call exit
