.section .rodata 

fmt_in:
    .asciz "%lld %lld"

fmt_out:
    .asciz "%lld %lld %lld %lld\n"

.section .bss

.align 3
amount:
    .skip 8
price: 
    .skip 8

.text
.globl main
main:
    lui a0 , %hi(fmt_in)
    addi a0, a0 ,%lo(fmt_in)
    lui a1 , %hi(price)
    addi a1 , a1 , %lo(price)
    lui a2 , %hi(amount)
    addi a2 , a2 , %lo(amount)
    call scanf
    lbu s10, amount
    lbu s11 , price
    sub s0 , s10 ,s11
    mv  s6 , x0
    mv  s7 , x0
    mv  s8 , x0
    mv  s9 , x0
    addi s2 , x0 , 25
    addi s3 , x0 , 10 
    addi s4 , x0 , 5
    addi s5 , x0 , 1
    loop:
    bge s0 , s2 , quarter
    bge s0 , s3 , dime
    bge s0 , s4 , penny
    bge s0 , s5 , cent
    

    lui a0 , %hi(fmt_out)
    addi a0 , a0 , %lo(fmt_out)
    mv a1 , s6
    mv a2 , s7
    mv a3 , s8
    mv a4 , s9
    call printf
    ret
    

quarter:
    sub s0 , s0 , s2
    addi s6 , s6 , 1
    j loop
dime:
    sub s0 , s0 , s3
    addi s7 , s7 , 1
    j loop
penny:
    sub s0 , s0 , s4
    addi s8 , s8 , 1
    j loop
cent:
    sub s0 , s0 , s5
    addi s9 , s9 , 1
    j loop


