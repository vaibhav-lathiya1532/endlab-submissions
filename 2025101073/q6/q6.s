.section .rodata

print_fmt:
.string "%lld\n"

scan_fmt:
.string "%s"

.section .text
.globl main

main: 

    addi sp,sp,-1024 
    sd s0,1016(sp)
    sd ra,1008(sp)

    lla a0,scan_fmt
    addi s0,sp,512
    mv a1,s0
    call scanf 

loop: 

    lb t0,0(s0)
    beqz t0,done 

    li t1,'+'
    li t2,'-'
    li t3,'*'

    beq t0,t1,add 
    beq t0,t2,sub 
    beq t0,t3,mul 

    addi t0,t0,-48
    sd t0,0(sp)
    addi sp,sp,-16
    addi s0,s0,1
    j loop 

add: 
    addi sp,sp,16 
    ld t1,0(sp) # t1 = second number 
    addi sp,sp,16
    ld t2,0(sp) # t2 = first number 
    add t3,t2,t1 
    j next 

sub: 
    addi sp,sp,16 
    ld t1,0(sp) # t1 = second number 
    addi sp,sp,16
    ld t2,0(sp) # t2 = first number 
    sub t3,t2,t1 
    j next 

mul:

    addi sp,sp,16 
    ld t1,0(sp) # t1 = second number 
    addi sp,sp,16
    ld t2,0(sp) # t2 = first number 
    mul t3,t2,t1 
    j next 

next: 

    sd t3,0(sp)
    addi sp,sp,-16
    addi s0,s0,1
    j loop 

done: 

    lla a0,print_fmt
    addi sp,sp,16
    ld a1,0(sp) 
    call printf 

    ld ra,1008(sp)
    ld s0,1016(sp)
    addi sp,sp,1024
    ret
