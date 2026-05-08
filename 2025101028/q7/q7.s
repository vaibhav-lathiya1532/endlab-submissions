.data

input: .string "%d"
true:  .asciz "TRUE\n"
false:  .asciz "FALSE\n"
n: .word 0
.text
.globl main

main:
    
    addi sp,sp,-16
    sd ra,8(sp)

    la a0,input
    la a1,n
    call scanf

    lw t0,n
    mv t1,t0

    li t2,0

count_loop:
    
    beqz t1,count_done

    li t3,10
    div t1,t1,t3
      
    addi t2,t2,1

    j count_loop

count_done:
    
    mv t1,t0
    mv t3,t2
    li t4,0

digit_loop:
     
     beqz t3,check

     li t5,10

     rem t6,t1,t5
     div t1,t1,t5


    li t5,1
    mv t2,t3

ans: 
    
    beqz t2,ans_end
    mul t5,t5,t6
    add t4,t4,t5

    addi t2,t2,-1

    j ans

ans_end:
    
    addi t3,t3,-1
    j digit_loop

check:
    
    bne t4,t0,disarium 
    la a0,true
    call printf
    j exit

 disarium:
    la a0,false
    call printf 

exit:
     ld ra,8(sp)
     addi sp,sp,16

     ret
