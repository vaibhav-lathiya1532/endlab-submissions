.section .data
infmt : .asciz "%lld"
outfmt : .asciz "%lld\n"
num : .dword 0
max : .dword 0
.section .text
.globl main
.extern printf
.extern scanf
.extern malloc
main:
    addi sp, sp, -16
    sd ra, 8(sp)
    la a0, infmt
    la a1, num
    call scanf
    la t0, num
    ld s0, 0(t0)
    la a0, infmt                #s0--------->num
    la a1, max
    call scanf
    la t0, max
    ld s1, 0(t0)                #s1--------->maximum weight
    li s2, 0                    #s2--------->index count
    slli t0, s0, 3
    mv a0, t0
    call malloc
    mv s3, a0                   #s3--------->array pointer pointing to first element
    mv s4, s3                   #copy of pointer
input_loop:
    bge s2, s0, next
    la a0, infmt
    mv a1, s4
    call scanf
    addi s4, s4, 8
    addi s2, s2, 1
    j input_loop
next:
    li s2, 0                #index count again set to 0
    li s4, 0                #no of capsules
    li s5, 0
    addi s6, s0, -1

capsules:
    beq s5, s6, endd
    blt s6, s5, end
    mv t0, s5
    slli t0, t0, 3
    add t0, t0, s3
    ld t2, 0(t0)            #t2 --- > s5th element
    mv t1, s6
    slli t1, t1, 3
    add t1, t1, s3
    ld t3, 0(t1)                #t3 has s6yh elementg

    add s7, t2, t3
    blt s1, s7, decrement
    addi s5, s5, 1
    addi s6, s6, -1
    addi s4, s4, 1
    j capsules
decrement:
    addi s4, s4, 1
    addi s6, s6, -1
    j capsules
endd:
    addi s4, s4, 1
end:
    la a0, outfmt
    mv a1, s4
    call printf
    ld ra, 8(sp)
    addi sp, sp, 16
    li a0, 0
    ret

