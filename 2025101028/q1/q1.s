.data

input:  .string "%d"
output: .string "%d\n"
arr: .space 400

n: .word 0
.text
.global main

main:
   
   addi sp,sp,-48
   sd ra,40(sp)
   sd s0,32(sp)  # address of arr
   sd s1,24(sp)   # size of array
   sd s2,16(sp)  #  first largest
   sd s3,8(sp)   # second largest

    la a0,input
    la a1,n
    call scanf

    mv s1,a1
    mv s0,arr

    li t0,0

input_loop: 
     
    beq t0,s1,input_done
    

    