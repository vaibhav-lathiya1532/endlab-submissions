.data
input: .asciz "%lld"
output: .asciz "%lld\n"
num: .quad 0


.text
.global main
main:

    addi sp,sp,-32
    sd ra,24(sp)
    sd s0,16(sp)
    sd s3,8(sp)
    sd s4,0(sp)

    la a0,input
    la a1,num
    call scanf

    ld s0,num #s0=orignal

    li t1,100
    li t2,1
    li s3,0 #counter
    li s4,0 #sum
loop:
    beq s0,t2,done
    bge s3,t1,not_done

number_loop:
    beqz s0,number_done
    li t3,10
    rem t4,s0,t3
    mul t5,t4,t4
    add s4,s4,t5
    div s0,s0,t3
    j number_loop

number_done:
    addi s3,s3,1
    addi s0,s4,0
    li s4,0
    j loop

done:
    la a0,output
    li a1,1
    call printf 
    j exit

not_done:
    la a0,output
    li a1,0
    call printf
    j exit

exit:

    ld ra,24(sp)
    ld s0,16(sp)
    ld s3,8(sp)
    ld s4,0(sp)
    addi sp,sp,32

    li a0,0
    ret
