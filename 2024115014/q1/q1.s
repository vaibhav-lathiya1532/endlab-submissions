.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"

.section .text
.globl main

main:
    addi sp,sp,-48
    sd ra,40(sp)
    sd s0,32(sp)
    sd s1,24(sp)
    sd s2,16(sp)
    sd s3,8(sp) #stack stuff

    lla a0,fmt_in
    addi a1,sp,0
    call scanf
    ld s0,0(sp) #s0=n

    lla a0,fmt_in
    addi a1,sp,0
    call scanf
    ld s1,0(sp) #1st ele: cur max
    li s3,1 #counter

init_loop:
    lla a0,fmt_in
    add a1,sp,0
    call scanf
    ld s2,0(sp) #load ele2

    addi s3,s3,1 #inc counter
    beq s1,s2,init_loop #ele2=ele1, continue
    blt s1,s2,swap #ele2>ele1, swap
    j loop #else go to loop

swap:
    mv t1,s1
    mv s1,s2
    mv s2,t1 #swap(max1,max2)

loop:
    bge s3,s0,exit #counter>=n
    lla a0,fmt_in
    add a1,sp,0
    call scanf
    ld t0,0(sp) #load arr ele

    addi s3,s3,1 #inc counter
    ble t0,s2,loop #t0<=max2, continue
    bgt t0,s1,change #t0>max1, change
    beq t0,s1,loop #t0=max1, continue
    mv s2,t0 #max2=t0 [max2<t0<max1]
    j loop

change:
    mv t1,s1
    mv s1,t0
    mv s2,t1 #max1=t0,max2=max1
    j loop

exit:
    mv a1,s2
    lla a0,fmt_out
    call printf #print max2

    ld ra,40(sp)
    ld s0,32(sp)
    ld s1,24(sp)
    ld s2,16(sp)
    ld s3,8(sp)
    addi sp,sp,48
    ret
