.section .rodata
fmt_in: .string "%lld"
fmt_t: .string "TRUE\n"
fmt_f: .string "FALSE\n"

.section .text
.globl main

main:
    addi sp,sp,48
    sd ra,40(sp)
    sd s0,32(sp)
    sd s1,24(sp)
    sd s2,16(sp)
    sd s3,8(sp) #stack stuff

    lla a0,fmt_in
    addi a1,sp,0
    call scanf
    ld s0,0(sp) #s0=n

    li t0,10
    mv s1,s0 #s1=n (will get destroyed)
    li s2,0 #s2=len of s0
    li s3,0 #for final comparison

count_loop:
    ble s1,zero,pre_loop #s1<=0
    div s1,s1,t0 #s1/10
    addi s2,s2,1 #s2+=1
    j count_loop

pre_loop:
   mv s1,s0 #s1=n

loop:
    ble s1,zero,done #s1<=0
    rem t1,s1,t0 #t1=s1%10
    mv t2,t1 #t2=s1%10
    addi t3,s2,-1 #t3=n-1

exp_loop:
    ble t3,zero,next_loop
    mul t1,t1,t2 #t1=t1^n
    addi t3,t3,-1 #n_c-=1
    j exp_loop

next_loop:
    add s3,s3,t1 #new+=digit^n
    addi s2,s2,-1 #n-=1
    div s1,s1,t0 #s1/=10
    j loop

done:
    beq s3,s0,p_true #n=new->true
    lla a0,fmt_f
    call printf #print false
    j exit

p_true:
    lla a0,fmt_t
    call printf #print true

exit:
    ld ra,40(sp)
    ld s0,32(sp)
    ld s1,24(sp)
    ld s2,16(sp)
    ld s3,8(sp)
    addi sp,sp,-48 #stack stuff
    ret
