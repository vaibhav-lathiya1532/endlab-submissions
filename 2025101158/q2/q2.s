.section .rodata

fmtfirst: .string "%lld %lld"
output: .string "%lld %lld\n"
newline: .string "\n"

.section .text

.global main

main:
    addi sp, sp, -256
    sd ra, 248(sp)
    sd s0, 240(sp) #firstnum
    sd s1, 232(sp) #secnum
    sd s2, 224(sp) #gcd counter
    sd s3, 216(sp) #smaller number
    sd s4, 208(sp)#final gcd ans
    sd s5, 200(sp) #final lcm ans

    lla a0, fmtfirst
    addi a1, sp, 8
    addi a2, sp, 16
    call scanf
    ld s0, 8(sp)
    ld s1, 16(sp)


    blt s0, s1, smaller
    mv s3, s0
    j init
  
smaller: 
    mv s3,s1
    j init

init:
li s4, 1
mv s2, x0

gcd:
    beq s3, s2, lcm
    rem t0, s0, s2
    beq t0, x0, gcdnext
    addi s2, s2, 1 
    j gcd

gcdnext:
    rem t0, s1, s2
    beq t0, x0, buff
    addi s2, s2, 1
    j gcd

buff:
    mv s4, s2
    addi s2,s2,1
    j gcd


lcm:
    mul t1, s0, s1
    div t1, t1, s4
    mv  s5, t1

exit:
    lla a0, output
    mv a1, s4
    mv a2, s5
    call printf
       
    ld ra, 248(sp)
    ld s0, 240(sp) #firstnum
    ld s1, 232(sp) #secnum
    ld s2, 224(sp) #gcd counter
    ld s3, 216(sp) #smaller number
    ld s4, 208(sp)#final gcd ans
    ld s5, 200(sp) #final lcm ans
    addi sp, sp, 256
    ret








    