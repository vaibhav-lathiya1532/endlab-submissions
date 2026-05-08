.section .data
input: .string "%lld"
true_mg: .string "TRUE\n"
false_mg: .string "FALSE\n"

.text
.globl main
main:
    addi sp ,sp ,-64
    sd ra,56(sp)
    sd s1,48(sp)
    sd s2,40(sp)
    sd s3 ,32(sp)
    sd s4,24(sp)
    sd s5,16(sp)

    mv s1,sp
    la a0,input
    mv a1,s1
    call scanf
    ld s2,0(s1)

    addi t0,s2,0
    li s3,0
    li t1,10

    bne s2,x0,len
    addi s3,s3,1
    beq x0,x0,len_done

len:
    beq t0 ,x0,len_done
    addi s3,s3,1
    div t0,t0,t1
    beq x0,x0,len

len_done:
    addi t0, s2,0
    li s4,0
    mv t2,s3
    addi t2,t2,-1
    li t3,1
    mv s5,s3

loop:
    blt s5,t3,done

    rem t4, t0,t1
    mv t5,t4
    mv t6,t2

loop2:
    blt t6,t3,loop2_done
    mul t4,t4,t5
    addi t6,t6,-1
    beq x0,x0,loop2

loop2_done:
    add s4,s4,t4
    addi t2,t2,-1
    div t0,t0,t1

    addi s5,s5,-1
    beq x0,x0,loop

done:
    beq s4,s2,true_msg
    la a0,false_mg
    call printf
    beq x0,x0,exit

true_msg:
    la a0,true_mg
    call printf

exit:
    
    ld ra,56(sp)
    ld s1,48(sp)
    ld s2,40(sp)
    ld s3 ,32(sp)
    ld s4,24(sp)
    ld s5,16(sp)
    addi sp ,sp ,64
    jalr x0,0(ra)
