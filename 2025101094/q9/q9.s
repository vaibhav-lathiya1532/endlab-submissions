.section .bss
mk: .space 8

.section .rodata
fmt: .string "%d"
fmt_1: .string "1\n"
fmt_0: .string "0\n"

.section .text
.global main
main:
    addi sp,sp,-48
    sd s0,8(sp)
    sd ra,16(sp)
    sd s1,24(sp)
    sd s2,32(sp)
    sd s3,40(sp)
    sd s4,0(sp)

    la a0,fmt
    la a1,mk
    call scanf
    ld s0,mk        # stores current no

    addi s2,x0,0   # index no
    addi s3,x0,100
    addi t0,x0,10
    addi s4,x0,1

loop:
    bge s2,s3,no
    addi s2,s2,1
    addi s3,x0,0
loop1:
    ble s0,x0,checksum
    rem t1,s0,t0
    div s0,s0,t0
    mul t1,t1,t1
    add s3,s3,t1
    beq x0,x0,loop1

checksum:
    beq s3,s4,yes
    mv s0,s3
    beq x0,x0,loop

yes:
    la a0,fmt_1
    call printf
    beq x0,x0,end

no:
    la a0,fmt_0
    call printf
    beq x0,x0,end

end:
    ld s0,8(sp)
    ld ra,16(sp)
    ld s1,24(sp)
    ld s2,32(sp)
    ld s3,40(sp)
    ld s4,0(sp)
    addi sp,sp,48
    li a0,0
    ret




