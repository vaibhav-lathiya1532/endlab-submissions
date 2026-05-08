.globl main
.extern printf
.extern scanf
.extern malloc
.extern free

.section .bss
input: .space 8

.section .data
    fmt_in: .asciz "%ld"
    TRUE: .asciz "TRUE\n"
    FALSE: .asciz "FALSE\n"

.section .text
main:
    addi sp, sp, -64
    sd ra, 8(sp) 
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s0, 48(sp) 
    sd s1, 56(sp) 


    la a0, fmt_in
    la a1, input

    call scanf
    la t0, input
    ld s0,0(t0)

    mv t0,s0
    slli t0,t0,3
    mv a0,t0
    call malloc

    mv s1,a0 #s1 has base pointer

    li s2,0 #s2 has i

read_loop:
    bge s2, s0, end_loop
    mv t0, s2
    slli t0,t0,3 
    add a1,s1,t0
    la a0,fmt_in
    call scanf
    addi s2,s2,1
    j read_loop
end_loop:


li s2,0 #s1 has i
li s3,1 #s3 has flag
li s4,-1 #s4 has curr

parity_loop:
    bge s2, s0, end_parity
    mv t0, s2 #t0 has i
    slli t0,t0,3 #t0 has i*offset
    add t1,s1,t0 #t1 has base address
    ld t2, 0(t1) #t2 has M[i]

    li t6,2
    rem t3,t2,t6 #t3 has curr1
    beq t3,s4,invalid_array
    mv s4,t3
    addi s2,s2,1
    j parity_loop

invalid_array:
    li s3,0    
end_parity:

li t5,0
beq s3,t5,oops 
la a0,TRUE
call printf
j end

oops:
la a0,FALSE
call printf

end:
    ld ra, 8(sp) 
    ld s2, 16(sp) 
    ld s3, 24(sp) 
    ld s4, 32(sp) 
    ld s5, 40(sp) 
    ld s0, 48(sp) 
    ld s1, 56(sp) 
    addi sp,sp,64
ret
