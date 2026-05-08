.text
.globl main

main:
    li a7,5
    ecall
    mv t0,a0

    mv  t1,t0
    li  t2,0
    li  a1,100
    li  t4,0
    li  a2,1
    li  t6,10
    
a_loop:
    beqz t2,check_one
    rem t5,t1,a3
    mul t4,t5,t5
    add t2,t2,t4
    div t1,t1,a3
    j   a_loop

check_one:
    addi t4,t4,1
    mv t1,t2
    beq t2,a2,found_one
    beq t4,a1,not_found
    j a_loop

found_one:
    mv a0,a2
    li a7,1
    ecall

    mv a0,t6
    ecall

    li a7,10
    ecall

not_found:
    li a0,0
    li a7,1
    ecall

    mv a0,t6
    ecall

    li a7,10
    ecall
    