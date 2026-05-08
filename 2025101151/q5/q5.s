.data
input: .string "%lld"
output: .string "%lld "
newline: .string "\n"

.text
.global main

main:

addi sp,sp,-64
sd x1,56(sp)
sd x9,48(sp)
sd x18,40(sp)   # x18=i
sd x19,32(sp)   # x19=j
sd x20,24(sp)
sd x21,16(sp)

la x10,input
addi x11,sp,0
call scanf
ld x9,0(sp)    # x9=n

mul x10,x9,x9
slli x10,x10,3
call malloc


mv x20,x10     # x20=base address
li x18,0
read_i:
bge x18,x9,transposego
li x19,0
read_j:
bge x19,x9,end_j
mul x5,x18,x9
add x5,x5,x19
slli x5,x5,3
add x11,x20,x5
la x10,input
call scanf
addi x19,x19,1
j read_j
end_j:
addi x18,x18,1
j read_i
transposego:
li x18,0
li x19,0

transpose:
bge x18,x9,reversego
addi x19,x18,1
innerread:
bge x19,x9,endr
mul x5,x18,x9
add x5,x5,x19
slli x5,x5,3
add x5,x5,x20
ld x6,0(x5)

mul x7,x19,x9
add x7,x7,x18
slli x7,x7,3
add x7,x7,x20
ld x8,0(x7)

sd x6,0(x7)
sd x8,0(x5)

addi x19,x19,1
j innerread
endr:
addi x18,x18,1
j transpose
reversego:
li x18,0
reverse:
bge x18,x9,print
li x19,0
addi x21,x9,-1
swap:
bge x19,x21,ne_i

mul x7,x18,x9
add x7,x7,x19
slli x7,x7,3
add x7,x7,x20
ld x8,0(x7)

mul x5,x18,x9
add x5,x5,x21
slli x5,x5,3
add x5,x5,x20
ld x6,0(x5)
sd x6,0(x7)
sd x8,0(x5)
addi x19,x19,1
addi x21,x21,-1
j swap
ne_i:
addi x18,x18,1
j reverse

print:

li x18,0
print_i:
bge x18,x9,end
li x19,0
print_j:
bge x19,x9,endp_j
mul x5,x18,x9
add x5,x5,x19
slli x5,x5,3
add x5,x20,x5
ld x11,0(x5)
la x10,output
call printf
addi x19,x19,1
j print_j
endp_j:
la x10,newline
call printf
addi x18,x18,1
j print_i

end:

ld x1,56(sp)
ld x9,48(sp)
ld x18,40(sp)   # x18=i
ld x19,32(sp)   # x19=j
ld x20,24(sp)
ld x21,16(sp)
addi sp,sp,64
ret