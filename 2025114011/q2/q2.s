    .data
fmt_in:     .asciz  "%d %d"
fmt_out:    .asciz  "%d %d\n"
n1:         .word   0
n2:         .word   0

    .text
    .global main
    .extern printf
    .extern scanf

main:
    addi sp,sp,-32
    sd   ra,0(sp)
    sd   s0,8(sp)
    sd   s1,16(sp)

    la  a0,fmt_in
    la  a1,n1
    la  a2,n2
    call scanf

    lw  t0,n1
    lw  t1,n2
    blt t1,t0,min_t1

    mv  t3,t0
    j   loop

min_t1:
    mv  t3,t1

loop:
    beqz    t3,notfound
    rem t4,t1,t3
    #cecking reminder
    #j end
    #li  t0,0
    beqz    t4,second_num

    addi    t3,t3,-1
    j   loop
second_num:
    #li  t0,0
    rem t4,t0,t3
    #j   end
    beqz    t4,found_gcd
    addi    t3,t3,-1
    j loop
found_gcd:
   # li  t0,0
    mv  s0,t3
    mul t4,t0,t1
    div t5,t4,t3
    mv  s1,t5
    j   end

notfound:
    li  s0,1
    mul t4,t0,t1
    mv  s1,t4
    j end
end:
    la  a0,fmt_out
    mv  a1,s0
    mv  a2,s1
    call    printf

    ld  ra,0(sp)
    addi    sp,sp,32
    li  a0,0
    ret
    