.section .rodata

print_fmt:
.string "%lld\n"

scan_fmt:
.string "%lld"

.section .text
.globl main

main:

    addi sp,sp,-80
    sd s0,72(sp)
    sd s1,64(sp)
    sd s2,56(sp)
    sd s3,48(sp)
    sd s4,40(sp)
    sd s5,32(sp)
    sd s6,24(sp)
    sd ra,16(sp)

    lla a0,scan_fmt
    addi a1,sp,8
    call scanf
    ld s0,8(sp) 

    mv a0,s0
    slli a0,a0,3
    call malloc
    mv s1,a0

    li s2,0
    li s3,0 

input_loop:

    bge s2,s0,next 

    lla a0,scan_fmt
    addi a1,sp,8
    call scanf 
    ld s4,8(sp) 

    slli s5,s2,3 
    add s5,s5,s1 
    sd s4,0(s5)

    addi s2,s2,1
    j input_loop

next: 

    li s2,0 
    li s3,0

loop: 

    bge s2,s0,end 

    slli s5,s2,3
    add s5,s5,s1
    ld s4,0(s5) 
    
    li t1,1
    beq t1,s4,not_prime

    li s6,2

check_prime:

    bge s6,s4,prime 

    rem t0,s4,s6
    beqz t0,not_prime

    addi s6,s6,1
    j check_prime

prime:

    add s3,s3,s4
    addi s2,s2,1
    j loop 

not_prime:

    addi s2,s2,1
    j loop 

end: 

    lla a0,print_fmt
    mv a1,s3
    call printf 

    ld s0,72(sp)
    ld s1,64(sp)
    ld s2,56(sp)
    ld s3,48(sp)
    ld s4,40(sp)
    ld s5,32(sp)
    ld s6,24(sp)
    ld ra,16(sp)
    addi sp,sp,80 
    ret 
