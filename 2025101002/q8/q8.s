.bss
a: .space 800000

.data
inp: .string "%lld"
out: .string "%lld\n"
not: .string "-1\n"

.text
.globl main
main:
addi sp, sp, -48
sd ra, 32(sp)
sd s0, 24(sp)   #n
sd s1, 16(sp)   #array base address
sd s2, 8(sp)    #target

la x10, inp
addi x11, sp, 40
call scanf
ld s0, 40(sp)   #s0 now has n

li t0, 0    #int i = 0
la s1, a
input:
beq t0, s0, doneinp
sd t0, 0(sp)
la x10, inp
addi x11, sp, 40
call scanf
ld t1, 40(sp)   #elemt is in t1
ld t0, 0(sp)   
slli t2, t0, 3
add t2, s1, t2
sd t1, 0(t2)
addi t0, t0, 1
j input

doneinp:

#now we take target input
la x10, inp
addi x11, sp, 40
call scanf
ld s2, 40(sp)   #s2 now has target

li t0, 0    #low
addi t1, s0, -1 #high

binsearch:
blt t1, t0, notfound

add t2, t0, t1
srli t2, t2, 1  #mid

#get a[low]
slli t3, t0, 3
add t3, s1, t3
ld t4, 0(t3)    #t4 has a[low]

#get a[mid]
slli t3, t2, 3
add t3, s1, t3
ld t5, 0(t3)    #t5 has a[mid]

#get a[high]
slli t3, t1, 3
add t3, t3, s1
ld t6, 0(t3)    #t6 has a[high]

beq s2, t5, found

blt t4, t5, leftsorted

rightsorted:
bge t5, s2, notright
blt t6, s2, notright
addi t0, t2, 1  #low = mid+1
j binsearch

notright:
addi t1, t2, -1  #high = mid-1
j binsearch

leftsorted:
blt s2, t4, notleft
bge s2, t5, notleft
addi t1, t2, -1 #high = mid-1
j binsearch

notleft:
addi t0, t2, 1  #low = mid+1
j binsearch

found:
la x10, out
mv x11, t2
call printf
j done

notfound:
la x10, not
call printf

done:
ld ra, 32(sp)
ld s0, 24(sp)  
ld s1, 16(sp)   
ld s2, 8(sp)
addi sp, sp, 48
li x10, 0
ret


