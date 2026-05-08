.section .bss
    arr: .space 8000000

.section .rodata
    with_space: .string "%lld "
    newline: .string "\n"
    without_space: .string "%lld"

.section .text

.globl main
.extern printf
.extern scanf

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)

    lla a0, without_space
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)                # s0=n
    lla s1, arr                 # s1=base address
    li s2, 0

read_outer:
    bge s2, s0, transpose        #transpose changed
    li s3, 0

read_inner:
    bge s3, s0, inc_read_outer

    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add a1, s1, t0
    lla a0, without_space           # with/without ?
    call scanf

    addi s3, s3, 1
    j read_inner

inc_read_outer:
    addi s2, s2, 1
    j read_outer



transpose:
    li s2, 0
    li s3, 0

transpose_outer:
    bge s2, s0, reversing
    addi s3, s2, 1

transpose_inner:
    bge s3, s0, inc_transpose

    #A[i][j]=s1+8(s2.s0 + s3)
    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, t0, s1
    ld t5, 0(t0)        #t5=A[i][j]

    #A[j][i]=s1+8(s3.s0 + s2)
    mul t1, s3, s0
    add t1, t1, s2
    slli t1, t1, 3
    add t1, t1, s1
    ld t6, 0(t1)        #t6=A[j][i]

    sd t5, 0(t1)
    sd t6, 0(t0)

    addi s3, s3, 1
    j transpose_inner

inc_transpose:
    addi s2, s2, 1
    j transpose_outer



reversing:
    li s2, 0
    li s3, 0

reverse_outer:
    bge s2, s0, printing
    li t0, 0
    addi t1, s0, -1

reverse_inner:
    bge t0, t1, inc_reverse         # bge or bgt

    mul t2, s2, s0
    add t2, t2, t0
    slli t2, t2, 3
    add t2, t2, s1
    ld t5, 0(t2)        #t5

    mul t3, s2, s0
    add t3, t3, t1
    slli t3, t3, 3
    add t3, t3, s1
    ld t6, 0(t3)        #t6

    sd t5, 0(t3)
    sd t6, 0(t2)

    addi t0, t0, 1
    addi t1, t1, -1
    j reverse_inner

inc_reverse:
    addi s2, s2, 1
    j reverse_outer

printing:
    li s2, 0
    li s3, 0
    addi s4, s0, -1

print_outer:
    bge s2, s0, end
    li s3, 0


print_inner:
    bge s3, s4, inc_print

    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, s1, t0
    ld a1, 0(t0)
    lla a0, with_space         
    call printf

    addi s3, s3, 1
    j print_inner

inc_print:

    mul t0, s2, s0
    add t0, t0, s3
    slli t0, t0, 3
    add t0, s1, t0
    ld a1, 0(t0)
    lla a0, without_space          
    call printf

    lla a0, newline
    call printf

    addi s2, s2, 1
    j print_outer

end:

    ld ra, 56(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    addi sp, sp, 64

    li a0, 0
    ret
