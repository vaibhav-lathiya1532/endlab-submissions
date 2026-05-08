.data

fmt_input:
    .string "%lld"
fmt_output:
    .string "%lld\n"

.text
.globl main

main:

addi sp,sp,-48
sd s3,40(sp)#target
sd ra,32(sp)
sd s0,24(sp) #n
sd s1,16(sp)#array
sd s2,8(sp)#index

la a0,fmt_input
addi a1,sp,0
call scanf
ld s0,0(sp)#number of element in array

slli t0,s0,3
mv a0,t0
call malloc
mv s1,a0

li s2,0

input_loop:
    bge s2,s0,exit_il
    la a0,fmt_input
    addi a1,sp,0
    call scanf
    ld t0,0(sp)
    slli t1,s2,3
    add t2,s1,t1
    ld t0,0(t2)
    addi s2,s2,1
    j input_loop


exit_il:

la a0,fmt_input
addi a1,sp,0
call scanf
ld s3,0(sp) 

li t1,0 #lo = 0
addi t2,s0,-1 #high=n-1
ld t6,0(s1)#val of lo
slli t3,t2,3
add t3,t3,s1
ld t0,0(t3)#val of high



bs_loop:
    bgt t1,t2,exit_bs_fail

    add t3,t1,t2 #mid
    srai t3,t3,1 #low+high/2 whole div

    slli t4,t3,3 
    add t4,t4,s1
    ld t5,0(t4)#value of mid

    beq t5,s3,exit_bs_suc

    ble t6,t5,sorted_below
    blt s3,t5,go_left
    bgt s3,t0,go_left
    j go_left
    sorted_below:
    blt s3,t6,go_right
    bgt s3,t5,go_right
    go_left:
    addi t2,t3,-1
    j bs_loop
    go_right:
    addi t1,t3,1
    j bs_loop

exit_bs_fail:

    la a0,fmt_output
    li a1,-1
    call printf
    
    j done

exit_bs_suc:
    la a0,fmt_output
    mv a1,t3
    call printf

    j done

done:

addi sp,sp,48
ld s3,40(sp)
ld ra,32(sp)
ld s0,24(sp) #n
ld s1,16(sp)#array
ld s2,8(sp)#index
ret

