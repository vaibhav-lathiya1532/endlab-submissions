.section .rodata
fmt1: .string "%lld %lld"
fmt2: .string "%lld %lld %lld %lld\n"
.section .bss
num1: .space 8
num2: .space 8
.extern scanf
.extern printf
.section .text
.global main
main:
    addi sp,sp,-16
    sd ra,8(sp)
    la a0,fmt1
    la a1,num1
    la a2,num2
    call scanf
    ld t0,num1
    ld t1,num2
    sub t0,t1,t0
    li t1,0
    li t2,0
    li t3,0
    li t4,0
    li t5,25
loop_25:
       blt t0,t5,done_25
       sub t0,t0,t5
       addi t1,t1,1
       j loop_25
done_25:
       li t5,10
loop_10:
       blt t0,t5,done_10
       sub t0,t0,t5
       addi t2,t2,1
       j loop_10
done_10:
       li t5,5
loop_5:
      blt t0,t5,done_5 
      sub t0,t0,t5
      addi t3,t3,1
      j loop_5
done_5:
      li t5,1
loop_1:
      blt t0,t5,done 
      sub t0,t0,t5
      addi t4,t4,1
      j loop_1
done:
    la a0,fmt2
    mv a1,t1
    mv a2,t2
    mv a3,t3
    mv a4,t4
    call printf
    ld ra,8(sp)
    addi sp,sp,16
    ret
