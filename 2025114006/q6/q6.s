.extern scanf
.extern printf

.section .rodata
fmt_s:      .string "%s"
fmt_int:    .string "%lld\n"

.section .bss
expr:       .space 128

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 0(sp)
    sd s0, 8(sp)        #base ptr
    
    la a0, fmt_s
    la a1, expr
    call scanf

    la s0, expr 
    

loop:
    lb t0, 0(s0)
    beqz t0, end
    li t1, 48
    blt t0, t1, isop
    li t1, 57
    bgt t0, t1, isop

    addi t0, t0, -48
    addi sp, sp, -8
    sd t0, 0(sp)
    addi s0, s0, 1
    j loop
isop:
    ld t2, 0(sp)
    
    addi sp, sp, 8
    ld t3, 0(sp)
    
    addi sp, sp, 8

    li t4, 43
    beq t0, t4, addint
    li t4, 45
    beq t0, t4, subint
    mul t2, t2, t3
    addi sp, sp, -8
    sd t2, 0(sp)
    
    addi s0, s0, 1
    j loop
addint:
    add t2, t2, t3
    addi sp, sp, -8
    sd t2, 0(sp)
    
    addi s0, s0, 1
    j loop
subint:
    sub t2, t3, t2
    addi sp, sp, -8
    sd t2, 0(sp)
    
    addi s0, s0, 1
    j loop

end:
    la a0, fmt_int
    ld a1, 0(sp)
    call printf
    addi sp, sp, 8
    ld ra, 0(sp)
    ld s0, 8(sp) 
    addi sp, sp, 16
    ret
    