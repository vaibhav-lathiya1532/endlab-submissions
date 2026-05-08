.section .rodata
fmt_in:
    .asciz "%lld"
fmt_out:
    .asciz "%lld\n"

.section .text
.globl main
.extern printf
.extern scanf

main:
    addi sp,sp,-80
    sd ra,72(sp)
    sd s0,64(sp)

    la a0,fmt_in
    addi a1,sp,0
    call scanf

    ld t0,0(sp) #number
    li t4,0  #TEMP
    li t6,0 #iterations

outer_loop:
    li t5,100
    bge t6,t5,done
    li t5,1
    beq t0,t5,done

inner_loop:
    li t5,0
    beq t0,t5,next
    li t5,10
    rem t1,t0,t5
    mul t1,t1,t1
    add t4,t4,t1
    div t0,t0,t5
    j inner_loop

next:
    mv t0,t4
    addi t6,t6,1
    li t4,0
    j outer_loop

done:
    li t4,1
    beq t0,t4,print_ans
    li t4,0
    


print_ans:
    la a0,fmt_out
    mv a1,t4
    call printf

    
    ld ra,72(sp)
    ld s0,64(sp)
    addi sp,sp,80
    li a0,0  
    ret
