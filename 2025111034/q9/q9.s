.data
    fmt_in: .string "%lld"
    fmt_out1: .string "1"
    fmt_out0: .string "0"


.text

.globl main

main:
    addi sp , sp , -64
    sd ra , 8(sp)
    sd s0 , 16(sp)     
    sd s1 , 24(sp)    
    sd s2 , 32(sp)   
    sd s3 , 40(sp)      

    la a0 , fmt_in
    addi a1 , sp , 48
    call scanf

    li t0 , 10                                  #t0 hold 10
    li t1 , 1                                   #t1 has 1
    li t2 , 100                                 #will hold 100
    ld s0 , 48(sp)                              #s0 has n
    li s1 , 0                                   #new_num =0
    li s2 , 0                                   #count1

process:
    beq s2 , t2 , printno
    beq s0 , t1 , printyes
    addi s2 , s2 , 1

loop:
    beq s0 , x0 , preprocess
    rem t3 , s0 , t0           #t3 has the digit
    div s0 , s0 , t0
    mul t3 , t3 , t3
    add s1 , s1 , t3
    j loop 

preprocess:
    mv s0 , s1
    li s1 , 0
    j process

printno:
    la a0 , fmt_out0
    call printf
    li a0 , 0
    ld ra , 8(sp)
    ld s0 , 16(sp)     
    ld s1 , 24(sp)    
    ld s2 , 32(sp)   
    ld s3 , 40(sp)
    addi sp , sp , 64
    ret

printyes:
    la a0 , fmt_out1
    call printf
    li a0 , 0
    ld ra , 8(sp)
    ld s0 , 16(sp)     
    ld s1 , 24(sp)    
    ld s2 , 32(sp)   
    ld s3 , 40(sp)
    addi sp , sp , 64
    ret
