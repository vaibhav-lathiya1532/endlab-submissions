.data
fmt_in: .string "%lld"
fmt_op: .string "%lld\n"
fmt_minus_one: .string "-1\n"

.text
.global main

main:
 addi sp,sp,-48
 sd ra,0(sp)
 sd s0,8(sp)
 sd s1,16(sp)
 sd s2,24(sp)
 sd s3,32(sp)
 sd s4,40(sp)

addi sp,sp,-8
mv a1,sp
la a0,fmt_in
call scanf
ld s0,0(sp)     #HERE s0 is holding N
addi sp,sp,8
slli t0,s0,3
mv a0,t0
call malloc
mv s1,a0        #Now s1 has the base address of the array

#NOW WE SHALL READ THE ELEMENTS OF THE ARRAY AND ALSO CALCULATE THE SUM IN A GO

li s2,0         #Holds the total sum for now
li s3,0         #Here s3 holds the iteration value of the loop can be reused later again after I use it here for the total sum

total_sum_loop:
    bge s3,s0,sum_done
    slli t0,s3,3
    add t0,t0,s1
    la a0,fmt_in
    mv a1,t0
    call scanf
    slli t0,s3,3
    add t0,t0,s1
    ld t0,0(t0)
    add s2,s2,t0
    addi s3,s3,1
j total_sum_loop

sum_done:
    li s3,0     #This is the index value Now
    li s4,0     #This is the prefix_sum
    loop:
        bge s3,s0,no_block
        slli t0,s3,3
        add t0,t0,s1
        ld t0,0(t0)
        sub s2,s2,t0
        beq s4,s2,found_it
        add s4,s4,t0
        addi s3,s3,1
        j loop
    
    no_block:
    la a0,fmt_minus_one
    call printf
    j donee

    found_it:
    la a0,fmt_op
    mv a1,s3
    call printf
    
    
    donee:
    mv a0,s1
    call free
    ld ra,0(sp)
    ld s0,8(sp)
    ld s1,16(sp)
    ld s2,24(sp)
    ld s3,32(sp)
    ld s4,40(sp)
    addi sp,sp,48
    li a0,0
    ret
