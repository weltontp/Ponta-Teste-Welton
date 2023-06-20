# Ponta-Teste-Welton
 Teste Ponta Welton
 
 Descrição dos recursos utilizados no teste
 
1- Projeto feito com delphi 10.3 (rio)
2- Utilizado cxCrid (DevExpress) nos cadastros
3- Acesso ao banco firebird (2.5) com DBExpress
4- Relatorio foi utilizado Report Builder VS: 22.02

Descrição de funcionamento do cadastro de animail que possuia o diferencial de inserir varios registros e ao final salvar todos se nao houver erros (commit) e voltar tudo caso hava erros (rollback)
1- Quando for clicado em "Incluir" o usuário serÁ levado para um novo grid na aba (cadastro) onde ele pode ir inserindo os animais (SETA PARA BAIXO NESTE GRID ABRIRÁ UM NOVO REGISTRO) e ao final ao clicar no menu "Salvar" todos os registros incluidos neste grid irão para o banco de dados.


Instalação
Requistos para executar o exe:
1- Instale o firebird 2.5 (Firebird-2.5.0.26074_1_Win32.exe) esta incluso junto ao projeto 
2- Mantenha na pasta as três (3) dlls que estão junto com o projeto são elas:
 midas.dll
 fbclient.dll
 dbxfb.dll
