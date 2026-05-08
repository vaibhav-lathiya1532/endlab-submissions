.section data
    fmt_in : .asciz "%ld"
    fmt_number: .asciz "%ld "
    fmt_out: .asciz "%ld"
    n: .dword 0
    x: .dword 0

.globl main
.section .text
main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s0,48(sp)    
    sd s1,40(sp)    
    sd s2,32(sp)    
    sd s3,24(sp)    
    sd s4,16(sp)    
    sd s5,8(sp)     

    la a0,fmt_in
    la a1,n
    call scanf

    la t0,n
    sd s0,0(t0)
    li s1,0
    li s4,0

read_and_do:
    addi t1,s0,-1
    beq s1,t0,done
    addi s1,s1,1
    la a0,fmt_number
    la a1,x
    call scanf

    la t0,x
    sd s2,0(t0)
    mv s3,s2
    li s5,2

function:
    mv s3,s2
    beq s5,s2,success
    rem t2,s3,s5
    beqz t2,read_and_do
    addi s5,s5,1
    j function

success:
    add s4,s4,s2
    j read_and_do

done:
    la a0,fmt_out
    mv a1,s4
    call printf

    ld ra,56(sp)
    ld s0,48(sp)    
    ld s1,40(sp)    
    ld s2,32(sp)    
    ld s3,24(sp)    
    ld s4,16(sp)    
    ld s5,8(sp)

    li a0,0
    ret






