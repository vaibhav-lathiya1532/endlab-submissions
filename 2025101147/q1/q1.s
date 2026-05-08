.section .rodata
fmt_in: .string "%lld"
true_string: .string "TRUE\n"
false_string: .string "FALSE\n"

.section .bss 
.align 8
arr: .space 800008

.section .text 
.globl main 

main:
    addi sp,sp,-48
    sd ra,40(sp)
    sd s0,32(sp) #number
    sd s1,24(sp)  #iterator
    sd s2,16(sp)  #address
    sd s3,8(sp)   #odd or even
    sd s4,0(sp)

    addi a1,sp,-8
    addi sp,sp,-8
    la a0,fmt_in
    call scanf

    ld s0,0(sp)
    addi sp,sp,8

    li s1,0
    la s2,arr

read:
    beq s1,s0,read_done
    li t0,8
    mul t1,s1,t0
    add t1,t1,s2

    mv a1,t1
    la a0,fmt_in
    call scanf
    addi s1,s1,1
    j read

read_done:
    li s1,0

    li t0,8
    mul t1,s1,t0
    add t1,t1,s2
    
    ld t2,0(t1)
    li t0,2
    rem t4,t2,t0

    addi s1,s1,1

    li t0,0
    beq t4,t0,odd

    li t0,1
    beq t4,t0,even

even:
    beq s1,s0,true

    li t0,8
    mul t1,s1,t0
    add t1,t1,s2
    
    ld t2,0(t1)
    li t0,2
    rem t4,t2,t0

    addi s1,s1,1

    li t0,0
    beq t4,t0,odd

    li t0,1
    beq t4,t0,false

odd:
    beq s1,s0,true

    li t0,8
    mul t1,s1,t0
    add t1,t1,s2
    
    ld t2,0(t1)
    li t0,2
    rem t4,t2,t0

    addi s1,s1,1

    li t0,0
    beq t4,t0,false

    li t0,1
    beq t4,t0,even

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





    

    
    