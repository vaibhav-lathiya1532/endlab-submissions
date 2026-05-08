.section .rodata

fmt_in: .asciz("%lld")
fmt_True: .asciz("TRUE")
fmt_False: .asciz("FALSE")

.section .bss
.align 3
n_val: .skip 8
arr: .skip 800000

.text 
.globl main
main:
    lui a0 , %hi(fmt_in)
    addi a0, a0 ,%lo(fmt_in)
    lui a1 , %hi(n_val)
    addi a1 , a1 , %lo(n_val)
    call scanf

    lbu s0 , 0(n_val)
    addi t0, t0 , x0
    read_arr:
        ble s0 , t0 ,loop
        lui a0 , %hi(fmt_in)
        addi a0, a0 ,%lo(fmt_in)
        lbu a1 , n_val

