.section .rodata
fmt_in:
    .string "%lld %lld"
fmt_out:
    .string "%lld %lld %lld %lld\n"

.globl main
.section .text
main:
    addi sp, sp, -32
    sd ra, 24(sp)      
    la a0, fmt_in      
    addi a1, sp, 8      
    addi a2, sp, 16     
    call scanf
   
    ld t0, 8(sp)        
    ld t1, 16(sp)      
  
    sub t2, t1, t0     
    
    li t3, 0            
    li t4, 0            
    li t5, 0            
    li t6, 0          
   
quarters_loop:
    li a5, 25          
    blt t2, a5, dimes_loop  
    sub t2, t2, a5    
    addi t3, t3, 1      
    j quarters_loop     
    
dimes_loop:
    li a5, 10          
    blt t2, a5, nickels_loop 
    sub t2, t2, a5     
    addi t4, t4, 1      
    j dimes_loop        
    
nickels_loop:
    li a5, 5           
    blt t2, a5, pennies_loop 
    sub t2, t2, a5      
    addi t5, t5, 1      
    j nickels_loop      

pennies_loop:
    li a5, 1           
    blt t2, a5, print_results 
    sub t2, t2, a5    
    addi t6, t6, 1      
    j pennies_loop      

print_results:
    la a0, fmt_out      
    mv a1, t3           
    mv a2, t4           
    mv a3, t5           
    mv a4, t6           
    call printf

    li a0, 0            
    ld ra, 24(sp)       
    addi sp, sp, 32     
    ret     


