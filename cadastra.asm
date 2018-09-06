.data 
.align 4
gastos: .space 440
gastosFim: .word 0
idCont: .word 0
idContAux: .word 0

msg1: .asciiz " 1 - Cadastrar Abastecimento\n 3 - Exibir Abastecimento \n Digite a opcao desejada: "

invalida: .asciiz "Opcao invalida!\n"

quebraDeLinha: .asciiz "\n" 
espaco: .asciiz " " 
diaMsg: .asciiz "Dia: "
mesMsg: .asciiz "Mes: "
anoMsg: .asciiz "Ano(2 ultimos digitos): "
ano2Msg: .asciiz "Ano: "
catMsg: .asciiz "Nome do posto: "
kmMsg: .asciiz "Quilometragem: "
qtdCombustivelMsg: .asciiz "Quantidade de combustivel: "
valorMsg: .asciiz "Preco: "
zerofloat: .float 0.0



.text
.globl main 

main: 
la $s0, gastos # carrega endereço de gastos em s0
sw $s0, gastosFim #carrega o endereço de gastos em gastosFim
lw $s1, gastosFim

mainAux:
jal quebraLinhaProcedimento
addi $v0, $zero, 4 # para printar uma string colocar o codigo 4 em v0
la $a0, msg1 # colocar o endere�o da mensagem em a0
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall # e dar syscall
addi $s0, $v0, 0  # o inteiro digitado fica salvo em v0 guardar em s0



li $s1, 1 # colocar 1 em s1 para comparar se digitou opcao 1
beq $s1, $s0, opcao1Ponte
li $s1, 3 # colocar 3 em s1 para comparar se digitou opcao 3
beq $s1, $s0, opcao3Ponte


addi $v0, $zero, 4 # para printar uma string colocar o codigo 4 em v0
la $a0, invalida # colocar o endereço da mensagem em a0
syscall # dar syscall
j fim
opcao1Ponte: j opcao1
opcao3Ponte: j opcao3

############################### OP��O DE CADASTRO #########################
opcao1: 

#ID
lw $s0,idCont
lw $s1, gastosFim #le o endereco do ultimo gasto cadastrado
sw $s0, 0($s1)
addi $v0, $zero, 1 
addi $s0, $s0, 1
sw $s0, idCont

lw $t0, idContAux
addi $t0, $t0, 1
sw $t0, idContAux

addi $s1, $s1,1
sw $s1, gastosFim # guarda o endereco novo
jal quebraLinhaProcedimento
#DIA
addi $v0, $zero, 4 
la $a0, diaMsg 
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
lw $s1, gastosFim #le o endereço do ultimo gasto cadastrado
sb $v0, 0 ($s1)  #carrega a data
addi $s1, $s1, 1 #soma 1 pra ir pra proxima posição
sw $s1, gastosFim # guarda o endereço novo

#MES
addi $v0, $zero, 4 
la $a0, mesMsg 
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
lw $s1, gastosFim #le o endereço do ultimo gasto cadastrado
sb $v0, 0 ($s1)  #carrega a data
addi $s1, $s1, 1 #soma 1 pra ir pra proxima posição
sw $s1, gastosFim # guarda o endereço novo
#ANO
addi $v0, $zero, 4 
la $a0, anoMsg 
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
lw $s1, gastosFim #le o endereço do ultimo gasto cadastrado
sb $v0, 0 ($s1)  #carrega a data
addi $s1, $s1, 1 #soma 1 pra ir pra proxima posição
sw $s1, gastosFim # guarda o endereço novo

# RECEBE NOME
addi $v0, $zero, 4 
la $a0, catMsg 
syscall 
addi $a1, $zero, 15
addi $v0, $zero, 8 
lw $s1, gastosFim #le o endereço do ultimo gasto cadastrado
add $a0,$s1,$zero   
syscall 
addi $s1, $s1,16
sw $s1, gastosFim # guarda o endereço novo
# RECEBE KM
addi $v0, $zero, 4 
la $a0, kmMsg 
syscall 
addi $v0, $zero, 5 # para receber um inteiro colocar codigo 5
syscall
addi $s1, $s1, 4 #soma 1 pra ir pra proxima posição
sw $s1, gastosFim # guarda o endereço novo

# RECEBE quantidade de combustivel
addi $v0, $zero, 4 
la $a0, qtdCombustivelMsg 
syscall 
addi $v0, $zero, 6
syscall
addi $s1, $s1, 4
sw $s1, gastosFim

# RECEBE PRECO
addi $v0, $zero, 4 
la $a0, valorMsg 
syscall 
addi $v0, $zero, 6 # para receber um inteiro colocar codigo 5
syscall
lw $s1, gastosFim #le o endereço do ultimo gasto cadastrado
s.s $f0, 0($s1)  #carrega a data
addi $s1, $s1, 4 #soma 1 pra ir pra proxima posição
sw $s1, gastosFim # guarda o endereço 

jal quebraLinhaProcedimento

j fim

