.section .data
fmt: .asciz "%s"
outfmt: .asciz "%d\n"
string: .space 105

.section .text
.global main
.extern scanf
.extern printf

main:
   addi sp,sp,-24
   sd ra,16(sp)
   sd s0,8(sp)
   mv s0,sp

   la a0,fmt
   la a1,string
   call scanf
   la t0,string
loop: 
   lb t1,0(t0)
   beq t1,x0,done

   li t2,'0'
   li t3,'9'
   blt t1,t2,operator
   bgt t1,t3,operator

   addi t1,t1,-48

   addi sp,sp,-8
   sd t1,0(sp)
   j next
operator:
   ld t2,0(sp)
   addi sp,sp,8

   ld t3,0(sp)
   addi sp,sp,8

   li t4,'+'
   beq t1,t4,addit

   li t4,'-'
   beq t1,t4,subt 
    
   li t4,'*'
   beq t1,t4,multip
next:
   addi t0,t0,1
   j loop
addit:
   add t5,t3,t2
   j pushs
subt:
   sub t5,t3,t2
   j pushs
multip:
   mul t5,t3,t2
   j pushs
pushs:
   addi sp,sp,-8
   sd t5,0(sp)
   j next
done:
   la a0,outfmt
   ld a1,0(sp)
   call printf
   mv sp,s0
   ld s0,8(sp)
   ld ra,16(sp)
   addi sp,sp,24
   li a0,0
   ret

   