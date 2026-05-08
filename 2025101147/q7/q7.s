.section .rodata
fmt_in: .string "%lld"
true_string: .string "TRUE\n"
false_string: .string "FALSE\n"

.section .text 
.globl main 

main:
    addi sp,sp,-48
    sd ra,40(sp)
    sd s0,32(sp) #number
    sd s1,24(sp)  #no.of digits
    sd s2,16(sp)    #sum
    sd s3,8(sp)
    sd s4,0(sp)

    addi a1,sp,-8
    addi sp,sp,-8
    la a0,fmt_in
    call scanf

    ld s0,0(sp)
    addi sp,sp,8

    li s1,0
    mv t0,s0

digit_count:
    beqz t0,count_done
    li t1,10
    div t0,t0,t1
    addi s1,s1,1
    j digit_count

count_done:
    mv t0,s0
    li s2,0

sum:
    beqz t0,sum_done
    li t1,10
    rem t2,t0,t1
    mv t3,s1
    li t4,1

power:
    beqz t3,power_done
    mul t4,t4,t2
    addi t3,t3,-1
    j power

power_done:
    add s2,s2,t4
    li t1,10
    div t0,t0,t1
    addi s1,s1,-1
    j sum

sum_done:
    beq s2,s0,true
    bne s2,s0,false

true:
    la a0,true_string
    call printf
    j done 

false:
    la a0,false_string
    call printf
    j done

done:
    ld ra,40(sp)
    ld s0,32(sp) #number
    ld s1,24(sp)  #no.of digits
    ld s2,16(sp)    #sum
    ld s3,8(sp)
    ld s4,0(sp)

    addi sp,sp,48

    li a0,0
    ret

    


