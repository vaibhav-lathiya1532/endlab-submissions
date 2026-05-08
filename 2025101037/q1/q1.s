.globl main
.extern scanf
.extern printf

.data
fmt_in : .asciz "%lld"
fmt_out : .asciz "%lld\n"

.text

main:
    addi sp,sp,-40
    sd ra,32(sp)
    sd x18,8(sp)
    sd x19,16(sp)

    la a0,fmt_in
    ld a1,24(sp)
    call scanf

    ld x18,24(sp)
    li x5,0
    li x6,1
    li x7,2
    li x29,0
    li x30,0

get:
    beq x5,x18,end
    la a0,fmt_in
    addi a1,sp,0
    call scanf

    ld x28,0(sp)

    addi x5,x5,1
    beq x5,x6,upd2
    beq x5,x7,upd3

    bgt x28,x29,upd
    bgt x28,x30,upd1
    j get


upd:
    mv x30,x29
    mv x29,x28
    j get

upd1:
    beq x28,x29,get
    mv x30,x28
    j get

upd2:
    mv x29,x28
    j get

upd3:
    mv x30,x28
    j get

end:
    la a0,fmt_out
    mv a1,x30
    call printf

    sd ra,32(sp)
    sd x18,8(sp)
    sd x19,16(sp)
    addi sp,sp,40

    li a0,0
    ret


