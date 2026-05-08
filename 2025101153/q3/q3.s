.data
fmt_in: .asciz "%lld"
fmt_out:    .asciz "%lld\n"
string_1: .asciz "-1\n"

.extern scanf
.extern printf
.extern malloc

.text
.globl main

main:
    addi sp,sp,56
    sd ra,8(sp)
    sd s1,16(sp)        #array base address
    sd s0,24(sp)        #n
    sd s2,32(sp)        #prefix base address
    sd s3,40(sp)        #i
    sd s4,48(sp)    #prefix array index

    la a0,fmt_in
    addi a1,sp,0
    call scanf

    ld s0,0(sp)

    li t0,8
    mul a0,t0,s0
    call malloc
    mv s1,a0

    li t0,8
    addi t2,s0,1
    mul a0,t0,t2
    call malloc
    mv s2,a0

   sd x0,0(s2)      #prefix[0]=0
    li s3,0
    addi s4,s3,1

read_array:
    bge s3,s0,read_array_done
    li t0,8
    mul t0,t0,s3
    add t0,t0,s1
    la a0,fmt_in
    mv a1,t0
    call scanf

    j store_prefix

store_prefix:
    addi t1,s4,0
    addi t2,s4,-1
    li t0,8
    mul t0,t0,t2
    add t0,t0,s2
    ld t3,0(t0)

    li t0,8
    mul t0,t0,t2
    add t0,t0,s1
    ld t4,0(t0)

    add t3,t3,t4

    li t0,8
    mul t0,t0,t1
    add t0,t0,s2
    sd t3,0(t0)

    addi s4,s4,1
    addi s3,s3,1
    j read_array

read_array_done:
    li t1,1     #index
   
answer_loop:
    bgt t1,s0,not_found 
    li t0,8
    addi t2,s0,0
    mul t2,t2,t0
    add t2,t2,s2
    ld t3,0(t2)     #prefix[n]

    addi t2,t1,-1
    mul t2,t2,t0
    add t2,t2,s2
    ld t4,0(t2)     #prefix[index-1]

    addi t2,t1,0
    mul t2,t2,t0
    add t2,t2,s2
    ld t5,0(t2)     #prefix[index]

    sub t3,t3,t5
    beq t3,t4,found

    addi t1,t1,1
    j answer_loop

found:
    la a0,fmt_out
    addi a1,t1,-1
    call printf
    j exit

not_found:
    la a0,string_1
    call printf
    j exit

exit:
     ld ra,8(sp)
    ld s1,16(sp)        #array base address
    ld s0,24(sp)        #n
    ld s2,32(sp)        #prefix base address
    ld s3,40(sp)        #i
    ld s4,48(sp)    #prefix array index
    addi sp,sp,56
    li a0,0
    ret











