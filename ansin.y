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

S: PROGRAM identificador SEMICOLON bloco {clear_lista(list);}
  ;
bloco: VAR declaracao INIT comandos END {}
  ;
declaracao: nome_var COLON tipo SEMICOLON {}
        | nome_var COLON tipo SEMICOLON declaracao {}
        ;
nome_var: identificador {}
        | identificador COMMA nome_var {}
        ;
tipo: INTEGER {}
        | FLOAT {}
        | BOOLEAN {}
        ;
comandos: comando {}
        | comando SEMICOLON comandos {} 
        ;
comando: comando_combinado {}
        | comando_aberto {}
        ;
comando_aberto: IF expressao THEN comando {}
        | IF expressao THEN comando_combinado ELSE comando_aberto {}
        ;
comando_combinado: IF expressao THEN comando_combinado ELSE comando_combinado {}
        | atribuicao {}
        | enquanto {}
        | leitura {}
        | escrita {}
        ;
atribuicao: identificador ATRIB expressao {if(list == NULL || list->head == NULL){
        list = ini_lista();
} insert_node(list, $<lex_value>1, $<value>3);
}
        ;
enquanto: WHILE expressao DO comando_combinado {}
        ;
leitura: READ OPPAR ID CLPAR {}
        ;
escrita: WRITE OPPAR ID CLPAR {printf("%d\n", var_value(list, $<lex_value>3));}
        ;
expressao: simples {$<value>$ = $<value>1;} 
        | simples op_relacional simples {}
        ;
op_relacional: OTHER {}
        | EQUAL {}
        | LESS {}
        | GREATER {}
        | LESSEQ {}
        | GREATEREQ {}
        ;
simples: termo operador termo {
        // analisa o operador (2 valor léxico da palavra) para realizar a operação correta
        if(strcmp($<lex_value>2, "+") == 0){
                $<value>$ = $<value>1 + $<value>3;
        }else if(strcmp($<lex_value>2, "-") == 0){
                $<value>$ = $<value>1 - $<value>3;
        }
        }
        | termo {$<value>$ = $<value>1;}
        ;
operador: PLUS {}
        | MINUS {}
        | OR {}
        ;
termo: fator {$<value>$ = $<value>1;}
        | fator op fator {
                if(strcmp($<lex_value>2, "*") == 0){
                        $<value>$ = $<value>1 * $<value>3;
                }else if(strcmp($<lex_value>2 , "div") == 0){
                        $<value>$ = $<value>1 / $<value>3;
                }
        }
        ;
op: MULT {}
        | DIV {}
        | AND {}
        ;
fator: identificador {$<value>$ = var_value(list, $<lex_value>1);}
        | numero {$<value>$ = $<value>1;}
        | OPPAR expressao CLPAR {$<value>$ = $<value>2;}
        | TR {}
        | FS {}
        | NOT fator {}
        ;
identificador: ID {}
        ;
numero: NUM {$<value>$ = $<value>1;}
        ;
%%