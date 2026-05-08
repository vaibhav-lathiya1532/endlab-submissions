.section .rodata
fmt_in: .string "%100s"
# fmt_in: .string "%lld"
fmt_out: .string "%lld\n"

.section .bss
str: .zero 105

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmt_in
    la a1, str    # trying to load string ***
    # addi a1, sp, 0 # if input were an integer
    call scanf
    # ld s0, 0(sp) # if input were an integer

    ld t0, str      # string pointer ***?

read_string:
    mv t1, t0
    beqz t1, end_read
    li t2, 10
    beq t1, t2, end_read
    
    li t2, 45
    beq t1, t2, handle_add
    li t2, 43
    beq t1, t2, handle_sub
    li t2, 42
    beq t1, t2, handle_mul

    addi t1, t1, -48
    addi sp, sp, -16
    sd t1, 0(sp)
    j next_char

handle_add:
    ld t3, 0(sp)
    addi sp, sp, 16
    ld t4, 0(sp)
    addi sp, sp, 16
    add s5, t4, t3
    addi sp, sp, -16
    sd s5, 0(sp)
    j next_char

handle_sub:
    ld t3, 0(sp)
    addi sp, sp, 16
    ld t4, 0(sp)
    addi sp, sp, 16
    sub s5, t4, t3
    addi sp, sp, -16
    sd s5, 0(sp)
    j next_char

handle_mul:
    ld t3, 0(sp)
    addi sp, sp, 16
    ld t4, 0(sp)
    addi sp, sp, 16
    mul s5, t4, t3
    addi sp, sp, -16
    sd s5, 0(sp)
    j next_char

next_char:
    addi t1, t1, 1
    j read_string

end_read:
    mv a1, s5
    la a0, fmt_out
    call printf

    li a0, 0
    ld ra, 8(sp)
    addi sp, sp, 16
    ret

