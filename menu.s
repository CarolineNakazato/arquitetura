.data 
	TEXTO: .asciiz "\nEscolha uma opcao:\n"
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
	
	jr $ra
