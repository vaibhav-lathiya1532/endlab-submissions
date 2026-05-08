.section .bss
buffer: .space 8

.section .rodata
scan: .string "%lld"
true: .string "TRUE\n"
false: .string "FALSE\n"
check: .string "%lld\n"

.global main
.section .text

main:
    addi sp,sp,-128
    sd s0,0(sp)
    sd s1,8(sp)
    sd s2,16(sp)
    sd s3,24(sp)
    sd s4,32(sp)
    sd s5,40(sp)
    sd s6,48(sp)
    sd s7,56(sp)
    sd ra,64(sp)

    la a0,scan
    la a1,buffer
    call scanf
    la t0,buffer
    ld s0,0(t0)

    li s1,0
    mv s2,s0
    li s3,10

length_loop:
    beqz s2,length_found

    div s2,s2,s3
    addi s1,s1,1

    j length_loop

fun:
    li t1,1
    mv t3,a0
    mv t2,a1

loop1:
    beqz t2,end_fun

    addi t2,t2,-1
    mul t1,t1,t3
    
    j loop1

end_fun:
    mv a0,t1
    ret

length_found:
    li s4,0
    mv s2,s0

loop2:
    beqz s1,number_found

    rem s5,s2,s3
    div s2,s2,s3
    mv a0,s5
    mv a1,s1

    call fun
    
    mv t1,a0
    add s4,s4,t1

    addi s1,s1,-1
    j loop2

number_found:
    beq s4,s0,end_yes

end_no:
    la a0,false
    call printf

    j end_final

end_yes:
    la a0,true
    call printf

end_final:
    ld s0,0(sp)
    ld s1,8(sp)
    ld s2,16(sp)
    ld s3,24(sp)
    ld s4,32(sp)
    ld s5,40(sp)
    ld s6,48(sp)
    ld s7,56(sp)
    ld ra,64(sp)
    addi sp,sp,128

    li a0,0
    ret
