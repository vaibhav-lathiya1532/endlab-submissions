.data
fmtin: .string "%lld"
fmtout: .string "%s\n"
true: .string "TRUE"
false: .string "FALSE"
n: .dword 0
base: .space 800000

.text
.globl main

main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)
    sd s2, 0(sp)

    li t4, 2
    la a0, fmtin
    la a1, n
    call scanf
    ld s0, n    #s0 = n

    la s1, base  #arr ptr
    li s2, 0  #i=0

inputloop:
    bge s2, s0, next

    la a0, fmtin
    la a1, n
    call scanf
    ld s1, n

    addi s1, s1, 8
    addi s2, s2, 1
    j inputloop

next:
    li t1, 1        #i=1
    la t0, base

loop:
    bge t1, s0, yes

    slli t2, t1, 3
    add t3, t0, t2
    ld t6, 0(t3)        #t6 = a[i]

    addi t2, t1, -1
    slli t2, t2, 3
    add t3, t0, t2
    ld t2, 0(t3)       #t2 = a[i-1]

    add t5, t2, t6
    li t4, 2
    rem t5, t5, t4
    li t4, 0
    beq t5, t4, no

    addi t1, t1, 1
    j loop

yes:
    la a1, true
    j print

no:
    la a1, false

print:
    la a0, fmtout
    call printf

    ld s2, 0(sp)
    ld s1, 8(sp)
    ld s0, 16(sp)
    ld ra, 24(sp)
    addi sp, sp, 32

    li a0, 0
    ret

    


