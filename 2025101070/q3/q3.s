.section .rodata
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld"
fmt_new: .asciz "\n"

.section .text
.globl main
main:
    addi sp,sp,-80
    sd ra,64(sp)
    sd s0,8(sp) # s0 = n
    sd s1,16(sp) 
    sd s2,24(sp) # s2 = 0
    sd s3,32(sp) # s3 = curr number
    sd s4,40(sp) # ans
    sd s5,48(sp) 

    la a0,fmt_in
    addi a1,sp,4 
    call scanf
 
    ld s0,4(sp) # s0 = n

    li s2,0 # i = 0
    li s4,0 # ans = 0
    jal x0,input

input:
    beq s2,s0,done
    la a0,fmt_in
    add a1,sp,16
    call scanf

    ld s3,16(sp) # s3 = x
    jal x0,check_prime

check_prime:
    li s1,1
    beq s3,s1,dont_add
    li s1,2 # j = 2(starting pt of loop)
    srli s5,s3,1 # s5 = n/2
    addi s5,s5,1
    jal x0,check_prime_loop

check_prime_loop:
    beq s1,s5,add_num # j == n/2
    rem t2,s3,s1 # t2 = n % j
    beq t2,x0,dont_add
    addi s1,s1,1 # j++
    jal x0,check_prime_loop

add_num:
    add s4,s4,s3
    jal x0,next_i

dont_add:
    jal x0,next_i

next_i:
    addi s2,s2,1 # i++
    jal x0,input

done:
    la a0,fmt_out
    mv a1,s4
    call printf
    la a0,fmt_new
    call printf
    jal x0,my_exit

my_exit:
    ld ra,64(sp)
    ld s0,8(sp) # s0 = n
    ld s1,16(sp) 
    ld s2,24(sp) # s2 = 0
    ld s3,32(sp) # s3 = curr number
    ld s4,40(sp) # ans
    ld s5,48(sp) 
    addi sp,sp,80
    
    li a0,0
    ret 

