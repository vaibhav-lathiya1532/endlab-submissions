.section .rodata

infmt:
.string "%lld"

outfmt:
.string "%lld\n"

.section .text

.globl main
main:
addi sp, sp, -48
sd ra, 0(sp)
#8(sp) is being used for scanf
sd s0, 16(sp)
sd s1, 24(sp)
sd s2, 32(sp)
sd s3, 40(sp)

lla a0, infmt
addi a1, sp, 8
call scanf
ld s0, 8(sp)                    #s0 now contains n

mv a0, s0                       #a0 contains n
slli a0, a0, 3                  #a0 contains n*8
call malloc
mv s1, a0                       #s1 contains arr

mv s2, zero                     #s2 contains i=0
inputforloop:
bge s2, s0, endinputforloop
slli t0, s2, 3                  #t0 contains i*8
add t0, t0, s1                  #t0 contains addr of arr[i]
mv a1, t0                       #a1 contains addr of arr[i]
lla a0, infmt
call scanf
addi s2, s2, 1                  #i++
j inputforloop
endinputforloop:

lla a0, infmt
addi a1, sp, 8
call scanf
ld s2, 8(sp)                    #s2 now contains t

mv t0, zero                     #t0 contains lp
addi t1, s0, -1                 #t1 contains rp
whileloop:
bgt t0, t1, endwhileloop
add t2, t0, t1
srai t2, t2, 1                  #t2 contains m
slli t3, t2, 3                  #m*8
add t3, t3, s1                  #addr of arr[m]
ld t3, 0(t3)                    #t3 contains val of arr[m]
beq t3, s2, found
slli t4, t0, 3                  #lp*8
add t4, t4, s1                  #addr of arr[lp]
ld t4, 0(t4)                    #t4 contains val of arr[lp]
slli t5, t1, 3                  #rp*8
add t5, t5, s1                  #addr of arr[rp]
ld t5, 0(t5)                    #t5 contains val of arr[rp]
bgt t4, t3, rightsorted
bgt t4, s2, inright
bgt s2, t3, inright
#this runs if its in the left
addi t1, t2, -1
j whileloop

inright:
addi t0, t2, 1
j whileloop

rightsorted:
bgt t3, s2, inleft
bgt s2, t5, inleft
#this runs if its in the right
addi t0, t2, 1
j whileloop

inleft:
addi t1, t2, -1
j whileloop

endwhileloop:
lla a0, outfmt
addi a1, zero, -1
call printf
j exit

found:
lla a0, outfmt
mv a1, t2
call printf

exit:
ld s0, 16(sp)
ld s1, 24(sp)
ld s2, 32(sp)
ld s3, 40(sp)
ld ra, 0(sp)
addi sp, sp, 48
mv a0, zero                     #return 0
ret