################################### LISTAR DESPESA #############################
opcao3: 
addi $t7, $zero, 365
addi $t6, $zero, 30
#####inicio do loop##############
lw $s6, idContAux #contador de quantas despezas tem
addi $s6, $s6, -1
add $t4, $zero, $zero #contador q inicia em 0 para chegar ate em idCont
add $t5, $zero, $zero #contador q inicia em 0 para chegar ate em idCont
la $a1, gastos #carrega o endere�o do primeiro gasto
lw $s0, gastosFim #carregar o endere�o do ultimo gasto
op3InicioFor2: 
bne $s6, $t5, op3InicioFor1 
j op3Fim
op3InicioFor1: 
bne $s6, $t4, op3For1 
add $t4, $zero, $zero #contador q inicia em 0 para chegar ate em idCont
addi $t5, $t5, 1
la $a1, gastos #carrega o endere�o do primeiro gasto
j op3InicioFor2
op3For1:
jal retornaLoopProcedimento
add $s5, $zero, $v0
addi $a1, $a1, 24
jal retornaLoopProcedimento 
add $s4, $zero, $v0
addi $t4, $t4, 1
slt $s3, $s5, $s4 #s4<s5 ====> seta s3
beq $s3, $zero, op3Troca
j op3InicioFor1
op3Troca: ####### joga o i na pilha


addi $a1, $a1, -24

#colocando na pilha
#dia
addi $sp, $sp, -4
lw $t0, 0($a1)
sw $t0, 0($sp)
#mes
addi $sp, $sp, -4
lw $t0, 4($a1)
sw $t0, 0($sp)
#ano
addi $sp, $sp, -4
lw $t0, 8($a1)
sw $t0, 0($sp)
#nome
addi $sp, $sp, -4
lw $t0, 12($a1)
sw $t0, 0($sp)
addi, $sp, $sp, -4
lw $t0, 16($a1)
sw $t0, 0($sp)
#km
addi $sp, $sp, -4
lw $t0, 20($a1)
sw $t0, 0($sp)
#quantidade
addi $sp, $sp, -4
l.s $f0, 24($a1)
s.s $f0, 0($sp)
#valor
addi $sp, $sp, -4
l.s $f0, 28($a1)
s.s $f0, 0($sp)


# substituindo o i+1 por i
#dia
addi $a1, $a1, 32
lw $t0, 0($a1)
#mes
sw $t0, -32($a1)
lw $t0, 4($a1)
#ano
sw $t0, -28($a1)
lw $t0, 8($a1)
#nome
sw $t0, -24($a1)
lw $t0, 12($a1)
sw $t0, -20($a1)
lw $t0, 16($a1)
sw $t0, -16($a1)
#km
sw $t0, -12($a1)
lw $t0, 20($a1)
#qtd
l.s $f0, 24($a1)
s.s $f0, -8($a1)
#valor
l.s $f0, 28($a1)
s.s $f0, -4($a1)

# i+1 = pilha
#valor
l.s $f0, 0($sp)
s.s $f0, 28($a1)
addi $sp, $sp, 4
#qtd
l.s $f0, 0($sp)
s.s $f0, 24($a1)
addi $sp, $sp, 4
#km
lw $t0, 0($sp)
sw $t0, 20($a1)
addi $sp, $sp, 4
#nome
lw $t0, 0($sp)
sw $t0, 16($a1)
addi $sp, $sp, 4
lw $t0, 0($sp)
sw $t0, 12($a1)
addi $sp, $sp, 4
#data
lw $t0, 0($sp)
sw $t0, 8($a1)
addi $sp, $sp, 4
lw $t0, 0($sp)
sw $t0, 4($a1)
addi $sp, $sp, 4
lw $t0, 0($sp)
sw $t0, 0($a1)
addi $sp, $sp, 4
j op3InicioFor1

###########
op3Fim:
lw $s1, gastosFim 
la $s0, gastos



comparacaoOpcao3:
bne $s1, $s0, printarOpcao3
j fimOpcao3
printarOpcao3:
li $v0, 4
la $a0, diaMsg
syscall
lb $a0, 1($s0)
li $v0, 1
syscall
jal espacoProcedimento
li $v0, 4
la $a0, mesMsg
syscall
lb $a0, 2($s0)
li $v0, 1
syscall
jal espacoProcedimento
li $v0, 4
la $a0, ano2Msg
syscall
lb $a0, 3($s0)
addi $a0, $a0, 2000
li $v0, 1
syscall
jal quebraLinhaProcedimento
addi $s0, $s0, 4 # começa a string
li $v0, 4
la $a0, catMsg
syscall
addi $a0, $s0, 0
li $v0, 4
syscall

addi $s0, $s0, 16 # começa o valor
li $v0, 4
la $a0, valorMsg
syscall
l.s $f12, 0($s0)
li $v0, 2
syscall
addi $s0, $s0, 4 #começa o proximo
jal quebraLinhaProcedimento
jal quebraLinhaProcedimento
j comparacaoOpcao3 
fimOpcao3:

jal quebraLinhaProcedimento

j fim 

##############################
fim:
j mainAux


## fun��es

############################################ pritar pilhar
 
quebraLinhaProcedimento:
addi $v0, $zero, 4 
la $a0, quebraDeLinha 
syscall
jr $ra


espacoProcedimento:
addi $v0, $zero, 4 
la $a0, espaco 
syscall
jr $ra


retornaLoopProcedimento:
lb $t0, 3($a1) #carrega o ano em t0
mul $t2, $t7, $t0 #multiplica por 365 o ano
lb $t0, 2($a1) #carrega o mes em t0
mul $t3, $t6, $t0 #t3 = 30*numero do mes
add $t0, $t2, $t3 #t0 = t2(ano) + t3(mes)
lb $t1, 1($a1) #carrega o dia em t1
add $t0, $t1, $t0 
#t0 = t1(dia) + t0(ano+mes) ======> t0 = a qtd de dias do cadastro
add $v0, $zero, $t0
jr $ra


# na hora de printar a string usa o comando LA pq vc carrega o endereço da string
#em a0 ja pra printar o inteiro vc pode usar o add (move) pos nele carrega
#o conteudo
