.section .rodata                    # defining the string formats for scanf and printf
fmt: .string "%lld"
fmt2: .string "%lld\n"

.section .text
.globl main                         # making main global

main:
    addi sp, sp, -64                # allocating space in the stack pointer, and storing addresses of variables
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    lla a0, fmt                     # scanning for n (number of elements in array)
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)
    li s3, -1000005                 # setting values before loop (s3 is max, s4 is max2)
    li s4, -1000005
    li s1, 0

loop:
    bge s1, s0, end                 # checking if end of array reached
    lla a0, fmt
    addi a1, sp, 0
    call scanf                      # no actual storing of array elements, just scanning + using elements one by one
    ld s2, 0(sp)
    beq s2, s3, ignore              # if equal, element not unique, skip
    bgt s2, s3, max                 # if greater than max, set new max and max2
    bgt s2, s4, max2                # if greater than max2, set new max2
    j ignore                        # if none fulfilled, skip

max:
    mv s4, s3                       # new max2 = old max
    mv s3, s2                       # new max = element just scanned
    addi s1, s1, 1
    j loop

max2:
    mv s4, s2                       # new max2 = element just scanned
    addi s1, s1, 1
    j loop

ignore:
    addi s1, s1, 1                  # move to next iteration
    j loop

end:
    lla a0, fmt2
    mv a1, s4
    call printf                     # print result
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)
    addi sp, sp, 64                 # restoring + deallocating space in stack pointer
    ret


