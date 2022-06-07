%{
#include <stdio.h>
extern void yyerror(char const *message);
extern int yylex(void);
%}
%token PROGRAM 
VAR 
INIT 
END 
COMMA 
COLON
SEMICOLON 
INTEGER 
REAL 
BOOLEAN 
ATRIBUTION 
IF 
THEN 
ELSE 
WHILE 
DO 
READ
WRITE 
OTHER 
EQUAL 
LESS 
GREATER 
LESS_EQUAL 
GREATER_EQUAL 
PLUS 
MINUS
OR 
MULT 
DIV 
AND 
PARENTHESES_OPEN 
PARENTHESES_CLOSE 
TRUE 
FALSE 
NOT 
NUM 
ID
%right NOT
%left MULT DIV
%left MINUS PLUS
%left LESS GREATER LESS_EQUAL GREATER_EQUAL
%left EQUAL OTHER
%left TRUE FALSE
%right ATRIBUTION
%%


programa: PROGRAM id SEMICOLON bloco {printf("<progama> ::= programa <identificador> ; <bloco>\nSintaticamente correto\n");}
  ;
bloco: VAR declaracao INIT comandos END {printf("<bloco> ::= var <declaracao> inicio <comandos> fim\n");}
  ;
declaracao: nome_var COLON tipo SEMICOLON {printf("<declaracao> ::= <nome_var> : <tipo> ;\n");}
        | nome_var COLON tipo SEMICOLON declaracao {printf("<declaracao> ::= <tipo> ; <declaracao>\n");}
        ;
nome_var: id {printf("<nome_var> : <identificador>\n");} 
        | id COMMA nome_var {printf("<nome_var> ::= <identificador>, <nome_var>\n");}
        ;
tipo: INTEGER {printf("<tipo> ::= inteiro\n");} 
        | REAL {printf("<tipo> ::= real\n");} 
        | BOOLEAN {printf("<tipo> ::= booleano\n");}
        ;
comandos: comando {printf("comandos ::= <comando>\n");} 
        | comando SEMICOLON comandos {printf("<comandos> ::= <comando> ; <comandos>\n");} 
        ;
comando: comando_combinado
        | comando_aberto
        ;
comando_combinado: IF expressao THEN comando_combinado ELSE comando_combinado 
        | atribuicao {printf("<comando> -> <atribuicao>\n");}
        | enquanto {printf("<comando> -> <enquanto>\n");} 
        | leitura {printf("<comando> -> <leitura>\n");} 
        | escrita {printf("<comando> -> <escrita>\n");}
        ;
comando_aberto: IF expressao THEN comando 
        | IF expressao THEN comando_combinado ELSE comando_aberto
        ;
atribuicao: id ATRIBUTION expressao {printf("<atribuicao> ::= <identificador> := <expressao>\n");}
        ;
enquanto: WHILE expressao DO comando_combinado {printf("<enquanto> ::= enquanto <expressao> faca <comandos>\n");}
        ;
leitura: READ PARENTHESES_OPEN ID PARENTHESES_CLOSE {printf("<leitura> ::= leitura ( <identificador> )\n");}
        ;
escrita: WRITE PARENTHESES_OPEN ID PARENTHESES_CLOSE {printf("<escrita> ::= escrita ( <identificador> )\n");}
        ;
expressao: simples {printf("<expressao> ::= <simples>\n");} 
        | simples operador_relacional simples {printf("<expressao> ::= <simples> <op_relacional> <simples>\n");}
        ;
operador_relacional: OTHER {printf("<op_relacional> ::= <>\n");} 
        | EQUAL {printf("<op_relacional> ::= =\n");}
        | LESS {printf("<op_relacional> ::= <\n");}
        | GREATER {printf("<op_relacional> ::= >\n");}
        | LESS_EQUAL {printf("<op_relacional> ::= <=\n");}
        | GREATER_EQUAL {printf("<op_relacional> ::= >=\n");}
        ;
simples: Termo operador Termo {printf("<simples> ::= <termo> <operador> <termo>\n");}
        | Termo {printf("<simples> ::= <termo>\n");}
        ;
operador: PLUS {printf("<operador> ::= +\n");}
        | MINUS {printf("<operador> ::= -\n");}
        | OR {printf("<operador> ::= ou\n");}
        ;
Termo: fator {printf("<termo> ::= <fator>\n");}
        | fator op fator {printf("<termo> ::= <fator> <op> <fator>\n");}
        ;
op: MULT {printf("<op> ::= *\n");}
        | DIV {printf("<op> ::= div\n");}
        | AND {printf("<op> ::= e\n");}
        ;
fator: id {printf("<fator> ::= <fator>\n");}
        | num {printf("<fator> ::= <numero>\n");}
        | PARENTHESES_OPEN expressao PARENTHESES_CLOSE {printf("<fator> ::= ( <expressao> )\n");}
        | TRUE {printf("<fator> ::= verdadeirp\n");}
        | FALSE {printf("<fator> ::= false\n");}
        | NOT fator {printf("<fator> ::= nao <fator>\n");}
        ;
id: ID {printf("<identificador> ::= id\n");}
        ;
num: NUM {printf("<numero> ::= num\n");}
        ;
%%
