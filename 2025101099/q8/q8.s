.section .data
fmt1: .asciz "%lld"
fmt2: .asciz "%lld\n"
not: .asciz "-1\n"
.section .text
.globl main
.extern scanf,printf
main:
     addi x2,x2.-64
     sd x1,0(x2)
     la x10,fmt1
     addi x11,x2,8
     call scanf
     ld x18,8(x2)    #x18=n
     slli x10,x18,3
     call malloc
     mv x19,x10  #arr pointer
     addi x5,x0,0
i_loop:
       bge x5,x18,r_target
       la x10,fmt1
       addi x11,x19,8
       call scanf
       ld x19,0(x11)
       addi x5,x5,1
       j i_loop
r_target:
        la x10,fmt1
        addi x11,x8,8
        call scanf
        ld x20,8(x8)
        
        addi x6,x0,0 #left
        addi x7,18,-1 #right
loop:
      bge x6,x7,not_found
      add x27,x6,x7
      srai x27,x27,1
      slli x27,x27,3
      ld x8,0(x27)  #arr[mid]
      
not_found:
       la x10,not
       call printf
       j exit
exit: 
     add x2,x2,64'
     addi x10,x0,0
     ret