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

prog "programa"
id [a-zA-Z][0-9a-zA-Z_]*
idErro {id}[^(\n\t" ")]+
digito [0-9]+
inteiro "-"?{digito}
real {inteiro}"."{digito}
booleano [01]

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
{inteiro}           {yylval.value = atoi(yytext); return NUM;}                  
{booleano}          {return NUM;}                  
{real}              {return NUM;} 
{idErro}            {printf("Erro lexico na linha %d ", lines); errors++; return -1;} 
.                   {printf("Erro lexico na linha %d ", lines); errors++; return -1;} 
%%