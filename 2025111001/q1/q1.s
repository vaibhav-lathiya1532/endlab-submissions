.section .data
fmt_in1 : .string "%lld\n"
fmt_in2 : .string "%lld "
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

la a0,fmt_in1
call scanf

mv s0,a0                            #s0 stores value of N
mv t0,s0                            #working value of N(stores remainder)

array_reader:
beqz t0,div_checker
la a0,fmt_in2
call scanf
addi sp,sp,-8
ld 


div_checker:


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