%option noyywrap

%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include "parser.tab.h"
    int line = 1;
    int errors = 0;
    extern int yylval;
%}
id [a-zA-Z][0-9a-zA-Z_]*
idErro {id}[^(\n\t" ")]+
booleano [01]
digito [0-9]+
inteiro "-"?{digito}
real {inteiro}"."{digito}
digitoErro {digito}[^(\n\t" ")]+

%%
[[:space:]] {} 
\n {line++;} 
"{"[^}]*"}" {} 

"programa" {return PROGRAM;}

"var" {return VAR;}

"inicio" {return INIT;}
"fim" {return END;}

"," {return COMMA;}  

":" {return COLON;}
";" {return SEMICOLON;}  

"inteiro" {return INTEGER;}
"real" {return REAL;}
"booleano" {return BOOLEAN;}

":=" {return ATRIBUTION;}

"se" {return IF;}
"entao" {return THEN;}
"senao" {return ELSE;}

"enquanto" {return WHILE;}
"faca" {return DO;}

"leia" {return READ;}
"escreva" {return WRITE;}

"<>" {return OTHER;}
"=" {return EQUAL;}
"<" {return LESS;}
">" {return GREATER;}
"<=" {return LESS_EQUAL;}
">=" {return GREATER_EQUAL;}

"+" {return PLUS;}
"-" {return MINUS;}
"ou" {return OR;}  

"*" {return MULT;}
"div" {return DIV;}
"e" {return AND;}

"(" {return PARENTHESES_OPEN;}  
")" {return PARENTHESES_CLOSE;}

"verdadeiro" {return TRUE;}   
"falso" {return FALSE;}
"nao" {return NOT;}

{inteiro} {return NUM;}                  
{real} {return NUM;} 
{booleano} {return NUM;}

{id} {return ID;}

{digitoErro} {errors++; return -1;} 
{idErro} {errors++; return -1;} 
. {errors++; return -1;} 
%%