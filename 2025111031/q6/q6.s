.section .rodata
output_string:
.asciz "%lld\n"
input_string:
    .asciz "%s"
.section .bss
array:
    .space 1000000
    
.section .text

.globl main

add1:
    ld s4, 0(sp)
    ld s3, 8(sp)
    add s3, s3, s4
    addi sp, sp, 8
    sd s3, 0(sp)
    j next  
   

sub1:
    ld s4, 0(sp)
    ld s3, 8(sp)
    sub s3, s3, s4
    addi sp, sp, 8
    sd s3, 0(sp)
    j next

mult:
    ld s4, 0(sp)
    ld s3, 8(sp)
    mul s3, s3, s4
    addi sp, sp, 8
    sd s3, 0(sp)
    j next

main:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)
    sd s6, 56(sp)
    lla a0, input_string
    lla a1, array
    call scanf
   
    li s2, 0                    #counter

loop:
    lla s1, array               #starting of string
    add s5, s2, s1              #go to address
    lbu s5, 0(s5)               #load the byte
    beqz s5, over               #finish the execution
    li t1, '+'
    beq s5, t1, add1
    li t1, '-'
    beq s5, t1, sub1
    li t1, '*'
    beq s5, t1, mult
    li t1, '0'
    sub s5, s5, t1
    addi sp, sp, -8
    sd s5, 0(sp)
next:
    addi s2, s2, 1
    j loop
over:
    ld a1, 0(sp)
    mv s1, a1
    addi sp, sp, 8
    lla a0, output_string
    call printf
    mv a0, s1
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    addi sp, sp, 64
    ret

    
    



