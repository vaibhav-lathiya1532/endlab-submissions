.data
    fmt_in: .string "%lld "
    fmt_out: .string "%lld"
    fmt_outno: .string "-1"

.bss
    buffer: .space 100
.text

.globl main

main:
    addi sp , sp , -64
    sd ra , 8(sp)
    sd s0 , 16(sp)     
    sd s1 , 24(sp) 
    sd s2 , 32(sp)       
    sd s3 , 40(sp)
    sd s5 , 56(sp)
    sd s6 , 64(sp)

    la a0 , fmt_in
    addi a1 , sp , 48
    call scanf

    ld s0 , 48(sp)     #s0 has n
    addi s0 , s0 , -1
    mv s1 , s0  #s1 has n
    li s2 , 0   # was for arr[i]
    li s3 , 0    #s3 is sum  

input_loop:
    beq s1 , x0 , process
    addi s1 , s1 , -1

    la a0 , fmt_in
    addi a1 , sp , 48
    call scanf

    ld t0 , 48(sp)     #s0 has n
    add s3 , s3 , t0

    la s5 , buffer
    li t0 , 8
    mul t1 , s2 , t0
    add s5 , s5 , t1
    sd s3 , 0(s5)

    addi s2 , s2 , 1
    j input_loop

process:
    li s2 , 0
    mv s1 , s0
    

loop:
    beq s1 , x0 , no
    addi s1 , s1 , -1

    la s5 , buffer
    li t0 , 8
    mul t1 , s2 , t0
    add s5 , s5 , t1

    ld t4 , 0(s5)

    la s5 , buffer
    sub s6 , s0 , s2
    mul t6 , s6 , t0
    add s5 , s5 , s6 

    ld t3 , 0(s5)
    
    sub  t4 , s3 , t4
    beq  t3 , t4 , yes
    addi s2 , s2 , 1
    j loop

yes:
    mv a1 , s2
    la a0 , fmt_out
    call printf

    ld ra , 8(sp)
    ld s0 , 16(sp)     
    ld s1 , 24(sp) 
    ld s2 , 32(sp)       
    ld s3 , 40(sp)
    ld s5 , 56(sp)
    addi sp , sp , 64
    
    ret

no:
    la a0 , fmt_outno
    call printf

    ld ra , 8(sp)
    ld s0 , 16(sp)     
    ld s1 , 24(sp) 
    ld s2 , 32(sp)       
    ld s3 , 40(sp)
    ld s5 , 56(sp)
    ld s6 , 64(sp)
    addi sp , sp , 64

    ret






    
        
