#perfect code

.section .rodata

fmt: .string "%lld"

.globl main
.section .text

main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s1, 16(sp)

    la a0, fmt
    addi a1, sp, 0
    call scanf
    ld s1, 0(sp)            #has initial number
    li t0, 0                #number of iterations done
    addi t1, s1, 0          #this is gonna be my sum
    li t4, 100              #iterations max
    li t5,1                 #to compare with 1 T_T
    li t6,10                #for div and rem

check:
    addi t0, t0, 1 
    beq t1,t5,happy
    beq t0, t4, unhappy
    addi s1, t1,0
    li t1,0

loop:
    beq s1,x0,check
    rem t2,s1,t6            #t2 is rem 
    div s1,s1,t6
    mul t2,t2,t2
    add t1,t1,t2
    j loop

happy:
    la a0,fmt
    addi a1, x0, 1
    call printf
    j end

unhappy:
    la a0,fmt
    addi a1, x0, 0
    call printf
    j end

end:

    ld ra, 24(sp)
    ld s1, 16(sp)
    addi sp, sp, 32
    ret
