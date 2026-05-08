.data
in_fmt: .string"%lld "
out_fmt: .string"%lld"

N: .dword 0
L: .dword 0
arr: .space 200

.text 
.global_main
main:
    addi sp, sp, 32
    sd ra, 24(sp)

    la a0, in_fmt
    la a1, N 
    la a2, L 
    call scanf

    ld t0, N 
    ld t1, L 

    li t3, 0

    