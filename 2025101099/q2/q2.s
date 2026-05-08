.section .data
fmt1: .asciz "%lld"
fmt2: .asciz "%lld\n"
.section .text
.extern scanf,printf,malloc
.globl main 
main:
      addi x2,x2,-32
      sd x1,0(x2)
      la x10,fmt1
      addi x11,x2,8
      call scanf
      ld x18,8(x2)   #x18=n
      la x10,fmt1
      addi x11,x2,16
      call scanf
      ld x19,16(x2)   #x19=l
      slli x10,x18,3
      call malloc
      mv x20,x10    #arr pointer
      addi x5,x0,0   #i=0
loop:
     bge x5,x18,idx
     la x10,fmt1
     addi x11,x20,0
     call scanf
     addi x20,x20,8
     addi x5,x5,1
     j loop
idx:  
     addi x5,x0,0  #left
     addi x6,x18,-1 #right
     addi x21,x0,0   #count=0
main_loop:
          bge x5,x6,end
          slli x28,x5,3
          add x29,x20,x28 #arr[l]
          slli x28,x6,3
          add x30,x20,x28 #arr[r]
          add x7,x29,x30
          bge x7,x19,cond
          addi x5,x5,1
          addi x6,x6,-1
          addi x21,x21,1
          j main_loop
cond:
     addi x6,x6,-1
     addi x21,x21,1
     j main_loop
end:
     la x10,fmt2
     addi x11,x21,0
     call printf
     ld x1,0(x2)
     addi x2,x2,32
     addi x10,x0,0
     ret

