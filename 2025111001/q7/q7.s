.section .data
fmt_in : .string "%lld\n"
true_str: .string "TRUE"
false_str: .string "FALSE"

.section .text
.global main

main:

addi sp,sp,-32
sd ra, 24(sp)
sd s0, 16(sp)
sd s1, 8(sp)
sd s2, 0(sp)

la a0,fmt_in
call scanf

mv s0,a0                            #s0 stores value of N
mv t0,s0                            #working value of N(stores remainder)
li t1,10                            #divisor
li t2,0                             #quotient
li s1,0                             #digit counter


digitcounter_loop:
beqz t0,digitcounter_loop_done

digit_div:
blt t0,t1,digit_div_done
sub t0,t0,t1
addi t2,t2,1
j digit_div

digit_div_done:
mv t0,t2
addi s1,s1,1
j digitcounter_loop

digitcounter_loop_done:
li s2,0                               #total sum of powers of digits

compute_loop:
beqz s1,compute_loop_done
mv t5,s1                              #working value of number of digits
mv t0,s0                              #working value of N(stores remainder)
li t1, 10                             #divisor
li t2,0                               #quotient

digit_div2:
blt t0,t1,toaddtosum_loop
sub t0,t0,t1
addi t2,t2,1
j digit_div2

toaddtosum_loop:
li t6,1

get_powers:
beqz t5,addem_loop
mul t6,t6,t0
addi t5,t5,-1
j get_powers

addem_loop:
mv s0,t2
addi s1,s1,-1
add s2,s2,t6
j compute_loop

compute_loop_done:
beq s2,s0,print_true
la a0,false_str
call printf
j done 

print_true:
la a0,true_str
call printf

done:
ld ra, 24(sp)
ld s0, 16(sp)
ld s1, 8(sp)
ld s2, 0(sp)
addi sp,sp,32

li a0,0
ret