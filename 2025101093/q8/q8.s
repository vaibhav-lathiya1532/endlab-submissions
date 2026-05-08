.section .rodata
input: .string "%lld"
output: .string "%lld\n"

.section .bss
n_val: .space 8
target: .space 8
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


    la a1,target
    la a0,input
    call scanf

#==========================================
    mv s0,zero
    la s1,n_val
    ld s1,0(s1)
    li s2,-1
    la s3,target
    ld s3,0(s3)

loop:
bgt s0,s1,end_loop
    add t0,s0,s1
    srli t0,t0,1

#===========================
    la t4,arr
    mv t5,t0
    slli t5,t5,3
    add t4,t4,t5
    ld t1,0(t4)

    la t4,arr
    mv t5,s0
    slli t5,t5,3
    add t4,t4,t5
    ld t2,0(t4)

    la t4,arr
    mv t5,s1
    slli t5,t5,3
    add t4,t4,t5
    ld t3,0(t4)
#===========================

bne s3,t0,continue
    mv s2,t0
    j end_loop
continue:

ble t2,t1,lower
#====upper
    bgt t1,s3,um1
    ble s3,t3,lp1
    j um1

lower:
    bgt s3,t1,lp1
    ble t2,s3,um1
    j lp1

#===========================

um1:
    addi s1,t0,-1
j end_update
lp1:
    addi s0,t0,1

end_update:
#===========================
    j loop
end_loop:

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
