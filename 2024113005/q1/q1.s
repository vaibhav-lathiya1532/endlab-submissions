.data 
input_ar:   .space  800000
input_arr:  .string "%lld"
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

li t1 , 0 #i = 0 
la a0 , input_arr

#read_arr:
#beq t1 , s0 ,calculation
#la a1 ,input_arr
#slli t1 , t1 , 3#add t3 , t1 , a1
#la a2 , t3 
#call scanf
#ld t4 , 0(t3) 
#addi t1 , t1 , 1 #i++ 
#j read_arr 


#calculation:
#ld t1 , 0(t3) 
andi t5 , t1 , 1 
beqz t5 , even_odd 

li t1 , 0 #i = 0 

odd_even:
beq t1 , s0 ,yes 

odd:
ld t2 , 0(t3)
addi t1 , t1 , 1 
andi t3 , t2 ,1 
beqz t3 , no

even:
li t6 , 1
ld t2 , 0(t3)
addi t1 , t1 , 1 
andi t3 , t2 ,1 
beq t3 , t6 , no
j odd_even 


even_odd:
beq t1 , s0 , yes
even1:
li t6 , 1
ld t2 , 0(t3)
addi t1 , t1 , 1 
andi t3 , t2 ,1 
beq t3 , t6 , no

odd1:
ld t2 , 0(t3)
addi t1 , t1 , 1 
andi t3 , t2 ,1 
beqz t3 , no
j even_odd


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