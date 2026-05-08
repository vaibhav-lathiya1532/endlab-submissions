.section .data
input_f: .string "%lld %lld"
output_f: .string "%lld %lld\n"

a: .double 0
b: .double 0

.section .text
.globl main

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    sd s5, 8(sp)
    sd s6, 0(sp)

input:
    lla a0, input_f
    lla s0, a
    lla s1, b
    addi a1, s0, 0
    addi a2, s1, 0
    call scanf
    ld s0, 0(s0) # a
    ld s1, 0(s1) # b

prep:
    bge s0, s1, s0_big
    beq x0, x0, s1_big

s0_big:
    addi s3, s0, 0
    addi s2, s1, 0 

s1_big:
    addi s2, s0, 0
    addi s3, s1, 0

    addi s4, s2, 0 # smaller number
gcd_loop:
    bge x0, s4, lcm
    rem t0, s0, s4
    rem t1, s1, s4
    addi s4, s4, -1 # i--
    bne t0, x0, gcd_loop
    bne t1, x0, gcd_loop
    beq x0, x0, lcm

lcm:
    addi s5, s3, 0

lcm_loop:
    rem t0, s5, s0
    rem t1, s5, s1
    addi s5, s5, 1 # i++
    bne t0, x0, lcm_loop
    bne t1, x0, lcm_loop
    beq x0, x0, output

output:
    lla a0, output_f
    addi a1, s4, 1
    addi a2, s5, -1
    call printf

end:
    ld ra, 56(sp)
    ld s0, 48(sp) 
    ld s1, 40(sp) 
    ld s2, 32(sp) 
    ld s3, 24(sp) 
    ld s4, 16(sp) 
    ld s5, 8(sp) 
    ld s6, 0(sp) 
    addi sp, sp, 64
    addi a0, x0, 0
    ret
