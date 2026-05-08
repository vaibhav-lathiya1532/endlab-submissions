.data 
  inp :.string "%ld"
  out: .string "%ld\n"
.text
.globl main
main:
  addi sp,sp,-80
  sd ra,8(sp)
  sd s0,16(sp)  #s0=arrstart
  sd s1,24(sp)  #s1=n
  sd s2,32(sp)  #s2=i
  sd s3,40(sp)  #s3=maxweight
  sd s4,48(sp) #s4=ans
la a0,inp
addi a1,sp,0
call scanf
ld s1,0(sp)
la a0,inp
addi a1,sp,0
call scanf
ld s3,0(sp)
slli a0,s1,3
call malloc
addi s0,a0,0
addi s2,s1,-1
loop:
  blt s2,x0,loopdone
  slli t0,s2,3
  add a1,t0,s0
  la a0,inp
  call scanf
  addi s2,s2,-1
  j loop
loopdone:
  addi s4,x0,0
  addi s2,x0,0
  addi t5,s1,-1
  loop1:
    bge s2,t5,done
    slli t0,s2,3
    add t0,t0,s0
    ld t1,0(t0)
    slli t0,t5,3
    add t0,t0,s0
    ld t2,0(t0)
    add t3,t1,t2
    bgt t3,s3,take_one
    addi s4,s4,1
    addi s2,s2,1
    addi t5,t5,-1
    j loop1
  take_one:
    addi s4,s4,1
    addi s2,s2,1
    j loop1
done:
  bgt s2,t5,end
  addi s4,s4,1
end:
  addi a1,s4,0
  la a0,out
  call printf
  ld ra,8(sp)
  ld s0,16(sp)  #s0=arrstart
  ld s1,24(sp)  #s1=n
  ld s2,32(sp)  #s2=i
  ld s3,40(sp)  #s3=maxweight
  ld s4,48(sp) #s4=ans
  li a0,0
  addi sp,sp,80
  ret
    

