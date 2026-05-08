.text 
.globl main

main:
    li a7 , 5
    ecall
    mv t0 , a0 

    li a7 , 5
    ecall
    mv t1 , a0  

    # array handling
    li a7,5
    ecall 
    la t5 , a0  # t5=base adr of array

    slli t3 , t0 , 2

    sub sp , sp , t3
    sw t5 , 0(sp)  #check
    li t2 , 0 

read:
    beq t2 , t0 , read_done

    li a7 , 5
    ecall 

    slli t4 , t2 , 2
    add t3 , t4 , t5

    # how to get value  check
    sw a0 , 0(t3)
    lw t6 , 0(t3)

    addi t2 , t2 , 1
    j read


read_done:
    li a1, 0
    addi , a2 , t0 , -1
    li a6 , 0

loop:
    bgt a1 , a2 , traversed

    slli t4 , a1 , 2
    add t3 , t4 , t5
    lw a3 , 0(t3)

    slli t4 , a2 , 2
    add t6 , t4 , t5
    lw a4 , 0(t6)

    add a5 , a3 , a4 
    bgt a5 , t1 , right_dec

    j both


right_dec:
    addi a2, a2, -1
    addi a6 , a6 , 1
    j read_done 

both:
    addi a1 , a1 , 1
    addi a2, a2, -1 
    addi a6 , a6 ,1
    j read_done

traversed:
    mv a0 , a6
    li a7 , 1
    ecall
    
    li a7 , 10
    ecall
