.data
    input_str: .asciz "%d"
    True_str: .asciz "TRUE\n"
    False_str: .asciz "FALSE\n"
    n: .word 0
    x: .word 0
.text
.globl main
main:
    addi sp,sp,-32
    sd ra,24(sp)
    sd s0,16(sp)
    sd s1,8(sp)
    sd s2,0(sp)         #array

    la a0,input_str
    la a1,n
    call scanf
    
    ld s0,n
    slli a0,s0,2
    call malloc
    mv s2,a0

    li s1,0
scan_loop:
    bge s1,s0,end_scan
    la a0,input_str
    la a1,x
    call scanf
    ld t1,x
    sd t1,0(s2)
    addi s2,s2,4
    addi s1,s1,1
    j scan_loop
end_scan:
    li t0,0
    li t1,2
    li t2,1
begin:
    beq s0,t2,print_false
    slli t2,t0,2
    add t2,s2,t2
    ld t3,0(t2)
    rem t4,t3,t1
    addi t0,t0,1
    beq t4,zero,start_even
start_odd:
    beq t0,s0,print_true
    slli t2,t0,2
    add t2,s2,t2
    ld t3,0(t2)
    rem t5,t3,t1
    beq t5,t4,print_false
    mv t4,t5
    addi t0,t0,1
    j start_odd
start_even:
    beq t0,s0,print_true
    slli t2,t0,2
    add t2,s2,t2
    ld t3,0(t2)
    rem t5,t3,t1
    beq t5,t4,print_false
    mv t4,t5
    addi t0,t0,1
    j start_even
print_true:
    la a0,True_str
    call printf
    j exit
print_false:
    la a0,False_str
    call printf
exit:
    ld ra,24(sp)
    ld s0,16(sp)
    ld s1,8(sp)
    ld s2,0(sp)
    addi sp,sp,32 
    li a0,0
    ret