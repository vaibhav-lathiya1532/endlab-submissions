.data

    fmt_in: .string "%lld"
    input: .dword 0
    array: .space 800010
    fmt_out: .string "%lld"

.text
.globl main

main: 

    addi sp, sp, -16
    sd ra, 0(sp)

    la a0, fmt_in
    la a1, input
    call scanf
    la s0, input
    ld s0, 0(s0)                    #s0 = N

    li s1, 0                #s1 = read index counter

    read_loop:

        bge s1, s0, read_done

        la a0, fmt_in
        la a1, input
        call scanf

        la t0, input
        ld t0, 0(t0)                        #t0 = current number being read

        la t2, array
        slli t6, s1, 3
        add t6, t6, t2                      #t6 = &array[index]

        sd t0, 0(t6)

        addi s1, s1, 1

        j read_loop

    read_done:

    #now read target

    la a0, fmt_in
    la a1, input
    call scanf
    la s2, input
    ld s2, 0(s2)                            #s2 = target

    li s4, 0
    addi s5, s0, -1                         #s4 = low AND s5 = high

    bs_loop:

        blt s5, s4, not_found

        la s3, array                            #s3 = base address of array

        #calculate mid now

        add t0, s4, s5
        srli t0, t0, 1
        mv s7, t0                          #s7 = mid now

        slli t1, s7, 3
        add t6, s3, t1                           
        ld t6, 0(t6)
        mv s10, t6                            #s10 = array[mid]

        beq s10, s2, found

        #now compute array low and array high

        slli t6, s4, 3
        add t3, s3, t6
        ld t3, 0(t3)
        mv s8, t3                           #s8 = array[low]

        slli t6, s5, 3
        add t4, s3, t6
        ld t4, 0(t4)
        mv s9, t4                            #s9 = array[high]


        blt s10, s8, right_sorted                #if  array[mid] < array[low] then right half sorted

        left_sorted:

            #if target in lefthalf high = mid - 1 otherwise go_right

            blt s2, s8, go_right
            blt s10, s2, go_right

            go_left:

            addi s5, s7, -1
            j bs_loop

        right_sorted:

            #if target in right half low = mid + 1otherwise go_left

            blt s2, s10, go_left
            blt s9, s2, go_left

            go_right:

            addi s4, s7, 1
            j bs_loop

    found:

        la a0, fmt_out
        mv a1, s7
        call printf

        j exit

    not_found:

        la a0, fmt_out
        li a1, -1
        call printf

        j exit

    exit:

        ld ra, 0(sp)
        addi sp, sp, 16
        li a0, 0
        ret