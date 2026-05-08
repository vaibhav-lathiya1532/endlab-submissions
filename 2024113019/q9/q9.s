.section .rodata
    format_in: .string "%lld"
    format_out:.string "%lld\n"
    format_test: .string "sdfsdf"
.section .text

.globl main


main:

    addi sp,sp,-16
    sd ra,8(sp)

    la a0,format_in
    addi a1,sp,0
    call scanf

    ld s0,0(sp) #stores n

    mv a0,s0

    call is_happy

    mv a1,a0
    la a0,format_out
    call printf
    ld ra,8(sp)
    addi sp,sp,16
    li a0,0 #make kept screaminf at me
    ret

is_happy:
    mv t0,a0
    li t4,0
    li t3,10
    li t5,100

outer_loop:
    beq t4,t5,return_zero
    li a1,1
    beq t0,a1,return_one
    li t6,0

inner_loop:
    beqz t0,end_inner
    remu a2,t0,t3
    divu t0,t0,t3
    mul a2,a2,a2
    add t6,t6,a2
    j inner_loop



end_inner:
    mv t0,t6
    addi t4,t4,1
    j outer_loop

return_zero:
    li a0,0
    ret

return_one:
    li a0,1
    ret

