.data
    fmt: .string "%lld"
    arr: .space 108
    n: .dword 0
    fmt_out: .string "%lld\n"
.text
.global main
main:
    addi sp,sp,-8
    sd ra,0(sp)

    la a0,fmt
    la a1,n
    call scanf
    la a1,n
    ld s0,0(a1)

    la s1,arr
    addi s2,x0,0 #i
    addi s3,x0,0 #sum

INPUTLOOP:
    beq s2,s0,CHECK
    la a0,fmt
    mv a1,s1
    call scanf
    ld t0,0(s1)
    add s3,s3,t0
    addi s1,s1,8
    addi s2,s2,1
    beq x0,x0,INPUTLOOP

CHECK:
    la s1,arr
    addi s2,x0,0 #i 
    addi s4,x0,0 #csum
    addi s5,x0,-1

CONTINUE:
    beq s2,s0,PRINT
    ld t0,0(s1)
    sub t2,s3,s4
    sub t2,t2,t0
    bne t2,s4,UPDATE
    mv s5,s2
    beq x0,x0,PRINT

    UPDATE:
        add s4,s4,t0
        addi s2,s2,1
        addi s1,s1,8
        beq x0,x0,CONTINUE

PRINT:
    la a0,fmt_out
    mv a1,s5
    call printf

    ld ra,0(sp)
    addi sp,sp,8
    ret
    

