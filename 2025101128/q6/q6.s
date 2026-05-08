.data
input: .space 128
fmt_in: .asciz "%s"
fmt_out: .asciz "%lld\n"

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

    la a1,input
    la a0,fmt_in
    call scanf

    la s0,input

    loop:
        lb s1,0(s0)
        beq s1,x0,done

        li s2,'+'
        beq s1,s2,addition

        li s2,'*'
        beq s1,s2,multiplication

        li s2,'-'
        beq s1,s2,subtraction

        addi s1,s1,-48
        addi sp,sp,-8
        sd s1,0(sp)

        j next
    
    addition:
        ld s2,0(sp)
        addi sp,sp,8

        ld s3,0(sp)
        addi sp,sp,8

        add s2,s2,s3
        addi sp,sp,-8
        sd s2,0(sp)

        j next

    subtraction:
        ld s2,0(sp)
        addi sp,sp,8

        ld s3,0(sp)
        addi sp,sp,8

        sub s2,s2,s3
        addi sp,sp,-8
        sd s2,0(sp)

        j next

    multiplication:
        ld s2,0(sp)
        addi sp,sp,8

        ld s3,0(sp)
        addi sp,sp,8

        mul s2,s2,s3
        addi sp,sp,-8
        sd s2,0(sp)

        j next

    next:
        addi s0,s0,1
        j loop

    done:
        ld a1,0(sp)
        addi sp,sp,8

        la a0,fmt_out
        call printf

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


