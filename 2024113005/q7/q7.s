.data 
input_fmt:  .string "%lld"
true_msg:   .string "TRUE\n"
false_msg:  .string "FALSE\n" 

.text
.globl main 

main:
addi sp , sp , -16
sd ra , 0(sp)
addi a0  , sp , 8
call scanf 
ld s0 , 8(sp) #s0 = N 
addi t0 , s0 , 0 #t0 = N , copy for cal
li t1 , 0 # t1 = length  
li t2 , 10 

length_calculation:
beqz t0 , length_done 
rem t3 , t0 , t2 
div t0 , t0 , t2 
addi t1 , t1 , 1 #length++ 
j length_calculation

length_done:
mv t0 , s0 
mv t3 , t1 #t3 = power 
j intialization

intialization:
addi  t4 , t3 , 0  #power for every digit 
li t1 , 0 #t1 = sum 
j logic 

logic:
beqz t3 , check_sum 
li t5 , 1 #result of mul 
rem t6 , t0 , t2 
div t0 , t0 , t2 

power_calculation:
beqz t4 , power_done
mul t5 , t5 , t6 #result *= digit 
addi t4 , t4 , -1 
j power_calculation

power_done:
add t1 , t1 , t5 #sum+= digit^power
addi t3 , t3 , -1 
mv t4 , t3 
j logic 

check_sum:
beq s0 , t1 , yes 
 
 no:
la a0 , false_msg
call printf
j exit 

yes:
la a0 , true_msg
call printf


exit:
ld ra , 0(sp)
addi sp , sp  ,16
li a0 , 0 
ret 



