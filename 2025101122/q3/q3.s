.data
    buffer: .space 848
    input: .string "%lld"
    output: .string "%lld\n"
.text
.global main
.extern printf
.extern scanf
.extern malloc

main:
    addi sp, sp, -16
    sd ra, 8(sp)
    addi a1, sp, 0
    la a0, input
    call scanf
    ld s0, 0(sp)            #s0 == n

    slli a0, s0, 3
    call malloc
    mv s1, a0               #s1 = arr

    li s2, 0
    slli s3, s0, 3          #s3 = n x 8

    li s4, 0
    li s5, 0

loop:
    beq s2, s3, input_done
    add a1, s1, s2
    la a0, input
    call scanf

    add t0, s1, s2
    ld t1, 0(t0)

    add s5, s5, t1

    addi s2, s2, 8
    j loop

input_done:
    li s2, 8

finding:
    beq s2, s3, not_found

    add t1, s2, s1      
    ld t3, 0(t1)        #arr[i]

    addi t0, s2, -8     
    add t0, t0, s1     
    ld t2, 0(t0)        #arr[i-1]

    sub s5, s5, t2      #rightsum -= arr[i-1]
    add s4, s4, t2      #leftsum += arr[i-1]

    sub t6, s5, s4      #t6 = right - left
    beq t6, t3, found

    addi s2, s2, 8
    j finding

found:
    srai s2, s2, 3
    mv a1, s2
    la a0, output
    call printf
    j end
not_found:
    li s2, -1
    mv a1, s2
    la a0, output
    call printf

end:
    ld ra, 8(sp)
    addi sp, sp, 16
    ret