.data
fmt: .string "%lld"
fmt_out1: .string "%lld "
fmt_out2: .string "%lld\n"

.text
.globl main

main:
addi sp, sp, -64
sd ra, 0(sp)
sd s0, 8(sp)    #Number 1
sd s1, 16(sp)   #Number 2
sd s2, 24(sp)   #HCF
sd s3, 32(sp)   #GCD
sd s4, 40(sp)

#Scanning Number 1
addi a1, sp, 48
la a0, fmt
call scanf
ld s0, 48(sp)

#scanning Number 2
addi a1, sp, 48
la a0, fmt
call scanf
ld s1, 48(sp)

rem t5, s0,s1
bne t5,x0, inter1
la a0, fmt_out1
mv a1, s1
call printf
la a0, fmt_out2
mv a1, s0
call printf
j end

inter1:
rem t5, s1, s0
bne t5, x0, inter2
la a0, fmt_out1
mv a1, s0
call printf
la a0, fmt_out2
mv a1, s1
call printf
j end

inter2:
#Checking which is bigger
bge s0, s1, one_big

two_big:
rem t5, s1, s0
srli t0, s0, 1
mv s4, t0
li t0, 1
loop1:
bgt t0, s4, HCF_done
rem t1, s0, t0
rem t2, s1, t0
beq t1,x0, con
j next
con:
beq t2,x0, conf
j next
conf:
mv s2, t0
j next
next:
addi t0, t0, 1
j loop1


one_big:
srli t0, s1, 1
mv s4, t0
li t0, 1
loop2:
bgt t0, s4, HCF_done
rem t1, s0, t0
rem t2, s1, t0
beq t1,x0, con1
j next1
con1:
beq t2,x0, conf1
j next1
conf1:
mv s2, t0
j next1
next1:
addi t0, t0, 1
j loop2


HCF_done:
mul s3, s0, s1
div s3, s3, s2

#printing HCF
la a0, fmt_out1
mv a1, s2
call printf

#printing LCM
la a0, fmt_out2
mv a1, s3
call printf

end:
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld s4, 40(sp)
addi sp, sp, 64
ret