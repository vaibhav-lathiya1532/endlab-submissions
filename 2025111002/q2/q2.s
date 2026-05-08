.section .data
fmt_input: .string "%lld %lld"
fmt_output: .string "%lld "

.section .text
.global main

main: 
  addi sp, sp, -64
  sd ra, 56(sp)
  sd s0, 48(sp) #no 1
  sd s1, 40(sp) #no 2
  sd s2, 32(sp) #iterator
  sd s3, 24(sp) #gcd
  sd s4, 16(sp) #lcm

#taking input

  li a0, 16
  call malloc
  mv a1, a0
  la a0, fmt_input
  call scanf

  ld s0, 0(a1) #contains the first and second numbers
  ld s1, 8(a1)

  li s2, 0 #iterator
gcd_loop:
  addi s2, s2, 1
  blt s0, s2, finish_gcd #check if iterator in range
  blt s1, s2, finish_gcd
  rem t0, s0, s2
  beqz t0, second_number
  j gcd_loop

second_number:
  rem t1, s1, s2
  beqz t1, update
  j gcd_loop

update: 
  mv s3, s2
  j gcd_loop

finish_gcd: #stored gcd in s3
  mul s4, s0, s1
  div s4, s4, s3
  #stored lcm in s4
  la a0, fmt_output
  mv a1, s3
  call printf
  la a0, fmt_output
  mv a1, s4
  call printf
  
  ld ra, 56(sp)
  ld s0, 48(sp)
  ld s1, 40(sp)
  ld s2, 32(sp)
  ld s3, 24(sp)
  ld s4, 16(sp)
  addi sp, sp, 64

  ret
  
  