.section .data
strin: .string "%lld"
strout: .string "%lld\n"

.section .text
.globl main
.extern printf
.extern scanf
.extern malloc

main:
     addi sp, sp, -64
     sd ra, 0(sp)
     sd s0, 8(sp)   #malloc start
     sd s1, 16(sp) #n
     sd s2, 24(sp) #for i
     sd s3, 32(sp) #for max element
     sd s4, 40(sp)  #for second max

     li s3, 1000001
     li s4, 1000001

     la a0, strin
     addi a1, sp, 48
     call scanf

     ld s1, 48(sp)
     mv a0, s1
     slli a0, a0, 3
     call malloc

     mv s0, a0
     mv s2, x0

inp_loop:
         beq s2, s1, end_all

         la a0, strin
         slli t0, s2, 3
         add t0, t0, s0
         mv a1, t0
         call scanf

         slli t0, s2, 3
         add t0, t0, s0

         li t1, 1000001
         ld t2, 0(t0)
         beq s3, t1, max_fill
         bgt t2, s3, update_max1 #curr ele > max
         blt t2, s3, update_max2 #curr ele<max
         addi s2, s2, 1
         jal x0, inp_loop

max_fill:
         mv s3, t2
         addi s2, s2, 1
         jal x0, inp_loop

update_max1:
            mv s4, s3
            mv s3, t2
            addi s2, s2, 1
            jal x0, inp_loop

update_max2:
            beq s4, t1, except
            ble t2, s4, next
            mv s4, t2
            addi s2, s2, 1
            jal x0, inp_loop

next:
     addi s2, s2, 1
     jal x0, inp_loop

except:
       mv s4, t2
       addi s2, s2, 1
       jal x0, inp_loop

end_all:
        la a0, strout
        mv a1, s4
        call printf

        ld ra, 0(sp)
        ld s0, 8(sp)
        ld s1, 16(sp)
        ld s2, 24(sp)
        ld s3, 32(sp)
        ld s4, 40(sp)
        addi sp, sp, 64

        mv a0, x0
        ret