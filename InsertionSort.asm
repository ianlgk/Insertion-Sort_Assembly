.data
    array:
        .align 2
        .space 40
    input: .asciiz "Digite um número inteiro: "
    
.text
.globl main
main:
    move $t0, $zero
    li $t2, 40
    
    loop:
    	beq $t0, $t2, end_loop
    	
    	li $v0, 4
    	la $a0, input
    	syscall
    
    	li $v0, 5
    	syscall
    	
    	move $t1, $v0
    	sw $t1, array($t0)
    	addi $t0, $t0, 4
    	j loop
    	
    end_loop:
        move $t0, $zero 
    	imprime:
    	   beq $t0, $t2, end_imprime
    	   li $v0, 1
    	   lw $a0, array($t0)
    	   syscall
    	   
    	   addi $t0, $t0, 4
    	   j imprime
    	   
    	end_imprime:
    	
   jal insertion_sort
   
end:
    li $v0, 10
    syscall
    

    
     
 	
