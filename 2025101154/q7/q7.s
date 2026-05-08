.data
    fmt_str: .asciz "%d"
    True_str: .asciz "TRUE\n"
    False_str: .asciz "FALSE\n"
    n: .word 0
.text
.globl main
main:
    addi sp,sp,-16
    sd ra,8(sp)

    la a0,fmt_str
    la a1,n
    call scanf

    lw s0,n
    addi s3,s0,0
    addi s4,s0,0
    li s1,0
    li s2,10
count_loop:
    beq s3,zero,end_count
    addi s1,s1,1
    div t0,s3,s2
    mv s3,t0
    j count_loop
end_count:
    mv t1,s1
    addi s5,s1,0
    li s1,0
sum_calc:
    beq t1,zero,compare_result
    rem t0,s4,s2
    addi t2,t1,0
    li t3,1
    addi t4,t0,0
power_loop:
    beq t3,t2,end_power
    mul t4,t4,t0
    addi t3,t3,1
    j power_loop
end_power:
    add s1,s1,t4
    addi t1,t1,-1
    div s4,s4,s2
    j sum_calc
compare_result:
    beq s1,s0,print_true
print_false:
    la a0,False_str
    call printf
    j exit
print_true:
    la a0,True_str
    call printf
exit:
    ld ra,8(sp)
    addi sp,sp,16
    li a0,0
    ret
