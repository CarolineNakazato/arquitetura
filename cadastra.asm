.data 
.align 4
ABASTECIMENTOS: .space 440
ULTIMO_ABASTECIMENTO: .word 0
COD_ABASTECIMENTO: .word 0
COD_ABASTECIMENTO_AUX: .word 0

MENU: .asciiz " 1 - Cadastrar Abastecimento\n Digite a opcao desejada: "
TXT_INVALIDO: .asciiz "Opcao invalida!\n"
PULA_LINHA: .asciiz "\n"  
TXT_DIA: .asciiz "Dia: "
TXT_MES: .asciiz "Mes: "
TXT_ANO: .asciiz "Ano(2 ultimos digitos): "
TXT_NOME: .asciiz "Nome do posto: "
TXT_KM: .asciiz "Quilometragem: "
TXT_COMBUSTIVEL: .asciiz "Quantidade de combustivel: "
TXT_PRECO: .asciiz "Preco: "

.text
.globl main 

main: 
la $s0, ABASTECIMENTOS # carrega endereço de ABASTECIMENTOS em s0
sw $s0, ULTIMO_ABASTECIMENTO #carrega o endereço de gastos em ULTIMO_ABASTECIMENTO
lw $s1, ULTIMO_ABASTECIMENTO

printaMenu:
jal println
addi $v0, $zero, 4 # para printar uma string colocar o codigo 4 em v0
la $a0, MENU # colocar o endere�o da mensagem em a0
syscall 

addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
addi $s0, $v0, 0  # o inteiro digitado fica salvo em v0 guardar em s0

li $s1, 1 # colocar 1 em s1 para comparar se digitou opcao 1
beq $s1, $s0, cadastraAbastecimentoPonte

addi $v0, $zero, 4 # para printar uma string colocar o codigo 4 em v0
la $a0, TXT_INVALIDO # colocar o endereço da mensagem em a0
syscall 
j voltaMenu

cadastraAbastecimentoPonte: j cadastraAbastecimento

############################### OP��O DE CADASTRO #########################
cadastraAbastecimento: 

#COD_ABASTECIMENTO
lw $s0,COD_ABASTECIMENTO
lw $s1, ULTIMO_ABASTECIMENTO #le o endereco do ultimo gasto cadastrado
sw $s0, 0($s1)
addi $v0, $zero, 1 
addi $s0, $s0, 1
sw $s0, COD_ABASTECIMENTO

lw $t0, COD_ABASTECIMENTO_AUX
addi $t0, $t0, 1
sw $t0, COD_ABASTECIMENTO_AUX

addi $s1, $s1,1
sw $s1, ULTIMO_ABASTECIMENTO # guarda o endereco novo
jal println

#DIA
addi $v0, $zero, 4 
la $a0, TXT_DIA 
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
lw $s1, ULTIMO_ABASTECIMENTO #le o endereço do ultimo gasto cadastrado
sb $v0, 0 ($s1)  #carrega a data
addi $s1, $s1, 1 #soma 1 pra ir pra proxima posição
sw $s1, ULTIMO_ABASTECIMENTO # guarda o endereço novo

#MES
addi $v0, $zero, 4 
la $a0, TXT_MES 
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
lw $s1, ULTIMO_ABASTECIMENTO #le o endereço do ultimo gasto cadastrado
sb $v0, 0 ($s1)  #carrega a data
addi $s1, $s1, 1 #soma 1 pra ir pra proxima posição
sw $s1, ULTIMO_ABASTECIMENTO # guarda o endereço novo

#ANO
addi $v0, $zero, 4 
la $a0, TXT_ANO 
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
lw $s1, ULTIMO_ABASTECIMENTO #le o endereço do ultimo gasto cadastrado
sb $v0, 0 ($s1)  #carrega a data
addi $s1, $s1, 1 #soma 1 pra ir pra proxima posição
sw $s1, ULTIMO_ABASTECIMENTO # guarda o endereço novo

#NOME
addi $v0, $zero, 4 
la $a0, TXT_NOME 
syscall 
addi $a1, $zero, 15
addi $v0, $zero, 8 
lw $s1, ULTIMO_ABASTECIMENTO #le o endereço do ultimo gasto cadastrado
add $a0,$s1,$zero   
syscall 
addi $s1, $s1,16
sw $s1, ULTIMO_ABASTECIMENTO # guarda o endereço novo

#KM
addi $v0, $zero, 4 
la $a0, TXT_KM 
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
addi $s1, $s1, 4 #soma 4 pra ir pra proxima posição
sw $s1, ULTIMO_ABASTECIMENTO # guarda o endereço novo

#QUANTIDADE COMBUSTIVEL
addi $v0, $zero, 4 
la $a0, TXT_COMBUSTIVEL 
syscall 
addi $v0, $zero, 6
syscall
addi $s1, $s1, 4
sw $s1, ULTIMO_ABASTECIMENTO

#PRECO
addi $v0, $zero, 4 
la $a0, TXT_PRECO 
syscall 
addi $v0, $zero, 6 # para receber um inteiro colocar codigo 5
syscall
lw $s1, ULTIMO_ABASTECIMENTO #le o endereço do ultimo gasto cadastrado
s.s $f0, 0($s1)  #carrega a data
addi $s1, $s1, 4 #soma 4 pra ir pra proxima posição
sw $s1, ULTIMO_ABASTECIMENTO # guarda o endereço 

jal println
j voltaMenu

######################## VOLTA PARA O MENU #########################

voltaMenu:
j printaMenu

############################### PRINTA NOVA LINHA #########################
println:
addi $v0, $zero, 4 
la $a0, PULA_LINHA 
syscall
jr $ra
