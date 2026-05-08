.data 
fmt: .asciz "%lld"
tru: .asciz "TRUE\n"
fal: .asciz "FALSE\n"

.text
.global main
main:
addi sp, sp, -80
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)

la a0, fmt
addi a1, sp, 40
call scanf
ld s0, 40(sp)            # s0 has my int

addi s1, x0, 1        #s1 will have digits
addi t0, x0,10       #t0 has10
addi t1, s0,0
loop:
div t1,t1, t0
beq t1, x0, break
addi s1,s1,1
j loop

break:
addi t0, x0,10       #t0 has 10
addi s3, x0, 0      # store ans s3
addi t1, s1, 0 #i=n
l1:
beq s0, x0, print   #
rem t5, s0, t0
div s0, s0, t0

addi t4, x0, 1
addi t2, t1, 0 #j
l2:
beq t2, x0, done
mul t4, t4,t5
addi t2, t2, -1
j l2

done:
add s3, s3, t4
addi t1, t1, -1
j l1

print:
ld s0, 40(sp)
beq s3, s0, yes

no:
la a0, fal
call printf
j exit

yes:
la a0, tru
call printf
j exit

exit:
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld ra, 0(sp)
addi sp, sp, 80
ret