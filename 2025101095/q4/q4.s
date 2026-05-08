.data
fmtin: .asciz "%lld %lld"
fmtout: .asciz "%lld %lld %lld %lld\n"
price: .dword 0
inserted: .dword 0
.text
.global main
main:
    addi sp,sp,-96
    sd ra,0(sp)
    sd s1,8(sp)
    sd s2,16(sp)
    sd s3,24(sp)
    sd s4,32(sp)
    sd s5,40(sp)
    sd s6,48(sp)
    sd s7,56(sp)
    sd s8,64(sp)
    sd s9,72(sp)
    sd s10,80(sp)
    sd s11,88(sp);

    la a0,fmtin
    la a1,price
    la a2,inserted
    call scanf

    la t0,price
    ld s0,0(t0)         #s0=price value

    la t0,inserted
    ld s1,0(t0)         #s1=inserted value

    sub s3,s1,s0        #s3=inserted-price value

    mv s4,x0        #s4=count(25)
    mv s5,x0        #s5=count(10)
    mv s6,x0        #s6=count(5)
    mv s7,x0       #s7=count(1)

    addi s8,x0,25        #s8=25
    addi s9,x0,10        #s9=10
    addi s10,x0,5        #s10=5
    addi s11,x0,1        #s11=1

q25count:
    blt s3,s8,q25count_done
    addi s4,s4,1
    sub s3,s3,s8
    j q25count
q25count_done:
q10count:
    blt s3,s9,q10count_done
    addi s5,s5,1
    sub s3,s3,s9
    j q10count
q10count_done:
q5count:
    blt s3,s10,q5count_done
    addi s6,s6,1
    sub s3,s3,s10
    j q5count
q5count_done:
q1count:
    blt s3,s11,q1count_done
    addi s7,s7,1
    sub s3,s3,s11
    j q1count
q1count_done:
print_ans:

    la a0,fmtout
    mv a1,s4
    mv a2,s5
    mv a3,s6
    mv a4,s7
    call printf
    
    ld s11,88(sp)
    ld s10,80(sp)
    ld s9,72(sp)
    ld s8,64(sp)
    ld s7,56(sp)
    ld s6,48(sp)
    ld s5,40(sp)
    ld s4,32(sp)
    ld s3,24(sp)
    ld s2,16(sp)
    ld s1,8(sp)
    ld ra,0(sp)
    addi sp,sp,96
    addi a0,x0,0
    ret











