.data 
	TEXTO: .asciiz "\n 1 - Cadastrar Abastecimento;\n 2 - Excluir Abastecimento;\n 3 - Exibir Abastecimento;\n 4 - Exibir Consumo Medio; \n 5 - Exibir Preco Medio\n 6 - Sair; \n\n Escolha uma opcao:\n"
	TEXTO_INVALIDO: .asciiz "\nOpcao Invalida!\n"
	##### textos usados como auxiliar de teste #########
	TEXTO1: .asciiz "\nTexto 1\n"
	TEXTO2: .asciiz "\nTexto 2\n"
	TEXTO3: .asciiz "\nTexto 3\n"
	TEXTO4: .asciiz "\nTexto 4\n"	
	TEXTO5: .asciiz "\nTexto 5\n"
	####################################################
	
.text
main: 
	jal get_option # Call procedure
	move $s0, $v0 # Put returned value in "save" reg

get_option:
	li $v0, 4 # string = 4
	la $a0, TEXTO 
	syscall

	#le um inteiro do teclado
	li $v0, 5 
	syscall # value in $v0
	
	
	bne $v0,1,opcao_2
	# opcao 1 - cadastrar abastecimento
	### chamar cadastrar abastecimento ####
	li $v0, 4
	la $a0, TEXTO1 
	syscall
	#######################################
	j volta
opcao_2: # 2 - excluir abastecimento
	bne $v0,2,opcao_3
	##### chamar excluir abastecimento #####
	li $v0, 4 
	la $a0, TEXTO2 
	syscall
	#######################################
	j volta
opcao_3: # 3 - exibir abastecimento
	bne $v0,3,opcao_4
	##### chamar exibir abastecimento #######
	li $v0, 4 
	la $a0, TEXTO3 
	syscall
	#######################################
	j volta
opcao_4: # 4 - exibir consumo medio
	bne $v0,4,opcao_5
	##### chamar exibir consumo medio #######
	li $v0, 4 
	la $a0, TEXTO4 
	syscall
	#######################################
	j volta
opcao_5: # 5 - exibir preco medio
	bne $v0,5,opcao_6
	##### chamar exibir preco medio #######
	li $v0, 4 
	la $a0, TEXTO5
	syscall
	#######################################
	j volta
opcao_6: # 6 -  sai do programa
	bne $v0,6,opcao_invalido
	li $v0, 10  # end program = 10
    	syscall
opcao_invalido:
	li $v0, 4 
	la $a0, TEXTO_INVALIDO
	syscall
volta:	
	jr $ra
