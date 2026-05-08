.section .data
fmt_in: .string "%lld %lld"
fmt_out: .string "%lld\n"
fmt_a: .string "%lld"

.section .text
.globl main

main:
addi sp, sp, -80
sd ra, 72(sp)
sd s0, 64(sp) # N 
sd s1, 56(sp) # l
sd s2, 48(sp) # arr base address
sd s3, 40(sp) # ans
sd s4, 32(sp) # right ptr

la a0,fmt_in
addi a1, sp, 16
call scanf
ld s0, 0(sp)
ld s1, 8(sp)

li t0, 0
read:
   bge t0,s0,read_done
   slli t1,t0,3
   add t1,s2,t1
   la a0,fmt_a
   mv a1, t1
   call scanf
   addi t0, t0, 1
   j  read
read_done:
     li t0, 0
addi s4, s0, -1
li t2, 1
func_loop:
   blt s4,t2,done
   addi t1, s4, -1
   slli t3,t1, 3
   add t3, t3,s2
   ld t3,0(t3)
   slli t4,s4,3
   add t4, s2, t4
   ld t4,0(t4)
   add t5,t4,t3
   bgt t5,s1,case_1
   addi s3, s3, 1
   addi s4,s4, -2
   j  func_loop

case_1:
   addi s4,s4, -1
   addi s3, s3, -1
   j  func_loop

done:
la a0, fmt_out
mv a1, s3
call printf
ld ra, 72(sp)
ld s0, 64(sp) # N 
ld s1, 56(sp) # l
ld s2, 48(sp) # arr base address
ld s3, 40(sp) # ans
ld s4, 32(sp) # right ptr
li a0, 0
ret



   





