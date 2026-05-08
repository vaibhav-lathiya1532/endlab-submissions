.section .data
fmt: .asciz "%d"
outfmt: .asciz "%d\n"
n: .word 0
arr: .space 40000
.section .text
.global main
.extern scanf
.extern printf
main:
   addi sp,sp,-48
   sd ra,40(sp)
   sd s0,32(sp)  #n
   sd s1,24(sp)  #arr
   sd s2,16(sp) #sum
   sd s3,8(sp) #i


   la a0,fmt
   la a1,n
   call scanf
   lw s0,n
   la s1,arr
   li s3,0
scan_loop:
   bge s3,s0,scan_done
   la a0,fmt
   slli t1,s3,2
   add a1,s1,t1
   call scanf

   addi s3,s3,1
   j scan_loop
scan_done:
   li s3,0 #i=0
   li s4,0 #sum=0
prime_check:
   bge s3,s0,done
   slli t1,s3,2
   add t2,s1,t1
   lw t3,0(t2) #arr[i]
   srai t4,t3,1  #arr[i]/2
   li t5,2  #(2,n/2)
loop:
   bgt t5,t4,prime
   rem t0,t3,t5
   beqz t0,next_i
   addi t5,t5,1
   j loop
prime:
   add s4,s4,t3
   j next_i
next_i:
   addi s3,s3,1
   j prime_check
done:
   la a0,outfmt
   mv a1,s4
   call printf
   ld ra,40(sp)
   ld s0,32(sp)  #n
   ld s1,24(sp)  #arr
   ld s2,16(sp) #sum
   ld s3,8(sp) #i

   li a0,0
   ret
   
   
   
   
