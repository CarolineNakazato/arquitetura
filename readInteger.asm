#Manda msg, Le do teclado um inteiro e printa
.data # Data declaration section
	prompt: .asciiz "Enter an integer value:\n"
	newLine: .asciiz "\n"
.text
main: # Start of code section
	jal get_integer # Call procedure
	move $s0, $v0 # Put returned value in "save" reg

get_integer:
	#printa texto
	li $v0, 4 # system call code for printing a, string = 4
	la $a0, prompt # address of string is argument 0 to, print_string
	syscall # call operating system to perform

	#le um inteiro do teclado
	li $v0, 5 # get ready to read in integers
	syscall # system waits for input, puts the
	# value in $v0

	#printa inteiro
	la  $a0, 0($v0)	#carrega valor do teclado no $a0
	li $v0, 1 # get print integers
	syscall 

	#printa uma nova linha
	li $v0, 4 
	la $a0, newLine
	syscall
	
	jr $ra
