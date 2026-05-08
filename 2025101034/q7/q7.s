.data
fmt_scan: .string "%lld"
fmt_print: .string "lld\n"
fmt_true: .string "TRUE\n"
fmt_false: .string "FALSE\n"
n: .dword 0

.global main
main:
addi sp, sp, -32
sd ra, 24(sp)
sd s0, 16(sp)
sd s1, 8(sp)

la a0, fmt_scan
la a1, n
call scanf
ld s0, n #s0=n

li t0, 10 #t0=10
li t1, 0 #cnt=0
mv t2, s0#t2=s0

digit_cnt:
ble t2, zero, done #n<=0
div t2, t2, t0  #n=n/10
addi t1, t1, 1 #cnt++
j digit_cnt

loop:
ble s0, zero, done # n<=0
rem t3, t2, t0  #t3 = last digit
li t2, 0 #sum=t2=0

li t4, 1
inner_loop:
ble t1, zer0, inner_done #cnt--
mul t2, t3, t3


sd ra, 24(sp)
sd s0, 16(sp)
sd s1, 8(sp)
addi sp, sp, 32
li a0 0
ret