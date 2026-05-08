.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"

.section .text
.globl main

main:
    addi sp,sp,-80
    sd ra,72(sp)
    sd s0,64(sp)            #s0=N
    sd s1,56(sp)            #s1=base address
    sd s2,48(sp)
    sd s3,40(sp)            #s3=temp
    sd s4,32(sp)            #s4 =leftsum
    sd s5,24(sp)            #s5 =rightsum
    sd s6,16(sp)

    la a0,fmt_in
    addi a1,sp,0
    call scanf

    ld s0,0(sp)             

    mv s2,x0                #s2=i=0
    mv s4,x0
    mv s5,x0                #ls=rs=0


input:
    bge s2,s0,sum
    slli s3,s2,3
    add s3,s3,s1            # base+i*8

    la a0,fmt_in
    mv a1,s3
    call scanf

    addi s2,s2,1
    beq x0,x0,input


sum:
    addi s2,x0,1

sum_loop:
    bge s2,s0,pivot
    slli s3,s2,3
    add s3,s3,s1
    ld s6,0(s3)

    add s5,s5,s6
    addi s2,s2,1
    beq x0,x0,sum_loop

pivot:
    addi s2,x0,1
    beq s4,s5,print
    

pivot_loop:
    beq s4,s5,print
    bge s2,s0,print_no

    addi t4,s2,-1

    slli t3,t4,3
    add t3,t3,s1
    ld t5,0(t3)


    slli s3,s2,3
    add s3,s3,s1
    ld t2,0(s3)


    add s4,s4,t5
    sub s5,s5,t2

    addi s2,s2,1

    beq x0,x0,pivot_loop


print:
    addi s2,s2,-1
    la a0,fmt_out
    mv a1,s2
    call printf

    beq x0,x0,done

print_no:
    la a0,fmt_out
    addi a1,x0,-1
    call printf


done:

    ld ra,72(sp)
    ld s0,64(sp)
    ld s1,56(sp)
    ld s2,48(sp)
    ld s3,40(sp)
    ld s4,32(sp)
    ld s5,24(sp)
    ld s6,16(sp)
    addi sp,sp,80

    ret