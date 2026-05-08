.section .data
input_f: .string "%lld"
output_f: .string "%lld\n"

n: .double 0
t: .double 0

.section .text
.globl main

main:
    addi sp, sp, -96
    sd s7, 64(sp)
    sd s8, 72(sp)
    sd s9, 80(sp)
    sd s10, 88(sp)
    sd ra, 56(sp)
    sd s0, 48(sp) 
    sd s1, 40(sp) 
    sd s2, 32(sp) 
    sd s3, 24(sp) 
    sd s4, 16(sp) 
    sd s5, 8(sp) 
    sd s6, 0(sp)

input:
    lla s0, input_f
    addi a0, s0, 0
    lla s1, n
    addi a1, s1, 0
    call scanf
    ld s1, 0(s1) # n
    slli a0, s1, 3
    call malloc
    addi s2, a0, 0 
    addi s3, s2, 0 # copy
    addi s4, x0, 0

input_loop:
    beq s4, s1, input_tar
    addi a0, s0, 0
    addi a1, s2, 0
    call scanf
    addi s2, s2, 8 
    addi s4, s4, 1
    beq x0, x0, input_loop

input_tar:
    addi s2, s3, 0  # restore
    addi a0, s0, 0
    lla s4, t
    addi a1, s4, 0
    call scanf
    ld s4, 0(s4) # target

input_end:
    addi s6, s1, -1 # n
    addi s7, x0, 0 # leftmost index
    add s9, s7, s6 # rightmost index
    beq x0, x0, main_loop

main_loop:
    blt s9, s7, not_found # if left >= right, return
    add t0, s7, s9
    srli s8, t0, 1 # middle
    slli t0, s8, 3
    add t0, s2, t0
    ld t1, 0(t0) # middle val
    slli t0, s7, 3
    add t0, s2, t0
    ld t2, 0(t0) # left val
    slli t0, s9, 3
    add t0, s2, t0
    ld t3, 0(t0) # right val
    beq t1, s4, found # if middle == target, found

compare:
    bge t1, t2, cor_left # if middle > left, we should check left first
    beq x0, x0, cor_right
    
cor_right:
    bge t1, s4, in_left # if mid >= target, target not in right. check incorrect left
    blt t3, s4, in_right # if target > rightmost, target not in right
    addi s7, s8, 1
    beq x0, x0, main_loop

cor_left:
    bge s4, t1, in_right # if mid <= target, target not in left. check incorrect right
    blt s4, t2, in_right # if target < leftmost, target not in left
    addi s9, s8, -1
    beq x0, x0, main_loop

in_right:
    addi s7, s8, 1
    beq x0, x0, main_loop

in_left:
    addi s9, s8, -1
    beq x0, x0, main_loop

not_found:
    addi s10, x0, -1
    beq x0, x0, output

found:
    addi s10, s8, 0

output:
    lla a0, output_f
    addi a1, s10, 0
    call printf

end:
    ld s7, 64(sp)
    ld s8, 72(sp)
    ld s9, 80(sp)
    ld s10, 88(sp)
    ld ra, 56(sp)
    ld s0, 48(sp) 
    ld s1, 40(sp) 
    ld s2, 32(sp) 
    ld s3, 24(sp) 
    ld s4, 16(sp) 
    ld s5, 8(sp) 
    ld s6, 0(sp)
    addi sp, sp, 96
    addi a0, x0, 0
    ret
