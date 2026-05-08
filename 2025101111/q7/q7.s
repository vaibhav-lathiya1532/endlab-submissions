.section .data
strin: .string "%s"
true: .string "TRUE\n"
false: .string "FALSE\n"
num: .space 16

.section .text
.globl main
.extern scanf
.extern printf
.extern atoi

main:
     addi sp, sp, -48
     sd ra, 0(sp)
     sd s0, 8(sp) #for str starting addr
     sd s1, 16(sp) #for str idx
     sd s2, 24(sp) #for pow idx
     sd s3, 32(sp) #total sum

     la a0, strin
     la a1, num
     call scanf

     la s0, num
     mv s1, x0
     mv s3, x0

loop_out:
         add t0, s0, s1
         lb t0, 0(t0)
         beq t0, x0, end_all

         addi t0, t0, -48 
         mv s2, x0 #s2=0
         mv t1, t0

loop_in:
        beq s2, s1, next
        mul t1, t1, t0
        addi s2, s2, 1
        jal x0, loop_in
next:
     add s3, s3, t1
     addi s1, s1, 1
     jal x0, loop_out

end_all:
        la a0, num
        call atoi

        beq s3, a0, tru 
        la a0, strin
        la a1, false
        call printf

        la a0, strin
        mv a1, s3
        call printf

        ld ra, 0(sp)
        ld s0, 8(sp)
        ld s1, 16(sp)
        ld s2, 24(sp)
        ld s3, 32(sp)
        addi sp, sp, 48
        mv a0, x0
        ret
tru:
        la a0, strin
        la a1, true
        call printf

        ld ra, 0(sp)
        ld s0, 8(sp)
        ld s1, 16(sp)
        ld s2, 24(sp)
        ld s3, 32(sp)
        addi sp, sp, 48
        mv a0, x0
        ret