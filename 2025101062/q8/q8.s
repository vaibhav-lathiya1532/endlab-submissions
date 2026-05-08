.data
    in_fmt: .asciz "%lld"
    out_fmt: .asciz "%lld\n"
    n: .space 8
    nums: .space 8000000
    target: .space 8
    .text
.globl main
main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s0,48(sp)
    sd s1,40(sp)
    sd s2,32(sp)
    sd s3,24(sp)
    sd s4,16(sp)
    sd s5,8(sp)
    la a0,in_fmt
    la a1,n
    call scanf
    ld s0,n #s0=n
    li s1,0 #i=0
input_array:
    bge s1,s0,done_input_array
    slli t0,s1,3
    la t1,nums
    add t1,t1,t0
    mv a1,t1
    la a0,in_fmt
    call scanf
    addi s1,s1,1
    j input_array
done_input_array:
    la a0,in_fmt
    la a1,target
    call scanf
    ld s2,target #s2=target
    li s3,0 #s3=low
    addi s4,s0,-1 #s4=high
    li s5,-1 #s5=result
binary_loop:
     bgt s3,s4,done_binary_loop
     add t0,s3,s4
     srai s1,t0,1 #s1=mid
     #nums[mid]
     slli t1,s1,3
     la t2,nums
     add t2,t2,t1
     ld t3,0(t2) #t3=nums[mid]
     bne t3,s2,check_halves
     mv s5,s1
check_halves:
    slli t1,s3,3
    la t2,nums
    add t2,t2,t1
    ld t4,0(t2) #t4=nums[low]
    slli t1,s4,3
    la t2,nums
    add t2,t2,t1
    ld t5,0(t2) #t5=nums[high]
    bgt t4,t3,right_sorted
    blt s2,t4,go_right
    bgt s2,t3,go_right
    addi s4,s1,-1
    j binary_loop
go_right:
   addi s3,s1,1
   j binary_loop
right_sorted:
   blt s2,t3,go_left
   bgt s2,t5,go_left
   addi s3,s1,1
   j binary_loop
go_left:
   addi s4,s1,-1
done_binary_loop:
    la a0,out_fmt
    mv a1,s5
    call printf
    ld s5,8(sp)
    ld s4,16(sp)
    ld s3,24(sp)
    ld s2,32(sp)
    ld s1,40(sp)
    ld s0,48(sp)
    ld ra,56(sp)
    addi sp,sp,64
    li a0,0
    ret
   
