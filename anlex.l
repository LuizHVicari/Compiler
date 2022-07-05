%option noyywrap

%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include "ansin.tab.h"
    int lines = 1;
    int errors = 0;
    extern YYSTYPE yylval;
%}

id [a-zA-Z][0-9a-zA-Z_]*
idErro {id}[^(\n\t" ")]+
booleano [01]
digito [0-9]+
inteiro "-"?{digito}
zeroErro "-"?[0]{digito}
zeroNegErro "-"[0]
real {inteiro}"."{digito}
digitoErro {digito}[^(\n\t" ")]+
prog "programa"

%%
\n                  {lines++;}
"{"[^}]*"}"         {}
[[:space:]]         {}
{prog}              {return PROGRAM;}
";"                 {return SEMICOLON;}

"var"               {return VAR;}
"inicio"            {return INIT;}
"fim"               {return END;}

":"                 {return COLON;}
","                 {return COMMA;}

"inteiro"           {return INTEGER;}
"real"              {return FLOAT;}
"booleano"          {return BOOLEAN;}

":="                {return ATRIB;}

"se"                {return IF;}
"entao"             {return THEN;}
"senao"             {return ELSE;}

"enquanto"          {return WHILE;}
"faca"              {return DO;}

"leia"              {return READ;}
"escreva"           {return WRITE;}

"("                 {return OPPAR;}  
")"                 {return CLPAR;} 

"<>"                {return OTHER;}
"="                 {return EQUAL;}
"<"                 {return LESS;}
">"                 {return GREATER;}
"<="                {return LESSEQ;}
">="                {return GREATEREQ;}

"+"                 {yylval.lex_value = strdup(yytext); return PLUS;}
"-"                 {yylval.lex_value = strdup(yytext); return MINUS;}
"ou"                {return OR;}

"*"                 {yylval.lex_value = strdup(yytext); return MULT;}
"div"               {yylval.lex_value = strdup(yytext); return DIV;}
"e"                 {return AND;}

"verdadeiro"        {return TR;}   
"falso"             {return FS;}
"nao"               {return NOT;}

{id}                {yylval.lex_value = strdup(yytext); return ID;}
{zeroErro}          {printf("Erro lexico na linha %d ", lines); errors++; return -1;} 
{zeroNegErro}       {printf("Erro lexico na linha %d ", lines); errors++; return -1;} 
{booleano}          {return NUM;}                  
{real}              {return NUM;} 
{inteiro}           {yylval.value = atoi(yytext); return NUM;}                  
{digitoErro}        {printf("Erro lexico na linha %d ", lines); errors++; return -1;} 
{idErro}            {printf("Erro lexico na linha %d ", lines); errors++; return -1;} 
.                   {printf("Erro lexico na linha %d ", lines); errors++; return -1;} 
%%