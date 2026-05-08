.section .data
fmt_input: .string "%lld"
fmt_output: .string "%lld\n"

.section .text
.global main

main:
  addi sp, sp, -16
  sd ra, 8(sp)
  
  la a0, fmt_input
  li a1, 0
  call scanf

  ld t0, 0(a0)
  mv a1, t0

  la a0, fmt_output
  call printf

  ld ra, 8(sp)
  addi sp, sp, 16
  ret