.section .rodata
fmt_in: .string "%d"
fmt_out: .string "%d\n"
.setion text
.global main
main
addi sp, sp, 


li t1, 1
loop:
beq t1, t0, done
mul t3, t1, 8
lla a0, fmt_in
add a1, sp, t3 
call scanf
done:
