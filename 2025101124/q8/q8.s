.section .rodata 
fmt: .string "%ld" 

.section .text
.globl main 

main: 
    addi sp , sp , -16
    sd ra , 8(sp) 

    la a0 , fmt 

    mv a1 , sp 

    call scanf 

    ld s0 , 0(sp)

    mv a0 , s0 

    slli a0 , a0 , 3   # n*8 

    call malloc 

    mv s1 , a0   # s1 = pointer 

    li s2 , 0   # iterator for reading 

read: 
    bge s2 , s0 , process 

    la a0 , fmt 
    
    slli a1 , s2 , 3   # a1 = i * 8 
    add a1 , a1 , s1   # addreses
    call scanf 
    addi s2 , s2 , 1 
    j read 

process: 
    la a0 , fmt 
    mv a1 , sp 
    call scanf 
    ld s2 , 0(sp)  # s2 = target 

   li s3 , 0            # lo 
   addi s4 , s0 , -1    # hi 

loop: 
    bgt s3 , s4 , notfound 
    add s5 ,  s3 , s4   # mid 
    srli s5 , s5 , 1        

    # loading mid 
    slli t0 , s5 , 3 
    add t0 , t0 , s1 
    ld t0 , 0(t0)   # arr[mid]

    beq t0 , s2 , found 

    # loading nums[low] 
    slli t1 , s3 , 3 
    add t1 , t1 , s1 
    ld t1 , 0(t1)
 

    # loading nums[hi] 
    slli t2 , s4 , 3 
    add t2 , t2 , s1 
    ld t2 , 0(t2) 

    bge t0 , t1 , left_sorted 


right_sorted: 
    bge t0 , s2 , hi 
    bgt s2 , t2, hi 
    j lo


left_sorted:
    bge s2 , t0 , lo
    bgt t1 , s2 , lo 
    j hi 

hi:
    addi s4 , s5 , -1 
    j loop 

lo:
    addi s3 , s5 , 1 
    j loop 


found:
    la a0 , fmt 
    mv a1 , s5 
    call printf 
    ld ra , 8(sp)
    addi sp , sp , 16 
    ret 


notfound:
    la a0 , fmt 
    li a1 , -1 
    call printf 
    ld ra , 8(sp)
    addi sp , sp , 16 
    ret 


    

