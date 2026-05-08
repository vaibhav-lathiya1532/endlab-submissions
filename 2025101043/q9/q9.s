.data
n: .word 0
iformat: .string "%d"
oformat: .string "%d"

.text
.global main

main:

    addi sp,sp,-64
    sd ra,0(sp)
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    # ----------- store the saved registers here-----------------

    la a0, iformat
    la a1, n
    call scanf

    la t0, n
    lw s0, 0(t0)

setup_iterations_100:

    # ------------variables--------
    # s0-> n
    # s1-> 100
    # s2-> 10
    # s3-> 1
    # s4-> sum = 0

    li s1,100
    li s2,10
    li s3,1

iterations_100:

    beq s1,x0,false

    setup_square_digit:
        mv s4,x0

    square_digit:

        beq s0,x0,end_square_digit

        rem t0,s0,s2
        div s0,s0,s2
        mul t0,t0,t0
        add s4,t0,s4

        j square_digit

    end_square_digit:

        beq s4,s3,true

        mv s0,s4
        addi s1,s1,-1
        j iterations_100

false:
    la a0,oformat
    li a1,0
    call printf
    j end
true:
    la a0,oformat
    li a1,1
    call printf

end:

    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)

    mv a0, x0
    call exit

