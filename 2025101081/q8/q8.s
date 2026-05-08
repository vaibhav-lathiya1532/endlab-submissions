.section .data
fmt_in: .string "%lld"
fmt_neg: .string "-1/n"
fmt_out: .string "%lld\n"

.section .bss
.align 3
N_input: .space 8
input: .space 800000

.section .text
.globl main

main:
addi sp, sp, -80
sd ra, 72(sp)
sd s0, 64(sp) # N 
sd s1, 56(sp) # left
sd s2, 48(sp) # right
sd s3, 40(sp) # mid
sd s4, 32(sp) # arr 
