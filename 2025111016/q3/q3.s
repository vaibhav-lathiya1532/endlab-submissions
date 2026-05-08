.data
    input: .asciz "%lld"
    output: .asciz "%lld\n"
    array: .space 800000
    num: .quad 0

.text
.global main
main:

    addi sp,sp,-64
    sd ra,56(sp)
    sd s0,48(sp)
    sd s1,40(sp)
    sd s2,32(sp)
    sd s3,24(sp)
    sd s4,16(sp)
    sd s5,8(sp)



    la a0,input
    la a1,num
    call scanf


    ld s0,num
    la s1,array

    li s2,0
    li s3,0 #sum

loop:
    bge s2,s0,scan_end
    li t1,1    
    slli t1,t1,3       #i*8
    mul t2,t1,s2
    add s4,s1,t2

    la a0,input
    la a1,num
    call scanf

    ld t4,num
    add s3,s3,t4
    sd t4,0(s4)

    addi s2,s2,1
    j loop


scan_end:
    
    li s4,0     #s4=leftsum 
    mv s6,s3    #s6=rightsum
    
    li s5,0 #counter

go:
    bge s5,s0,not_done
    li t4,1
    slli t4,t4,3
    mul t4,t4,s5 #i*8
    add t5,t4,s1
    ld t6,0(t5)  #arr[i]

    sub s6,s6,t6  #rightsum
    sub t1,s3,s6  #sum-rightsum
    sub s4,t1,t6
  

    beq s6,s4,done
    addi s5,s5,1
    j go

not_done:
    la a0,output
    li a1,-1
    call printf
    j exit

done:
    la a0,output
    mv a1,s5
    call printf
    j exit

exit:

    
    ld ra,56(sp)
    ld s0,48(sp)
    ld s1,40(sp)
    ld s2,32(sp)
    ld s3,24(sp)
    ld s4,16(sp)
    ld s5,8(sp)
    addi sp,sp,64

    li a0,0
    ret