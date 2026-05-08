.section .rodata
    inputf: .string "%lld"
    outputtrue: .string "TRUE\n"
    outputfalse: .string "FALSE\n"

.section .text
.globl main

main:
    addi sp,sp,-80
    sd ra,0(sp)
    sd s0,8(sp)
    sd s1,16(sp)
    sd s2,24(sp)
    sd s3,32(sp)
    sd s4,40(sp)
    sd s5,48(sp)
    sd s6,56(sp)
    sd s7,64(sp)

    la a0,inputf
    addi a1,sp,72
    call scanf
    ld s0,72(sp)    #s0=n
    mv s1,s0
    li s2,0
    call count_bits
    mv s1,s0
    li s4,0
    li s5,0
    j logic

count_bits:
    addi s2,s2,1
    addi t0,x0,10
    div s1,s1,t0
    bne s1,x0,count_bits
    ret

logic:
    add s4,s4,s5
    beq s1,x0,main_logic
    addi t0,x0,10
    rem s7,s1,t0
    div s1,s1,t0
    mv s3,s2
    li s5,1
    addi s2,s2,-1
    j multiplyr

multiplyr:
    beq s3,x0,logic
    mul s5,s5,s7
    addi s3,s3,-1
    j multiplyr

foundtrue:
    la a0,outputtrue
    call printf
    j exit_all

main_logic:
    beq s4,s0,foundtrue
    la a0,outputfalse
    call printf

exit_all:
    ld ra,0(sp)
    ld s0,8(sp)
    ld s1,16(sp)
    ld s2,24(sp)
    ld s3,32(sp)
    ld s4,40(sp)
    ld s5,48(sp)
    ld s6,56(sp)
    ld s7,64(sp)
    addi sp,sp,80
    ret
