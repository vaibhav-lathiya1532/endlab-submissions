addi x3,x0,0
sub x4,x2,x1
addi x5,x0,4
addi x6,x0,1
addi x7,x0,2
loop:
bge x3,x5,loop_end
beq x3,x0,first #done
beq x3,x6,second
beq x3,x7,third
addi x8,x0,1
mv a0,x4
mv a1,x8
call divi
mv x1,a0
la a0,output 
mv a1,x1
call printf

first:
addi a1,x0,25
mv a0,x4
mv t1,x4
call divi
mv t2,a0

la a0,output
mv a1,t2
call printf
mv a0,t1
call rema
mv x4,a0
addi x3,x3,1
j loop

second:
addi a1,x0,10
mv a0,x4
mv t1,x4
call divi
mv t2,a0

la a0,output
mv a1,t2
call printf
mv a0,t1
call rema
mv x4,a0
addi x3,x3,1
j loop

third:
addi a1,x0,5
mv a0,x4
mv t1,x4
call divi
mv t2,a0

la a0,input
mv a1,t2
call printf
mv a0,t1
call rema
mv x4,a0
addi x3,x3,1
j loop
loop_end:
ret
divi:
init_d:
mv x1,a0
mv x2,a1
addi x3,x0,0
loop_d:
bge x1,x2,divi_continue
mv a0,x3
ret
divi_continue:
sub x1,x1,x2
addi x3,x3,1
j loop_d

rema:
init_r:
mv x1,a0
mv x2,a1
loop_r:
bge x1,x2,rema_continue
mv a0,x1
ret
rema_continue:
sub x1,x1,x2
j loop_r