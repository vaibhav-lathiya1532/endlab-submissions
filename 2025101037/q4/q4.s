.globl main
.extern scanf
.extern printf

.data
fmt_in : .asciz "%lld %lld"
fmt_out : .asciz "%lld %lld %lld %lld\n"

.text

main:
    addi sp,sp,-48
    sd ra,0(sp)
    sd x18,8(sp)
    sd x19,16(sp)

    la a0,fmt_in
    addi a1,sp,24
    addi a2,sp,32

    call scanf
    ld x18,24(sp)
    ld x19,32(sp)

    li x28,25
    li x29,10
    li x30,5
    sub x5,x19,x18
    li x6,0
    li x7,0
    li x31,0

q_count:
    blt x5,x28,d_count
    sub x5,x5,x28
    addi x6,x6,1
    j q_count
    
d_count:
    blt x5,x29,n_count
    sub x5,x5,x29
    addi x7,x7,1
    j d_count

n_count:
    blt x5,x30,end
    sub x5,x5,x29
    addi x31,x31,1
    j n_count
    

end:
    la a0,fmt_out
    mv a1,x6
    mv a2,x7
    mv a3,x31
    mv a4,x5
    call printf

    sd ra,0(sp)
    sd x18,8(sp)
    sd x19,16(sp)
    addi sp,sp,40

    li a0,0
    ret


