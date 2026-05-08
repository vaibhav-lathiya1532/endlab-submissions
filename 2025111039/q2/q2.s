.data
fmt_int: .string "%d %d"
fmt_out: .string "%d %d\n"

.text
.global main

main:
    li t1,0
    li t2,0
    li t3,0

    addi sp,sp,-32
    la a0,fmt_int
    addi a1,sp,0
    addi a2,sp,4
    call scanf
    
    lw t1,0(sp)
    lw t2, 4(sp)

    lw t5, 0(t1)
    lw t3,0(t2)

    rem s4,t1,t2
    beq s4,zero, print

    rem s4,t2,t1
    beq s4,zero, print


    blt t1,t2, func

    #swap t1 and t2
    mv t3,t1 #t3<-t1
    mv t1,t2 #t1<-t2
    mv t2,t3 #t2<-t3

    func:
        #LCM
        lw t3, 0(t2)
        lw t6,0(t1)

        li t5,2

        loop_LCM:
            rem t4, t3,t1
            beq t4,zero, loop_HCF

            mul t3,t3,t5 #multiples of larger number
            addi t5,t5,1 #t5++
            j loop_LCM
        
        
        loop_HCF:
            rem t4, t2, t5 #t4= t2%t5 i.e. second number divided by the first number
            beq t4,zero, print

            li s3,1
            sub t5,t5,s3 #reduce smaller number
            j loop_HCF


        print:         
        mv a1,t5
        mv a2,t3
        la a0, fmt_out        
        call printf


        li a0,0
        ret


