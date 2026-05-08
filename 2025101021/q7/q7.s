.section .rodata                                # defining the string formats for scanf and printf
fmt: .string "%lld"
fmt2: .string "%s\n"
true_str: .string "TRUE"
false_str: .string "FALSE"

.section .text
.globl main                                     # making main global

main:
    addi sp, sp, -64                            # allocating space in the stack pointer, and storing addresses of variables
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    lla a0, fmt                                 # scanning for n (number to be checked)
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)
    mv s1, s0
    li s2, 0
    li s3, 0
    li s4, 0
    li t0, 10

count_digits:
    beqz s1, count_done                         # checks if number is 0
    div s1, s1, t0                              # if not, divides number by 10
    addi s2, s2, 1                              # adds 1 to digit count
    j count_digits

count_done:
    mv s1, s0                                   # restore original value of n

disarium:
    beqz s1, compare                            # if s1 has become 0, check value obtained by disarium number operation
    rem t1, s1, t0                              # get last digit
    li t2, 0
    li t3, 1

loop:                                           # raise it to the power of the digit's index in the number (1-indexed)
    bge t2, s2, next
    mul t3, t3, t1
    addi t2, t2, 1
    j loop

next:
    add s3, s3, t3                              # add the power so obtained to the total for the disarium operation
    div s1, s1, t0
    addi s2, s2, -1
    j disarium

compare:
    beq s0, s3, print_true                      # if s0 = s3 (number obtained after operation), it is disarium

print_false:
    lla a0, fmt2                                # if not disarium, print false
    lla a1, false_str
    call printf
    j end

print_true:
    lla a0, fmt2                                # if disarium, print true
    lla a1, true_str
    call printf

end:
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)
    addi sp, sp, 64                             # restoring + deallocating space in stack pointer
    ret
