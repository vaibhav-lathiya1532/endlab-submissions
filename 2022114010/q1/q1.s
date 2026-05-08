.section .data
fmt_in: .string "%lld"
fmt_out: .string "%lld"

# 
#max1 = -2000
#max2 = -2000
#if (arr [i] > = max1)
#max1 = arr [i];

#else if (arr[i] < max1 && arr [i] > = max2)
#max2= arr[i]


.section .text
.globl main

main:
addi sp,sp,-64
sd a0, 56(sp)

la a0, fmt_in
sd a1, 0(sp)
call scanf

la a0, fmt_out
call printf

li a0, 0
ret











