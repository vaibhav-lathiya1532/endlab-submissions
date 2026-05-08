.data
    num: .space 10
    format: .asciz "%lld"
    formatt: .asciz "%lld\n"
.text
.global main
main:
    addi sp,sp,-16
    sd x1,0(sp)
    la x10,format
    la x11,num
    call scanf
    la x10,num
    ld x6,0(x10)
    addi x30,x0,0
loop:
    beq x6,x0,end
    la x10,format
    la x11,num
    addi sp,sp,-16
    sd x6,0(sp)
    sd x30,8(sp)
    call scanf
    ld x6,0(sp)
    ld x30,8(sp)
    addi sp,sp,16
    la x10,num
    ld x5,0(x10)
    addi x6,x6,-1
    addi x7,x0,2
    addi x31,x0,1
    beq x5,x31,loop
loop2:
    beq x7,x5,add
    rem x28,x5,x7
    beq x28,x0,loop
    addi x7,x7,1
    jal x0,loop2
add:
    add x30,x30,x5
    jal x0,loop
end:
    addi x11,x30,0
    la x10,formatt
    call printf
    ld x1,0(sp)
    addi sp,sp,16
    jalr x0,0(x1)
