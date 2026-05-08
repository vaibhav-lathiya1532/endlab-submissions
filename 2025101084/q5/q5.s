.section .data

n: .space 8
input_fmt: .asciz "%lld"
output_fmt: .asciz "%lld "
end_of_line: .asciz "%lld\n"


.section .text
.global main
main:
    addi sp,sp,-48
    sd ra,0(sp)
    sd s0,8(sp)
    sd s1,16(sp)
    sd s5,24(sp)
    sd s6,32(sp)

    la a1,n
    la a0,input_fmt
    call scanf

    la a0,n
    ld s0,0(a0)

    # s0 contains n

    # malloc space n*n*8 and store the starting address in s1

    mul t0,s0,s0
    slli a0,t0,3
    call malloc
    mv s1,a0

    # s1 -> has the base address of matrix

    li s5,0
    input_1:

        beq s5,s0,exit_input_1
        li s6,0
        input_2:
            beq s6,s0,exit_input_2

            mul t0,s5,s0
            add t0,t0,s6
            slli t0,t0,3
            add t0,t0,s1

            mv a1,t0
            la a0,input_fmt
            call scanf

            addi s6,s6,1
            beq x0,x0,input_2
        exit_input_2:

        addi s5,s5,1
        beq x0,x0,input_1
    exit_input_1:

    # now take the transpose

    li s5,0
    transpose_1:
        beq s5,s0,exit_transpose_1
        addi s6,s5,1
        tranpose_2:
            beq s6,s0,exit_transpose_2

            mul t0,s5,s0
            add t0,t0,s6
            slli t0,t0,3
            add t0,t0,s1

            ld t1,0(t0)

            mul t2,s6,s0
            add t2,t2,s5
            slli t2,t2,3
            add t2,t2,s1

            ld t3,0(t2)

            sd t1,0(t2)
            sd t3,0(t0)

            addi s6,s6,1
            beq x0,x0,tranpose_2
        exit_transpose_2:
        addi s5,s5,1
        beq x0,x0,transpose_1
    exit_transpose_1:

    li s5,0
    row_reverse_1:
        beq s5,s0,exit_row_1
        # t5 contains  the starting address and t6 contains the ending address

        mul t5,s5,s0
        slli t5,t5,3
        add t5,t5,s1

        mul t6,s5,s0
        add t6,t6,s0
        addi t6,t6,-1
        slli t6,t6,3
        add t6,t6,s1

        row_reverse_2:
            bge t5,t6,exit_row_2

            ld t0,0(t5)
            ld t1,0(t6)

            sd t0,0(t6)
            sd t1,0(t5)

            addi t5,t5,8
            addi t6,t6,-8

            beq x0,x0,row_reverse_2
        exit_row_2:
        
        addi s5,s5,1
        beq x0,x0,row_reverse_1
    exit_row_1:


    li s5,0
    print_1:

        beq s5,s0,exit_print_1
        li s6,0
        print_2:
            addi t0,s0,-1
            beq s6,t0,print_last
            
            mul t0,s5,s0
            add t0,t0,s6
            slli t0,t0,3
            add t0,t0,s1

            ld a1,0(t0)
            la a0,output_fmt
            call printf

            addi s6,s6,1
            beq x0,x0,print_2
        print_last:
            mul t0,s5,s0
            add t0,t0,s6
            slli t0,t0,3
            add t0,t0,s1

            ld a1,0(t0)
            la a0,end_of_line
            call printf

        addi s5,s5,1
        beq x0,x0,print_1
    exit_print_1:

    ld ra,0(sp)
    ld s0,8(sp)
    ld s1,16(sp)
    ld s2,24(sp)
    ld s5,32(sp)
    ld s6,40(sp)
    addi sp,sp,48

    ret

