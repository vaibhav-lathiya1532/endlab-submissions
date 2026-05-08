.data
num: .space 20
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
    ld x10,0(x10)
    addi x6,x0,1
    addi x7,x0,0
    addi x30,x0,0
    jal x0,loop
cond:
    addi x7,x7,1
    addi x5,x0,1
    beq x30,x5,end
    addi x31,x0,100
    beq x7,x31,endd
    addi x10,x30,0
    addi x6,x0,1
    addi x30,x0,0
loop:
    div x28,x10,x6
    beq x28,x0,cond
    addi x29,x0,10
    rem x28,x28,x29
    mul x28,x28,x28
    add x30,x30,x28
    mul x6,x6,x29
    jal x0,loop
end:
    addi x11,x0,1
    la x10,formatt
    call printf
    ld x1,0(sp)
    addi sp,sp,16
    jalr x0,0(x1)
endd:
    addi x11,x0,0
    la x10,formatt
    call printf
    ld x1,0(sp)
    addi sp,sp,16
    jalr x0,0(x1)