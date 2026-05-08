.data
fmt_in: .asciz "%100s"
buffer: .space 128
fmt_out: .asciz "%lld\n"

.extern scanf
.extern printf

.text
.globl main



main:
    addi sp,sp,-16
    sd s1,0(sp)
    sd ra,8(sp)

    la a0,fmt_in
    la a1,buffer
    call scanf

    la s1,buffer

loop:
    lbu t0,0(s1)
    beq t0,zero,end
    li t3,'\n'
    beq t0,t3,end
    addi s1,s1,1

    li t3,'0'
    blt t0,t3,operator

    li t3,'9'
    bgt t0,t3,operator

    addi t0,t0,-48
    addi sp,sp,-8
    sd t0,0(sp)
    j loop

operator:
    ld t1,0(sp)
    addi sp,sp,8

    ld t2,0(sp)
    addi sp,sp,8

    li t3,'+'
    beq t0,t3,addition

    li t3,'-'
    beq t0,t3,subtraction

    li t3,'*'
    beq t0,t3,multiplication

addition:
    add t4,t1,t2
    addi sp,sp,-8
    sd t4,0(sp)
    j loop

subtraction:
    sub t4,t2,t1
    addi sp,sp,-8
    sd t4,0(sp)
    j loop

multiplication:
    mul t4,t1,t2
    addi sp,sp,-8
    sd t4,0(sp)
    j loop

end:
    ld a1,0(sp)
    addi sp,sp,8

    la a0,fmt_out
    call printf

    ld s1,0(sp)
    ld ra,8(sp)
    addi sp,sp,16
    li a0,0
    ret
