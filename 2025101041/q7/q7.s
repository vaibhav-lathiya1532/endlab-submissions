.data
fmt: .asciz "%d"
true: .asciz "TRUE\n"
false: .asciz "FALSE\n"

.text
.extern printf
.extern scanf
.globl main

main:
addi sp,sp,-32
sd ra,24(sp)
sd s0,16(sp)
sd s1,8(sp)

la a0,fmt
mv a1,sp
call scanf
ld t0,0(sp)                 #t0=n=s0
addi s0,t0,0
li t2,0                      #len=0=t2
li t1,10

loop:
beq t0,x0,len_done
div t0,t0,t1
addi t2,t2,1
j loop
                            
len_done:
li s1,0                      #sum=s1
addi t0,s0,0

loop1:
beq t0,x0,done
rem t3,t0,t1            #t3=curr digit
mv t4,t2                #t4 j=curr len
li t5,1
loop2:
beq t4,x0,done2
mul t5,t5,t3
addi t4,t4,-1
j loop2

done2:
addi t2,t2,-1
add s1,s1,t5
div t0,t0,t1
j loop1

done:
beq s0,s1,triue
la a0,false
call printf
j exit

triue:
la a0,true
call printf

exit:
ld ra,24(sp)
ld s0,16(sp)
ld s1,8(sp)
addi sp,sp,32
ret
