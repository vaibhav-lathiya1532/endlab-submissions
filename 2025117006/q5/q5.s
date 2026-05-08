.data
intfmt: .string "%d"
intpfmt: .string "%d "
newline: .string "\n"
arr: .space 4000000
debug: .string "DEBUG\n"
.text
.global main

main:
    addi sp,sp,-80

    sd ra,72(sp)
    sd s0,64(sp)
    sd s1,56(sp)
    sd s2,48(sp)
    sd s3,40(sp)
    sd s4,32(sp)
    sd s5,24(sp)
    

    la a0,intfmt
    mv a1,sp
    call scanf

    lw s0,0(sp)

    li s1,0
    li s2,0

oi:
    bge s1,s0,id
    mv s2,x0
    j ii


ii:
    bge s2,s0,nexti

    mul t0,s1,s0
    add t0,t0,s2
    slli t0,t0,2

    la t1,arr
    add t1,t1,t0

    la a0,intfmt
    mv a1,t1
    call scanf

    addi s2,s2,1
    j ii

nexti:
    addi s1,s1,1
    j oi

id:
    mv s1,x0
    mv s2,x0  

roto:
    bge s1,s0,pd
    mv s2,x0
    j roti

roti:
    bge s2,s0,nextr

    mul t0,s1,s0
    add t0,t0,s2
    

    slli t0,t0,2

    la t1,arr
    add t1,t1,t0

    mv t0,t1

    mv t1,s1
  

    mv s4,s2
    sub s4,s0,s4
    addi s4,s4,-1
    
    mul t3,s4,s0

    add t1,t1,t3
    
    slli t1,t1,2

    la t2,arr
    
    add t1,t1,t2
    

    lw t2,0(t0)
    lw t3,0(t1)

    mv s3,t3
    la a0,intpfmt
    mv a1,s3
    call printf
    addi s2,s2,1
    j roti

nextr:
    addi s1,s1,1
    la a0,newline
    call printf
    j roto

rotd:
    mv s1,x0
    mv s2,x0
    

po:
    bge s1,s0,pd
    mv s2,x0
    j pi

pi:
    bge s2,s0,nextp

    mul t0,s1,s0
    add t0,t0,s2
    slli t0,t0,2

    la t1,arr
    add t1,t1,t0

    la a0,intpfmt
    lw a1,0(t1)
    call printf

    addi s2,s2,1
    j pi

nextp:
    addi s1,s1,1
    la a0,newline
    call printf
    j po

pd:

    ld s0,64(sp)
    ld ra,72(sp)
    ld s1,56(sp)
    ld s2,48(sp)
    ld s3,40(sp)
    ld s4,32(sp)
    ld s5,24(sp)

    addi sp,sp,80

    ret



