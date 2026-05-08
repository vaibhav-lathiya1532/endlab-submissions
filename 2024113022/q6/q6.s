.section .data
in: .asciz "%s"
out: .asciz "%lld\n"
str: .space 10000

.section .text
.globl main
main:
    addi sp, sp, -64
    sd s0, 56(sp)
    sd ra, 48(sp)
    la a0, in
    la a1, str
    call scanf
    
    la t0, str
    mv s0, sp
    
loop:
    ld t1, 0(t0)        #t1-> current element 
    beqz t1, print
    li t2, '0'          #t2-> char 0
    li t3, '9'          #t3-> char 9
    blt t1, t2, op
    bgt t1, t3, op

    addi t1, t1, -48
    addi s0, s0, -8
    sd t1, 0(s0)
    addi t0, t0, 1
    j loop

op:
    ld t2, 0(s0)
    addi s0, s0, 8
    ld t3, 0(s0)
    addi s0, s0, 8

    li t4, '+'
    beq t1, t4, addop
    li t4, '-'
    beq t1, t4, subop

    mul t5, t3, t2
    j push

addop:
    add t5, t3, t2
    j push

subop:
    sub t5, t3, t2
    j push

push:
    addi s0, s0, -8
    sd t5, 0(s0)
    addi t0, t0, 1
    j loop

print:
    la a0, out
    ld a1, 0(s0)
    call printf
    j end

end:
    ld ra, 48(sp)
    ld s0, 56(sp)
    addi sp, sp, 64
    li a0, 0
    ret
