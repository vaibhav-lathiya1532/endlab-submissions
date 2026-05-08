.data
fmt: .string "%lld"
fmt_o1: .string "%lld "
fmt_o2: .string "%lld\n"

.text
.globl main

main:
addi sp, sp, -64
sd ra, 0(sp)
sd s0, 8(sp)    #n
sd s1, 16(sp)   #array address
sd s2, 24(sp)   #i
sd s3, 32(sp)   #j
sd s4, 40(sp)

#scanning n
addi a1, sp, 48
la a0, fmt
call scanf
ld s0, 48(sp)

#creating array of size n
mul t0, s0, s0
li t1, 8
mul a0, t0, t1
call malloc
mv s1, a0

#reading
li s2, 0
l1:
bge s2, s0, l1_done
li s3, 0
l1_inner:
bge s3, s0, l1_inner_done
mul t0, s2, s0
add t0, t0, s3
li t1, 8
mul t0, t0, t1
add a1, t0, s1
la a0, fmt
call scanf
addi s3, s3, 1
j l1_inner

l1_inner_done:
addi s2, s2, 1
j l1

l1_done:
li s2, 0
l2:
bge s2, s0, l2_done
addi s3, s2, 1
l2_inner:
bge s3, s0, l2_inner_done
#getting a[i][j]
mul t0, s2, s0
add t0, t0, s3
li t5, 8
mul t0, t0, t5
add t0, t0, s1
ld t1, 0(t0)

#getting a[j][i]
mul t2, s3, s0
add t2, t2, s2
li t5, 8
mul t2, t2, t5
add t2, t2, s1
ld t3, 0(t2)

sd t3, 0(t0)
sd t1, 0(t2)

addi s3, s3, 1
j l2_inner

l2_inner_done:
addi s2, s2, 1
j l2

l2_done:
li t1, 2
div s4, s0, t1
li s2, 0
l3:
bge s2, s0, l3_done
li s3, 0
l3_inner:
bge s3, s4, l3_inner_done

#getting a[i][j]
mul t0, s2, s0
add t0, t0, s3
slli t0, t0, 3
add t0, t0, s1
ld t1, 0(t0)

#getting a[i][n-1-j]
mul t2, s2, s0
add t2, t2, s0
addi t2, t2, -1
sub t2, t2, s3
slli t2, t2, 3
add t2, t2, s1
ld t3, 0(t2)

sd t3, 0(t0)
sd t1, 0(t2)

addi s3, s3, 1
j l3_inner

l3_inner_done:
addi s2, s2, 1
j l3

l3_done:
li s2, 0
l4:
bge s2, s0, end
li s3, 0
l4_inner:
bge s3, s0, l4_inner_done
mul t0, s2, s0
add t0, t0, s3
slli t0, t0, 3
add t0, t0, s1
ld a1, 0(t0)
addi t5, s0, -1
bge s3, t5, l4_inner_done
la a0, fmt_o1
call printf
addi s3, s3, 1
j l4_inner

l4_inner_done:
mul t0, s2, s0
add t0, t0, s3
slli t0, t0, 3
add t0, t0, s1
ld a1, 0(t0)
la a0, fmt_o2
call printf
addi s2, s2, 1
j l4

end:
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld s4, 40(sp)
addi sp, sp, 64
ret
