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

    #size of array
    la a0,scan
    la a1,buffer
    call scanf
    la t0,buffer
    ld s0,0(t0)

    mv s1,s0
    addi s1,s1,-1
    
#first element
    la a0,scan
    la a1,buffer
    call scanf
    la t0,buffer
    ld s2,0(t0)

    li t1,2
#intitializing first parity
    rem s4,s2,t1

#answer validation
    li s5,1
    
#case for only one element input
    beqz s1,end_no

#change parity after check
    beqz s4,zero
    li s4,0
    j loop1

zero:
    li s4,1
loop1:
    beqz s1,end

    la a0,scan
    la a1,buffer
    call scanf
    la t0,buffer
    ld s2,0(t0)

    li t1,2
    rem s3,s2,t1

    addi s1,s1,-1

    beq s3,s4,truu
#if the element is already incorrect flag turned once is always 0
    li s5,0
truu:
    beqz s4,zero
    li s4,0
    j loop1
    
end:
    beqz s5,end_no

end_yes:
    la a0,true
    call printf

    j end_final

end_no:
    la a0,false
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
    