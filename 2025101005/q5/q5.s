.data

fmtIn: .asciz "%lld"
fmtOut: .asciz "%lld "
fmtnl: .asciz "\n"

arr: .space 8000000

.text

.extern printf
.extern scanf
.extern exit

.global main



main:
    add sp, sp, -16

    la a0, fmtIn
    mv a1, sp
    call scanf

    ld s0, 0(sp)

    li s1, 0 #i = 0

    la s3, arr


osLoop:
    blt s1, s0, preloop

    li s2, 0 # j = 0

isLoop:
    blt s2, s0, nextIteration1

    #Adress = Base + (i*n + j)*8

    mul t0, s1, s0
    add t0, t0, s2
    slli t0, t0, 3
    add t0, t0, s3

    la a0, fmtIn
    mv a1, t0
    call scanf

    addi s2, s2, 1

    j isLoop

nextIteration1:
    addi s1, s1, 1
    j osLoop


preloop:
    li s1, 0


    

opLoop:
    blt s1, s0, end

    mv s2, s0
    addi s2, s2, -1


ipLoop:
    beq s2, x0, nextIteration2

    mul t0, s2, s0
    add t0, t0, s1
    slli t0, t0, 3
    add t0, t0, s3

    ld t1, t0

    la a0, fmtOut
    mv a1, t1
    call printf

    addi s2, s2, -1

    j ipLoop

nextIteration2:
    la a0, fmtnl
    call printf
    
    addi s1, s1, 1
    j opLoop



end:
    addi sp, sp , 16

    li a1, 0
    call exit






