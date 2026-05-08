.section .rodata
fmt_in:
    .asciz "%lld"
fmt_out:
    .asciz "%lld\n"



.section .text
.globl main
.extern scanf
.extern printf
.extern malloc
.extern free

main:
    addi sp,sp,-80
    sd ra,72(sp)
    sd s0,64(sp)
    sd s1,56(sp)
    sd s2,48(sp)

    la a0,fmt_in
    addi a1,sp,0
    call scanf

    ld t0,0(sp)  #N
    mv s0,t0   #N

    slli a0,t0,3 
    call malloc

    la t6,a0  #save malloc pointer
    la s1,sp  #save sp
    li t0,0   #indexx
    li t5,0  #full count, coutn as you input

inputt:
    bge t0,s0,input_done
    la t1,t6
    slli t2,t0,3
    add t1,t1,t2
    la a0,fmt_in
    mv a1,t1
    call scanf


    # aadd t1,t1,t2
    ld t3,t1
    add t5,t5,t3
    addi t0,t0,1
    j inputt

input_done:
    li t3,0  #MOVING, ITERATING initially at 0 index
    li t4,0 #left count
    la t1,t6

    ld t2,t1
    sub t5,t5,t2 #t5 is the right count


#t0 t1 freeeee to use
start_iter:
    beq t3,s0, not_found
    beq t4,t5,done 
    slli t6,t3,3
    la t1,t6
    add t1,t1,t6
    ld t0,t1
    add t4,t4,t0
    sub t5,t5,t0
    j start_iter

done:
    la a0,fmt_out
    mv a1,t3
    call printf
    j end

not_found:
    li t3,-1
    la a0,fmt_out
    mv a1,t3
    call printf


end:
    la a0,t6
    call free
    ld ra,72(sp)
    ld s0,64(sp)
    ld s1,56(sp)
    ld s2,48(sp)
    addi sp,sp,80
    li a0,0
    ret

    

