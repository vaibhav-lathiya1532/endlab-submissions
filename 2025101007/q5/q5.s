.data
    input_fmt: .asciz "%d"
    buffer: .space 4000000
.text
.globl main

main:
    la a0,input_fmt
    la a1,buffer
    call scanf

    ld s1,buffer
    li s2,0 #initialise outer loop counter

#for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
        int temp=matrix[i][j];
        matrix[i][j]=matrix[j][i];
        matrix[j][i]=temp;
    }
}

outer_loop:
    bge s2,a0,exit
    li s3,0
    j inner_loop

inner_loop:
    bge s3,a0,exit
    li t0,8
    mul s2,s2,t0
    add s3,s2,s3
    slli s3,s3,2
    










