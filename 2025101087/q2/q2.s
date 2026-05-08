.data

  fmt: .asciz "%d %d"
  outfmt: .asciz "%d\n"
  arr: .space 400000
  n: .word 0
  l: .word 0

.text
.global main
.extern scanf
.extern printf

main:
  addi sp,sp,-32
  sd ra,24(sp)
  sd s0,16(sp)
  sd s1,8(sp)
  sd s2,0(sp)

  la a0,fmt
  la a1,n
  la a2,l
  call scanf

  lw s0,n
  la s1,arr
  li t0,0

scan_loop:
  bge t0,s0,push
  la a0,fmt
  slli t1,t0,2
  add a1,s1,t1
  call scanf

  addi t0,t0,1
  j scan_loop

push:
 
 
  