.bss
a: .space 800000

.data
inp: .string "%lld"
out: .string "%lld\n"

.text
.globl main
main:

addi sp, sp, -48
sd ra, 32(sp)
sd s0, 24(sp)   #n
sd s1, 16(sp)   #load 
sd s2, 8(sp)    #array address

#take input of n and load
la x10, inp
addi x11, sp, 40
call scanf
ld s0, 40(sp)   #now s0 has n 

la x10, inp
addi x11, sp, 40
call scanf
ld s1, 40(sp)   #now s1 has load


li t0, 0    #int i = 0
la s2, a
input:
beq t0, s0, doneinp
sd t0, 0(sp)
la x10, inp
addi x11, sp, 40
call scanf
ld t1, 40(sp)   #elemt is in t1
ld t0, 0(sp)   
slli t2, t0, 3
add t2, s2, t2
sd t1, 0(t2)
addi t0, t0, 1
j input

doneinp:
#now intialise left and right pointers
li t0, 0    #left
addi t1, s0, -1 #right
li t2, 0    #cnt

loop:
bge t0, t1, end

#load a[left]
slli t3, t0, 3
add t3, t3, s2
ld t4, 0(t3)    #t4 has a[left]

#load a[right]
slli t3, t1, 3
add t3, t3, s2
ld t5, 0(t3)    #t5 has a[right]

add t6, t4, t5
blt s1, t6, onlyright

#both l and r move as sum is <= load
addi t0, t0, 1
addi t1, t1, -1
addi t2, t2, 1
j loop

onlyright:
addi t1, t1, -1
addi t2, t2, 1
j loop

end:
beq t0, t1, onemore
j done

onemore:
addi t2, t2, 1

done:
#print the value in t2
la x10, out
mv x11, t2
call printf
ld ra, 32(sp)
ld s0, 24(sp)  
ld s1, 16(sp)  
ld s2, 8(sp) 
addi sp, sp, 48
li x10, 0
ret


