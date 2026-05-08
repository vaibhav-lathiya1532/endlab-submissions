.section .rodata
fmt:
    .string "%ld"
err:.string "error found no allocation"
w:.string "while\n"
l:.string "\n"
.section .data
n:
    .dword 0
t:
    .dword 0
.section .text
.globl main
# s0 ---> n
# s1 ---> target
# s2 ---> base address of arr
# s3 ---> index
# s4 ---> high
# s5 ---> arr[0]
# s6 ---> smallest element
# s7 ---> low
# s8 ---> mid
main:
    lla a0,fmt
    lla a1,n
    call scanf

    lla t0,n
    ld s0,0(t0)

    mv a0,s0
    call malloc
    beqz a0,error

    mv s2,a0
    li s3,-1
loop:
    lla a0,l
    call printf
    addi s3,s3,1
    bge s3,s0,smallest
    slli t0,s3,3
    add a1,t0,s2
    lla a0,fmt
    call scanf
    j loop
smallest:
    li s3,-1
    addi s4,s0,-1
    ld s5,0(s2)
    slli t0,s4,3
    add t0,t0,s2
    ld t0,0(t0)
    li s6,0
    blt s5,t0,target
    li s7,0
loop2:
    bgt s7,s4,target
    add s8,s7,s4
    srli s8,s8,1
    slli t0,s8,3
    add t0,t0,s2
    ld t0,0(t0)
    ble t0,s5,go_left
    addi s7,s8,1
    j loop2
go_left:
    mv s6,s8
    addi s4,s8,-1
    j loop2
target:
    addi s6,s6,-1
    lla a0,fmt
    lla a1,t
    call scanf
    lla t0,t
    ld s1,0(t0)
    ble s1,s5,secondhalf
    li s7,0
    addi s4,s6,-1
    j binary
secondhalf:
    mv s7,s6
    addi s4,s0,-1
    j binary
binary:
    bgt s7,s4,not_done
    add s8,s7,s4
    srli s8,s8,1
    slli t0,s8,3
    add t0,t0,s2
    ld t0,0(t0)
    beq t0,s1,done
    blt t0,s1,go_right
    addi s4,s8,-1
go_right:
    addi s7,s8,1
    j binary
done:
    mv a1,s8
    lla a0,fmt
    call printf
    call exit
not_done:
    mv a1,s8
    lla a0,fmt
    call printf
    call exit
