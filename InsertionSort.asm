.data
    espaco:	.asciiz " "		# string equivalente ao ' ', espaço.
    quebra_de_linha:	.asciiz	"\n"		# string equivalente a quebra de linha.
    vetor:  				# Cria o vetor
        .align 2 			# Alinha o string inteiro na ordem certa
        .space 40			# Aloca espaço para o vetor
    entrada_de_dados: .asciiz "Digite um número inteiro: "
    vetor_string: .asciiz "Vetor: "
    vetor_ordenado_string:	.asciiz "Vetor Ordenado: "
    
.text
.globl main
main:
    move $t0, $zero  	# indice do vetor
    li $t2, 40	 	# tamanho do vetor
    
    leitura_vetor:
    	beq $t0, $t2, end_leitura_vetor # condicional de parada do loop
    	
    	li $v0, 4			# imprimir uma string de tamanho 4
    	la $a0, entrada_de_dados	# carrega a variável 
    	syscall  			# emite uma chamada de sistema
    
    	li $v0, 5			# leitura de numero inteiro informado pelo usuario
    	syscall				# emite uma chamada de sistema
    	
    	move $t1, $v0			# move o valor do inteiro de $v0 para $t1
    	sw $t1, vetor($t0)		# coloca o valor dentro do vetor
    	addi $t0, $t0, 4		# incrementa o ponteiro do vetor
    	j leitura_vetor			# recomeça o loop
    	
    end_leitura_vetor:
    	li	$v0, 4				# imprime uma string de tamanho 4
	la	$a0, quebra_de_linha		# imprime a string 'Vetor: '
	syscall					# emite uma chamada de sistema
    	li	$v0, 4				# imprime uma string de tamanho 4
	la	$a0, vetor_string		# imprime a string 'Vetor: '
	syscall					# emite uma chamada de sistema
    	jal	imprime				# imprime o vetor informado pelo usuario utilizando o procedimento criada
			
    insertion_sort:
    	ordenacao_inicializacao:
		la	$t0, vetor		# carrega o vetor para $t0
		li	$t1, 10			# carrega o tamanho do vetor para $t1.
		li	$t2, 1			# contador para o loop, começando com 1
	ordenacao_loop_externo:
		la	$t0, vetor				# carrega o vetor para $t0
		bge	$t2, $t1, ordenacao_loop_externo_end	# enquanto ($t2 < $t1)
		move	$t3, $t2				# copie $t2 para $t3
	ordenacao_loop_interno:
		la	$t0, vetor				# carrega o vetor para $t0
		mul	$t5, $t3, 4				# calcula o espaço do valor da variável de $t3 e atribui a $t5
		add	$t0, $t0, $t5				# incrementa o ponteiro do vetor
		ble	$t3, $zero, ordenacao_loop_interno_end	# enquanto ($t3 > 0)
		lw	$t7, 0($t0)				# carrega o vetor[$t3] e atribui em $t7
		lw	$t6, -4($t0)				# carrega o vetor[$t3 - 1] e atribui em $t6
		bge	$t7, $t6, ordenacao_loop_interno_end	# enquanto (vetor[$t3] < vetor[$t3 - 1])
		lw	$t4, 0($t0)				# carrega o valor do vetor da memória para o registrador $t4
		sw	$t6, 0($t0)				# carrega o valor do registrador para a memória em $t6
		sw	$t4, -4($t0)				# faz o ponteiro apontar para a esquerda do valor atual
		subi	$t3, $t3, 1				# decrementa o contador em 1
		j	ordenacao_loop_interno			# volta para o começo do ordenacao_loop_interno
	ordenacao_loop_interno_end:
		addi	$t2, $t2, 1			# incrementa o contador em 1
		j	ordenacao_loop_externo		# volta para o começo do ordenacao_loop_externo
	ordenacao_loop_externo_end:
		li	$v0, 4				# imprime uma string de tamanho 4
		la	$a0, vetor_ordenado_string	# imprime a string 'Vetor Ordenado'
		syscall					# emite uma chamada de sistema
		jal	imprime				# printa o vetor ordenado
end:
    li $v0, 10	# finalizador do programa
    syscall	# emite uma chamada do sistema
    
imprime:
    	print_loop_inicializacao:
		la	$t0, vetor	# carrega o vetor para a $t0
		li	$t1, 10		# carrega o tamanho do vetor para $t1
		li	$t2, 0		# inicializando o contador com 0 para $t2
	print_loop:
		bge	$t2, $t1, print_end	# condição de parada do loop
		li	$v0, 1			# carrega um inteiro para $v0
		lw	$a0, 0($t0)		# carrega o valor do vetor da memória para o registrador $a0
		syscall				# emite uma chamada de sistema
		li	$v0, 4			# carrega uma string para $v0
		la	$a0, espaco		# imprime a string ' '
		syscall				# emite uma chamada de sistema
		addi	$t0, $t0, 4		# incrementa o ponteiro do vetor
		addi	$t2, $t2, 1		# incrementa o valor do contador em 1
		j	print_loop		# volta para o começo do print_loop
	print_end:
		li	$v0, 4			# carrega uma string para $v0
		la	$a0, quebra_de_linha	# imprime a string '\n'
		syscall				# emite uma chamada de sistema
		jr	$ra			# retorno da função