.section .rodata
fmt_in: .string "%ld"
fmt_out_true: .string "TRUE\n"
fmt_out_false: .string "FALSE\n"

.section .data
.align 3
arr: .zero 800000

.section .text
.globl main
main:
addi sp,sp,-96;
sd ra,16(sp);
sd s1,32(sp); #n
sd s2,48(sp); #pointer
sd s3,64(sp); #counter
sd s4,80(sp); #parity

lla a0,fmt_in;
addi a1,sp,0;
call scanf;
ld s1,0(sp);

lla a0,fmt_in;
ld a1,arr;
call scanf;
ld s2,arr;

ld t0,0(s2);
andi s4,t0,1;
li s3,1;
loop:
bge s3,s1,true;
slli t0,s3,3;
add t1,t0,s2;
ld t2,0(t1);
andi t3,t2,1;
beq t3,s4,false;
addi s4,t3,0;
addi s3,s3,1;
j loop;

true:
lla a0,fmt_out_true;
call printf;
j end;

false:
lla a0,fmt_out_false;
call printf;

end:
ld ra,16(sp);
ld s1,32(sp); 
ld s2,48(sp);
ld s3,64(sp); 
ld s4,80(sp);
addi sp,sp,96;
ret;
