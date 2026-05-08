.section .rodata

infmt:
.string "%lld"

outfmt:
.string "%lld "

newline:
.string "\n"

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
ld s0, 8(sp)                    #s0 now contains m

lla a0, infmt
addi a1, sp, 8
call scanf
ld s1, 8(sp)                    #s1 now contains n

mv t0, s0                       #t0 contains dynamic m
mv t1, s1                       #t1 contains dynamic n
whileloop:
beq t1, zero, endwhileloop
mv t3, t0                       #t3 contains copy of m
mv t0, t1                       #m=n
rem t3, t3, t1                  #t3 contains m%n
mv t1, t3                       #n=m%n
j whileloop
endwhileloop:
mv s2, t0                       #s2 contains the gcd

lla a0, outfmt
mv a1, s2
call printf

lla a0, outfmt
mul t0, s0, s1                  #t0 contains m*n
div a1, t0, s2                  #a1 contains lcm which is n*m/gcd
call printf

lla a0, newline
call printf

ld s0, 16(sp)
ld s1, 24(sp)
ld s2, 32(sp)
ld s3, 40(sp)
ld ra, 0(sp)
addi sp, sp, 48
mv a0, zero                     #return 0
ret
