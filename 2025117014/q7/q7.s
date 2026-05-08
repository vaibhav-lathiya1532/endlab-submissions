.data
fmtin: .string "%lld"
fmtout: .string "%s\n"
true: .string "TRUE"
false: .string "FALSE"
n: .dword 0

.text
.globl main

main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)

    la a0, fmtin
    la a1, n
    call scanf
    ld s0, n            #t6 = n
    mv t6, s0

    li t0, 0            #digit count
    li t1, 10
    
loop:
    beq t6, zero, next
    addi t0, t0, 1
    rem t2, t6, t1
    addi sp, sp, -16
    sd t2, 8(sp)
    div t6, t6, t1
    j loop

next:
    li t1, 1        #i=1
    li s1, 0        #s1 = sum

calc:
    bgt t1, t0, check
    ld t2, 8(sp)
    addi sp, sp, 16
    li t3, 0       #j=0
    li t4, 1

power:
    bge t3, t1, sum
    mul t4, t4, t2
    addi t3, t3, 1
    j power

sum:
    add s1, s1, t4
    addi t1, t1, 1
    j calc

check:
    beq s0, s1, yes
    la a1, false
    j print

yes:
    la a1, true

print:
    la a0, fmtout
    call printf

    ld s0, 8(sp)
    ld s1, 16(sp)
    ld ra, 24(sp)
    addi sp, sp, 32

    li a0, 0
    ret
