.data
intfmt: .string "%lld"
intpfmt: .string "%lld\n"
space: .string "%lld "
.text
.global main

main:
    addi sp,sp,-96

    sd ra,80(sp)
    sd s0,72(sp)
    sd s1,64(sp)
    sd s2,56(sp)
    sd s3,48(sp)
    sd s4,40(sp)
    sd s5,32(sp)

    la a0,intfmt
    addi a1,sp,24
    call scanf

    ld s0,24(sp)

    la a0,intfmt
    addi a1,sp,16
    call scanf

    ld s1,16(sp)

    bgt s0,s1,gcd

    mv t0,s0
    mv s0,s1
    mv s1,t0

    
    mv s2,x0
    
    mv t0,s0
    mv t1,s1
    
    

gcd:
    rem t2,t0,t1
    beqz t2,end
    mv t0,t1
    mv t1,t2
    j gcd

end:
    
    mv s2,t1
    mul t0,s0,s1
    div s3,t0,s2

    

    la a0,space
    mv a1,s2
    call printf

    

    la a0,intpfmt
    mv a1,s3
    call printf

    ld ra,80(sp)
    ld s0,72(sp)
    ld s1,64(sp)
    ld s2,56(sp)
    ld s3,48(sp)
    ld s4,40(sp)
    ld s5,32(sp)
    addi sp,sp,96
    ret


