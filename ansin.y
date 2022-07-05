%{
#include <stdio.h>
#include <string.h>
#include "lista.h"
extern void yyerror(char const *message);
extern int yylex(void);
// importa a biblioteca para trabalhar com listas dinâmicas (criar as palavras da linguagem)
lista *list;

%}

%union{
        int value;
        char* lex_value;
}

%token PROGRAM SEMICOLON VAR INIT END COLON INTEGER FLOAT BOOLEAN ATRIB IF THEN ELSE WHILE DO READ WRITE OPPAR CLPAR OTHER EQUAL LESS GREATER LESSEQ GREATEREQ PLUS MINUS OR MULT DIV AND TR FS NOT COMMA NUM ID

%right NOT
%left MULT DIV
%left MINUS PLUS
%left LESS GREATER LESSEQ GREATEREQ
%left EQUAL OTHER
%left TR FS
%right ATRIB

%type <value> expressao simples termo fator identificador numero
%start S

%%

// $<value>$ = $<value>x: o termo que deriva a outro recebe o valor do termo da posição x da palavra

S: PROGRAM identificador SEMICOLON bloco {printf("<programa> := programa <identificador> ; <bloco>\nCorreto\n"); clear_lista(list);}
  ;
bloco: VAR declaracao INIT comandos END {printf("<bloco> := var <declaracao> inicio <comandos> fim\n");}
  ;
declaracao: nome_var COLON tipo SEMICOLON {printf("<declaracao> := <nome_var> : <tipo> ;\n");}
        | nome_var COLON tipo SEMICOLON declaracao {printf("<declaracao> := <nome_var> : <tipo> ; <declaracao>\n");}
        ;
nome_var: identificador {printf("<nome_var> := identificador\n");} 
        | identificador COMMA nome_var {printf("<nome_var> := identificador , <nome_var>\n");}
        ;
tipo: INTEGER {printf("<tipo> := inteiro\n");} 
        | FLOAT {printf("<tipo> := real\n");} 
        | BOOLEAN {printf("<tipo> := booleano\n");}
        ;
comandos: comando {printf("<comandos> := <comando> \n");} 
        | comando SEMICOLON comandos {printf("<comandos> := <comando> ; <comandos>\n");} 
        ;
comando: comando_combinado
        | comando_aberto
        ;
comando_aberto: IF expressao THEN comando 
        | IF expressao THEN comando_combinado ELSE comando_aberto
        ;
comando_combinado: IF expressao THEN comando_combinado ELSE comando_combinado 
        | atribuicao {printf("<comando> := <atribuicao>\n");}
        | enquanto {printf("<comando> := <enquanto>\n");} 
        | leitura {printf("<comando> := <leitura>\n");} 
        | escrita {printf("<comando> := <scrita>\n");}
        ;
atribuicao: identificador ATRIB expressao {printf("<atribuicao> := identificador <expressao> E\n"); if(list == NULL || list->head == NULL){
        list = ini_lista();
} insert_node(list, $<lex_value>1, $<value>3);
}
        ;
enquanto: WHILE expressao DO comando_combinado {printf("<repeticao> := enquanto E faca <comando>\n");}
        ;
leitura: READ OPPAR ID CLPAR {printf("<leitura> := leia ( <identificador> )\n");}
        ;
escrita: WRITE OPPAR ID CLPAR {printf("<escrita> := escreva (<identificador>)\n"); printf("%d\n", var_value(list, $<lex_value>3));}
        ;
expressao: simples {printf("<expressao> := <simples>\n");} 
        | simples op_relacional simples {printf("<expressao> := <simples> <op_relacional> <simples>\n"); $<value>$ = $<value>1;}
        ;
op_relacional: OTHER {printf("<op_relacional> := <>\n");} 
        | EQUAL {printf("<op_relacional> := =\n");}
        | LESS {printf("<op_relacional> := <\n");}
        | GREATER {printf("<op_relacional> := >\n");}
        | LESSEQ {printf("<op_relacional> := <=\n");}
        | GREATEREQ {printf("<op_relacional> := >=\n");}
        ;
simples: termo operador termo {printf("<simples> := <termo> <operador> <termo>\n");
        // analisa o operador (2 valor léxico da palavra) para realizar a operação correta
        if(strcmp($<lex_value>2, "+") == 0){
                $<value>$ = $<value>1 + $<value>3;
        }else if(strcmp($<lex_value>2, "-") == 0){
                $<value>$ = $<value>1 - $<value>3;
        }
        }
        | termo {printf("simples := <termo>\n"); $<value>$ = $<value>1;}
        ;
operador: PLUS {printf("<operador> := +\n");}
        | MINUS {printf("<operador> := -\n");}
        | OR {printf("<operador> := ou\n");}
        ;
termo: fator {printf("<termo> := <fator>\n"); $<value>$ = $<value>1;}
        | fator op fator {printf("<termo> := <fator> <op> <fator>\n");
                if(strcmp($<lex_value>2, "*") == 0){
                        $<value>$ = $<value>1 * $<value>3;
                }else if(strcmp($<lex_value>2 , "div") == 0){
                        $<value>$ = $<value>1 / $<value>3;
                }
        }
        ;
op: MULT {printf("<op> := * \n");}
        | DIV {printf("<op> := div \n");}
        | AND {printf("<op> := e \n");}
        ;
fator: identificador {printf("<fator> := <identificador> \n");
        $<value>$ = var_value(list, $<lex_value>1);
}
        | numero {printf("<fator> := <numero> \n");
                $<value>$ = $<value>1;
        }
        | OPPAR expressao CLPAR {printf("<fator> := ( expressao ) \n");
                $<value>$ = $<value>2;
        }
        | TR {printf("<fator> := verdadeiro \n");}
        | FS {printf("<fator> := falso \n");}
        | NOT fator {printf("<fator> := not <fator> \n");}
        ;
identificador: ID {printf("<identificador> := id \n");}
        ;
numero: NUM {printf("<numero> := num \n"); $<value>$ = $<value>1;}
        ;
%%