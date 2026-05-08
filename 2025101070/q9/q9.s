.section .rodata
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld\n"

.section .text
.globl main
main:
    addi sp,sp,-32
    sd ra,0(sp)
    sd s0,8(sp) # s0 = n
    sd s1,16(sp)


    la a0,fmt_in
    addi a1,sp,8 
    call scanf
 
    ld s0,8(sp) # s0 = n
    mv t1,s0 # t1 = n
    li t2,10 # t2 = 10
    li s1,100 # max iterations
    li t4,0 # loop ctr
    jal x0,main_logic

main_logic:
    beq t4,s1,not_happy
    li t5,0 # curr = 0
    jal x0,main_loop

main_loop:
    beq t1,x0,next_i
    rem t6,t1,t2 # t6 = curr digit
    div t1,t1,t2 # n/=10
    mul t3,t6,t6 # square
    add t5,t5,t3 # curr += square
    jal x0,main_loop

next_i:
    li t3,1
    beq t5,t3,happy 
    mv t1,t5
    addi t4,t4,1 # i++
    jal x0,main_logic

not_happy:
    la a0,fmt_out
    li a1,0
    call printf
    jal x0,my_exit

happy:
    la a0,fmt_out
    li a1,1
    call printf
    jal x0,my_exit

my_exit:
    ld ra,0(sp)
    ld s0,8(sp) # s0 = n
    ld s1,16(sp)
    addi sp,sp,32
    
    li a0,0
    ret
