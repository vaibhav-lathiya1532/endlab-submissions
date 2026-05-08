.section .rodata
input: .string "%lld"
output: .string "%lld\n"

.section .bss
n_val: .space 8
l_val: .space 8
arr: .space 800000

.text

.global main
main:
    addi sp,sp,-48
    sd ra,0(sp)
    sd s0,8(sp)
    sd s1,16(sp)
    sd s2,24(sp)
    sd s3,32(sp)
    sd s4,40(sp)

    la a1,n_val
    la a0,input
    call scanf

    la a1,l_val
    la a0,input
    call scanf

    la s0,n_val
    ld s0,0(s0)
    mv s1,zero
    la s2,arr

scanf_loop:
    ble s0,s1,end_scan_loop

    la a0,input
    mv a1,s2
    call scanf

    addi s1,s1,1
    addi s2,s2,8
    j scanf_loop
end_scan_loop:

#==========================================
    la s0,n_val
    ld s0,0(s0)
    slli s1,s0,3
    addi s1,s1,-8

    la s0,arr
    add s1,s1,s0
    mv s2,zero
    la s3,l_val
    ld s3,0(s3)

loop:
    bgt s0,s1,loop_end
    
    bne s0,s1,continue
    addi s2,s2,1
    j loop_end
continue:

    ld t1,0(s0)
    ld t2,0(s1)
    add t0,t1,t2
    bgt t0,s3,fat_only
    
    addi s2,s2,1
    addi s0,s0,8
    addi s1,s1,-8
    j end_of_if

fat_only:
    addi s2,s2,1
    addi s1,s1,-8

end_of_if:

    j loop
loop_end:
#==========================================

    la a0,output
    mv a1,s2
    call printf

    ld ra,0(sp)
    ld s0,8(sp)
    ld s1,16(sp)
    ld s2,24(sp)
    ld s3,32(sp)
    ld s4,40(sp)
    addi sp,sp,48

    ret
