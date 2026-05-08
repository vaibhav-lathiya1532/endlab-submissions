.section .rodata
    input: .string "%lld"
    outputyes: .string "TRUE\n"
    outputno: .string "FALSE\n"

.section .text
.globl main

main:
    addi sp, sp, -48
    sd ra, 8(sp)
    sd s0, 16(sp)
    sd s1, 24(sp)
    sd s2, 32(sp)

    lla a0, input
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp) # n

    lla a0, input
    addi a1, sp, 0
    call scanf
    ld t0, 0(sp) # currnumber
    
    li t2, 2
    rem s1, t0, t2 # currnumber rem

    addi s0, s0, -1

loop:
    beqz s0, endyes

    lla a0, input
    addi a1, sp, 0
    call scanf
    ld t0, 0(sp) # currnumber
    
    li t2, 2
    rem s2, t0, t2 # next number rem

    addi s0, s0, -1
    beq s2, s1, no
    mv s1, s2
    
    j loop

endyes:
    lla a0, outputyes
    call printf
    addi a0, x0,0

    ld ra, 8(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    addi sp, sp, 48
    ret

no: 
# JUST to take the input after we detect it is false
    beqz s0, endno

    lla a0, input
    addi a1, sp, 0
    call scanf
    ld t0, 0(sp) # currnumber
    
    addi s0, s0, -1
    j no

endno:
    lla a0, outputno
    call printf
    
    addi a0, x0,0
    ld ra, 8(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    addi sp, sp, 48
    ret
