.data
buffer : .space 4000000
n: 0
.text
.globl main

main:
    la a0 , buffer 
    
    li a7 , 5
    ecall
    la t0 , a0

    li a7 , 5
    ecall
    la t1 

transpose:
     #adr of arr[i][j] , value = a
    #adr of arr[j][i] value = b 
    #swap a  b
    # i from 1 to n 
    # j from i+1 to n


reverse:
    # j= n-j-1
