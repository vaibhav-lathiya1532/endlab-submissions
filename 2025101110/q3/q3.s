.section .data
fmt: .asciz "%lld"
fmt_out: .asciz "%lld\n"
n: .quad 0
arr: .space 8000

.section .text
.globl main

main:
addi sp,sp,-16
sd ra,0(sp)

la a0,fmt
la a1,n 
call scanf

li s0,0
ld s1,n 
la s2,arr
read_arr:
    bge s0,s1,input_done
    slli t0,s0,3
    add t0,t0, s2
    la a0,fmt
    mv a1,t0
    call scanf
    addi s0,s0,1
    j read_arr

input_done:
    li s0,0
    li s3,0
    outerloop:
        bge s0,s1,outerloop_done
        li t0,1
        li t1,2
        slli t2,s0,3
        add t2,t2,s2
        ld t3,0(t2)
        inner_loop:
            bge t1,t3,check_prime
            rem t4,t3,t1
            bne t4,x0,continue
            addi t0,x0,0
            continue:
            addi t1,t1,1
            j inner_loop
        
        check_prime:
            li t5,1
            beq t3,t5,continue_outer
            beq t0,x0,continue_outer
            add s3,s3,t3
        
        continue_outer:
            addi s0,s0,1
            j outerloop

outerloop_done:
la a0,fmt_out
mv a1,s3
call printf

ld ra,0(sp)
addi sp,sp,16
li a0,0
ret
