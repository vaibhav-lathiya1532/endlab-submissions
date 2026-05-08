.data
inp: .string "%ld"
out: .string "%ld\n"
not: .string "-1\n"
.text
.globl main
main:
  addi sp,sp,-80
  sd ra,8(sp) 
  sd s0,16(sp)  #s0=arrpointer
  sd s1,24(sp)  #s1=n
  sd s2,32(sp)  #s2=l
  sd s3,40(sp)  #s3=m
  sd s4,48(sp)  #s4=r
  sd s5,56(sp)  #s5=i
  sd s6,64(sp)  #s6=tar
  la a0,inp
  addi a1,sp,0
  call scanf
  ld s1,0(sp)
  mul a0,s1,s1
  call malloc
  addi s0,a0,0
  addi s5,x0,0
  loop:
    bge s5,s1,loopdone
    slli t0,s5,3
    add t0,t0,s0
    la a0,inp
    addi a1,t0,0
    call scanf
    addi s5,s5,1
    j loop
loopdone:
  la a0,inp
  addi a1,sp,0
  call scanf
  ld s6,0(sp)
  addi s2,x0,0
  addi s4,s1,-1
  bs:
    bgt s2,s4,not_found
    add s3,s2,s4
    srli s3,s3,1
    slli t0,s3,3
    add t0,t0,s0
    ld t2,0(t0)
    beq t2,s6,found
    slli t0,s2,3
    add t0,t0,s0
    ld t1,0(t0)
    slli t0,s4,3
    add t0,t0,s0
    ld t3,0(t0)
    ble t1,t2,leftsort
    blt s6,t2,left
    bgt s6,t3,left
    j right
leftsort:
    bgt s6,t2,right
    blt s6,t1,right
    j left
left:
   addi s4,s3,-1
   j bs
right:
   addi s2,s3,1
   j bs
not_found:
   la a0,not
   call printf
   j end
found:
   la a0,out
   add a1,s3,x0
   call printf
end:
  ld ra,8(sp) 
  ld s0,16(sp)  #s0=arrpointer
  ld s1,24(sp)  #s1=n
  ld s2,32(sp)  #s2=l
  ld s3,40(sp)  #s3=m
  ld s4,48(sp)  #s4=r
  ld s5,56(sp)  #s5=i
  ld s6,64(sp)  #s6=tar
  li a0,0
  addi sp,sp,80
  ret
