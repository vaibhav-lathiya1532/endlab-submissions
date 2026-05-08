.data
fmt_int: .string "%d "
fmt_out: .string "%d\n"

.text
.global main

main:

    addi sp,sp,-16

    la a0, fmt_int
    addi a1,sp,4
    call scanf

    lw t0, 0(sp)  #t0=n

    lw t1, 4(sp) #t1=base address
    li t2,0 #t2=i

    read_arr:
        addi sp,sp, -400
        beq t2,t0, read_target        

        la a0, fmt_int
        addi a1,sp,4
        call scanf

        lw t3,0(sp)

        slli t4,t3,2
        add t5, t1,t4
        sw t3,0(t5)
    

    read_target:
        addi sp,sp, -16

        la a0, fmt_int
        addi a1,sp,4
        call scanf

        lw t2, 0(sp)  #t2=target

    li t3,0 #low=0
    addi t5,t0,-1 #high=n-1
    

    b_loop:

        bgt t3,t5,end   #while(left<right)

        add t4, t3,t5
        srai t4,t4,1 #mid=(low+high)/2

        #arr[mid]
        slli t6,t4,2
        add s2,t1,t6
        lw s3,0(s2)


        beq t2,s3, print  #arr[mid]=target print

        #arr[low]
        slli t6,t3,2
        add s2,t1,t6
        lw s4,0(s2)

        blt s4,s3, left_sorted

        #right_sorted
        blt t2,s3, go_left
        bgt t2, s3, go_right
        

        go_left:
            addi t5,t4,-1
            j b_loop
        
        go_right:
            addi t3,t4,1
            j b_loop
        

        left_sorted:
        blt t2,s4, go_right2
        blt t2,s3, go_left2

        go_right2:
            addi t3,t4,1
            j b_loop

        go_left2:
            addi t5, t4,-1
            j b_loop


    print:
        mv a1,t4
        j final

    end:
        sub t4,t4,t4
        mv a1,t4

    final:
        la a0, fmt_out
        call printf
        addi sp,sp,16

        li a0,0
        ret





        



    





