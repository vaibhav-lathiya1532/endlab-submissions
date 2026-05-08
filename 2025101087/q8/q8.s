.data

  fmt: .asciz "%d"
  outfmt: .asciz "%d\n"
  arr: .space 400000
  n: .word 0
  target: .word 0
  
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
  call scanf
  
  lw s0,n
  la s1,arr
  li t0,0

scan_loop:
  bge t0,s0,scan_target
  la a0,fmt
  slli t1,t0,2
  add a1,s1,t1
  call scanf

  addi t0,t0,1
  j scan_loop

scan_target:
  la a0,fmt
  la a1,target
  call scanf

  lw s2,target
  li t0,0

  addi t1,s0,-1

binary_search:
  bgt t0,t1,not_found
  add t2,t0,t1
  srai t2,t2,1

  slli t3,t2,2
  add t4,s1,t3
  lw t4,0(t4)
  beq t4,s2,found
  slli t3,t0,2
  add t5,s1,t3
  lw t5,0(t5)

  ble t5,t4,left_sorted
right_sorted:
  slli t3,t1,2
  add t6,s1,t3
  lw t6,0(t6)
 
  ble s2,t6,go_right
  j move_left

go_right:
  bge s2,t4,move_right
  j move_left

move_right:
  addi t0,t2,1
  j binary_search

move_left:
  addi t1,t2,-1
  j binary_search

left_sorted:
  ble t5,s2,go_left
  j move_right

go_left:
  ble s2,t4,move_left
  j move_right

found:
  mv a1,t2
  j print

not_found:
  li a1,-1

print:
  la a0,outfmt
  call printf

  ld ra,24(sp)
  ld s0,16(sp)
  ld s1,8(sp)
  ld s2,0(sp)
  addi sp,sp,32

  li a0,0
  ret
