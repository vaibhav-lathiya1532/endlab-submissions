.section .rodata
fmt_in: .string "%d %d"
fmt_out: .string "%d %d %d %d\n"

.section .text
.globl main
main:
addi sp,sp,-56;
sd ra,8(sp);
sd s1,16(sp); #money balance
sd s2,24(sp); #25
sd s3,32(sp); #10
sd s4,40(sp); #5

lla a0,fmt_in;
addi a1,sp,0;
addi a2,sp,48;
call scanf;
lw t0,0(sp);
lw s1,48(sp);
sub s1,s1,t0;

li s2,0;
li s3,0;
li s4,0;

number_of_25:
li t0,25;
blt s1,t0,number_of_10;
addi s1,s1,-25;
addi s2,s2,1;
j number_of_25;

number_of_10:
li t0,10;
blt s1,t0,number_of_5;
addi s1,s1,-10;
addi s3,s3,1;
j number_of_10;

number_of_5:
li t0,5;
blt s1,t0,number_of_1;
addi s1,s1,-5;
addi s4,s4,1;
j number_of_5;

number_of_1:
end:
lla a0,fmt_out;
addi a1,s2,0;
addi a2,s3,0;
addi a3,s4,0;
addi a4,s1,0;
call printf;

ld ra,8(sp);
ld s1,16(sp); 
ld s2,24(sp); 
ld s3,32(sp); 
ld s4,40(sp);
addi sp,sp,56;
ret;



