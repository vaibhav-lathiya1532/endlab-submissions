.section .rodata 
fmt: .string "%ld" 
fmt_out: .string "%ld %ld" 

.section .text 
.globl main 

main: 
    addi sp , sp, -16
    sd ra , 8(sp)

    la a0 , fmt 
    mv a1 , sp 
    call scanf   
    ld s0 , 0(sp) 

    la a0 , fmt 
    mv a1 , sp 
    call scanf 
    ld s1 , 0(sp) 

    bge s0 , s1 , case1 
    j case2 

case1:  # s0 >= s1 

    li s2 , 1   # iterator 
    mv s3 , s1  # limit 
    j loop 

case2: # s1 > s0 

    li s2 , 1 
    mv s3 , s0  


loop:
    bgt s2 , s3 , process 
    rem t0 , s0 , s2 
    
    bne t0 , x0 , incrementor 

    rem t0 , s1 , s2 

    bne t0 , x0 , incrementor

    mv s4 , s2 
    addi s2 , s2 , 1 
    j loop 


incrementor: 
    addi s2 , s2 , 1 
    j loop     

process:  # now s4 has gcd 
    bge s0 , s1 , first 
    j second 


first:  # s0 >= s1 

    mv s2 , s0    # bigger no is iterator now 
    mv s6 , s0 


second: 

    mv s2 , s1 
    mv s6 , s1 

lcm:  # s2 has bigger number 

    rem t0 , s2 , s0 
    bne t0 , x0 , increase 

    rem t0 , s2 , s1 
    bne t0 , x0 , increase 

    mv s5 , s2  
    j done 

increase: 
    add s2 , s2 , s6 
    j lcm  


done: 
    la a0 , fmt_out
    mv a1 , s4 
    mv a2 , s5 
    call printf 
    ld ra , 8(sp) 
    addi sp , sp , 16 
    ret  








