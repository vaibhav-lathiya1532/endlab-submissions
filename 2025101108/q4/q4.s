.section .data
fmt_in: .string "%d %d"
fmt_out: .string "%d "
price: .quad 0
inserted: .quad 0

.section .text
.globl main

main:
    addi sp,sp,-8
    sd ra,0(sp)

    lla a0,fmt_in
    lla a1,price
    lla a2,inserted
    call scanf

    ld s1,inserted
    ld s2,price

    sub s1,s1,s2

    addi s2,x0,0
    addi s3,x0,0
    addi s4,x0,0
    addi s5,x0,0

qloop:
    addi t0,x0,25
    blt s1,t0,end
    sub s1,s1,t0
    addi s2,s2,1
    j qloop

end:
    lla a0,fmt_out
    mv a1,s2
    call printf
    
    
dloop:
    addi t0,x0,10
    blt s1,t0,endd
    sub s1,s1,t0
    addi s3,s3,1
    j dloop

endd:
    lla a0,fmt_out
    mv a1,s3
    call printf
    
nloop:
    addi t0,x0,5
    blt s1,t0,enddd
    sub s1,s1,t0
    addi s4,s4,1
    j nloop

enddd:
    lla a0,fmt_out
    mv a1,s4
    call printf
    
ploop:
    addi t0,x0,1
    blt s1,t0,exit
    sub s1,s1,t0
    addi s5,s5,1
    j ploop

exit:
    lla a0,fmt_out
    mv a1,s5
    call printf

    ld ra,0(sp)
    addi sp,sp,8

    li a0,0

    ret




